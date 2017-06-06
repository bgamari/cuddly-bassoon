{-# LANGUAGE BangPatterns, CPP, PatternGuards, MagicHash, UnboxedTuples #-}

#if __GLASGOW_HASKELL__ >= 702
{-# LANGUAGE Trustworthy #-}
#endif

module Data.HashMap.Strict
    (
      HashMap
    , toList
    , fromListWith
    ) where

import Data.Bits ((.&.), (.|.))
import Data.Word
import Data.Hashable (Hashable)
import Prelude hiding (map)

import qualified Data.HashMap.Array as A
import Data.HashMap.Base (HashMap(..), Hash, Leaf(..)
    , empty, bitsPerSubkey, sparseIndex, mask, two, index, hash, bitmapIndexedOrFull
    , collision, update16, toList
    )
import GHC.ST
import Data.HashMap.Unsafe hiding (runST)
import Control.DeepSeq

import Foreign.Storable
import GHC.Prim (traceEvent#)
import Control.Monad
import Control.Monad.ST.Unsafe
import GHC.Exts (Ptr(..))
import Data.Primitive
import Debug.Trace
import Data.STRef
import System.Breakpoint

insertWith :: (Eq k, Hashable k) => (v -> v -> v) -> k -> v -> HashMap k v
           -> HashMap k v
insertWith f k0 v0 m0 = go h0 k0 v0 0 m0
  where
    h0 = hash k0
    go !h !k x !_ Empty = leaf h k x
    go h k x s (Leaf hy l@(L ky y))
        | hy == h = if ky == k
                    then leaf h k (f x y)
                    else x `seq` (collision h l (L k x))
        | otherwise = x `seq` runST (two s h k x hy ky y)
    go h k x s (BitmapIndexed b ary)
        | b .&. m == 0 =
            let ary' = A.insert ary i $! leaf h k x
            in bitmapIndexedOrFull (b .|. m) ary'
        | otherwise =
            let st   = A.index ary i
                st'  = go h k x (s+bitsPerSubkey) st
                ary' = A.update ary i $! st'
            in BitmapIndexed b ary'
      where m = mask h s
            i = sparseIndex b m
    go h k x s (Full ary) =
        let st   = A.index ary i
            st'  = go h k x (s+bitsPerSubkey) st
            ary' = update16 ary i $! st'
        in Full ary'
      where i = index h s
    go h k x s t@(Collision hy v)
        | h == hy   = Collision h (updateOrSnocWith f k x v)
        | otherwise = go h k x s $ BitmapIndexed (mask hy s) (A.singleton t)
{-# INLINABLE insertWith #-}

traceWords :: Word -> Word -> ST s ()
traceWords a b = do
    ba <- newPinnedByteArray 17
    let !(Addr addr) = mutableByteArrayContents ba
    let ptr = Ptr addr
    unsafeIOToST $ do pokeElemOff ptr 1 a
                      pokeElemOff ptr 2 b
                      pokeElemOff ptr 16 (0::Word8)
    ST $ \s -> case traceEvent# addr s of s' -> (# s', () #)
    return ()

failOnDuplicate :: STRef s Bool -> ST s a -> ST s a
failOnDuplicate ref action = do
    a <- readSTRef ref
    when a $ do unsafeIOToST breakpoint >> fail "uh oh"
    writeSTRef ref True
    !r <- action
    writeSTRef ref False
    return r

-- | In-place update version of insertWith
unsafeInsertWith :: (Eq k, Hashable k, NFData k, NFData v, Show k)
                 => STRef s Bool -> (v -> v -> v) -> k -> v -> HashMap k v -> ST s (HashMap k v)
unsafeInsertWith ref f k0 v0 m0 = failOnDuplicate ref $ go h0 k0 v0 0 m0
  where
    h0 = hash k0
    go !h !k x !_ Empty = return $! leaf h k x
    go h k x s (Leaf hy l@(L ky y))
        | hy == h = if ky == k
                    then do traceWords h 0
                            return $! leaf h k (f x y)
                    else return $! collision h l (L k x)
        | otherwise = two s h k x hy ky y
    go h k x s t@(BitmapIndexed b ary)
        | b .&. m == 0 = do
            let ary' = A.insert ary i $! leaf h k x
            return $! bitmapIndexedOrFull (b .|. m) ary'
        | otherwise = do
            st <- A.indexM ary i
            st' <- rnf x `seq` go h k x (s+bitsPerSubkey) st
            A.unsafeUpdateM ary i st'
            return t
            --ary' <- A.updateM ary i st'
            --return (BitmapIndexed b ary')
      where m = mask h s
            i = sparseIndex b m
    go h k x s t@(Full ary) = do
        st <- A.indexM ary i
        st' <- go h k x (s+bitsPerSubkey) st
        --A.unsafeUpdateM ary i st'
        --return t
        ary' <- A.updateM ary i st'
        return (Full ary')
      where i = index h s
    go h k x s t@(Collision hy v)
        | h == hy   = return $! Collision h (updateOrSnocWith f k x v)
        | otherwise = go h k x s $ BitmapIndexed (mask hy s) (A.singleton t)
{-# INLINABLE unsafeInsertWith #-}


fromListWith :: (NFData k, NFData v, Eq k, Hashable k, Show k)
             => (v -> v -> v) -> [(k, v)] -> HashMap k v
fromListWith f xs0 = runST $ do
    ref <- newSTRef False
    go ref empty xs0
  where
    go ref m ((k,v) : xs) = do m' <- unsafeInsertWith ref f k v m
                               go ref m' xs
    go _ m [] = return m
{-# INLINE fromListWith #-}

updateOrSnocWith :: Eq k => (v -> v -> v) -> k -> v -> A.Array (Leaf k v)
                 -> A.Array (Leaf k v)
updateOrSnocWith f = updateOrSnocWithKey (const f)
{-# INLINABLE updateOrSnocWith #-}

updateOrSnocWithKey :: Eq k => (k -> v -> v -> v) -> k -> v -> A.Array (Leaf k v)
                 -> A.Array (Leaf k v)
updateOrSnocWithKey f k0 v0 ary0 = go k0 v0 ary0 0 (A.length ary0)
  where
    go !k v !ary !i !n
        | i >= n = A.run $ do
            -- Not found, append to the end.
            mary <- A.new_ (n + 1)
            A.copy ary 0 mary 0 n
            let !l = v `seq` (L k v)
            A.write mary n l
            return mary
        | otherwise = case A.index ary i of
            (L kx y) | k == kx   -> let !v' = f k v y in A.update ary i (L k v')
                     | otherwise -> go k v ary (i+1) n
{-# INLINABLE updateOrSnocWithKey #-}

leaf :: Hash -> k -> v -> HashMap k v
leaf h k !v = Leaf h (L k v)
{-# INLINE leaf #-}
