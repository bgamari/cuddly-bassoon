{-# LANGUAGE BangPatterns, CPP, PatternGuards #-}

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
import qualified Data.List as L
import Data.Hashable (Hashable)
import Prelude hiding (map)

import qualified Data.HashMap.Array as A
import qualified Data.HashMap.Base as HM
import Data.HashMap.Base (HashMap(..), Hash, Leaf(..)
    , empty, bitsPerSubkey, sparseIndex, mask, two, index, hash, bitmapIndexedOrFull
    , collision, update16, toList
    
    )
import Data.HashMap.Unsafe (runST)
import Control.DeepSeq

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

-- | In-place update version of insertWith
unsafeInsertWith :: (Eq k, Hashable k, NFData k, NFData v) => (v -> v -> v) -> k -> v -> HashMap k v
                 -> HashMap k v
unsafeInsertWith f k0 v0 m0 = rnf m0 `seq` runST (go h0 k0 v0 0 m0)
  where
    h0 = hash k0
    go !h !k x !_ Empty = return $! leaf h k x
    go h k x s (Leaf hy l@(L ky y))
        | hy == h = if ky == k
                    then return $! leaf h k (f x y)
                    else do
                        return $! collision h l (L k x)
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
      where m = mask h s
            i = sparseIndex b m
    go h k x s t@(Full ary) = do
        st <- A.indexM ary i
        st' <- go h k x (s+bitsPerSubkey) st
        A.unsafeUpdateM ary i st'
        return t
      where i = index h s
    go h k x s t@(Collision hy v)
        | h == hy   = return $! Collision h (updateOrSnocWith f k x v)
        | otherwise = go h k x s $ BitmapIndexed (mask hy s) (A.singleton t)
{-# INLINABLE unsafeInsertWith #-}


fromListWith :: (NFData k, NFData v, Eq k, Hashable k) => (v -> v -> v) -> [(k, v)] -> HashMap k v
fromListWith f = L.foldl' (\ !m (!k, !v) -> unsafeInsertWith f k v m) empty
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
