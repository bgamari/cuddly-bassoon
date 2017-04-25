{-# LANGUAGE BangPatterns, CPP, DeriveDataTypeable, MagicHash #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE PatternGuards #-}
#if __GLASGOW_HASKELL__ >= 708
{-# LANGUAGE RoleAnnotations #-}
{-# LANGUAGE TypeFamilies #-}
#endif
{-# OPTIONS_GHC -fno-full-laziness -funbox-strict-fields #-}

module Data.HashMap.Base


 (HashMap(..), Hash, Leaf(..)
    , empty, bitsPerSubkey, sparseIndex, mask, two, index, hash, bitmapIndexedOrFull
    , collision, update16, toList
    
    )
    where

import Control.DeepSeq (NFData(rnf))
import Control.Monad.ST (ST)
import Data.Bits ((.&.), (.|.), complement)
import GHC.Exts (build)
import Prelude hiding (filter, foldr, lookup, map, null, pred)

import qualified Data.HashMap.Array as A
import qualified Data.Hashable as H
import Data.HashMap.PopCount (popCount)
import Data.HashMap.Unsafe (runST)
import Data.HashMap.UnsafeShift (unsafeShiftL, unsafeShiftR)
import Data.Typeable (Typeable)

-- | Convenience function.  Compute a hash value for the given value.
hash :: H.Hashable a => a -> Hash
hash = fromIntegral . H.hash

data Leaf k v = L !k v
  deriving (Eq)

instance (NFData k, NFData v) => NFData (Leaf k v) where
    rnf (L k v) = rnf k `seq` rnf v

data HashMap k v
    = Empty
    | BitmapIndexed !Bitmap !(A.Array (HashMap k v))
    | Leaf !Hash !(Leaf k v)
    | Full !(A.Array (HashMap k v))
    | Collision !Hash !(A.Array (Leaf k v))
      deriving (Typeable)

instance (NFData k, NFData v) => NFData (HashMap k v) where
    rnf Empty                 = ()
    rnf (BitmapIndexed _ ary) = rnf ary
    rnf (Leaf _ l)            = rnf l
    rnf (Full ary)            = rnf ary
    rnf (Collision _ ary)     = rnf ary

type Hash   = Word
type Bitmap = Word
type Shift  = Int


instance (Show k, Show v) => Show (HashMap k v) where
    showsPrec d m = showParen (d > 10) $
      showString "fromList " . shows (toList m)





------------------------------------------------------------------------
-- * Construction

-- | /O(1)/ Construct an empty map.
empty :: HashMap k v
empty = Empty

-- | Create a 'Collision' value with two 'Leaf' values.
collision :: Hash -> Leaf k v -> Leaf k v -> HashMap k v
collision h e1 e2 =
    let v = A.run $ do mary <- A.new 2 e1
                       A.write mary 1 e2
                       return mary
    in Collision h v
{-# INLINE collision #-}

-- | Create a 'BitmapIndexed' or 'Full' node.
bitmapIndexedOrFull :: Bitmap -> A.Array (HashMap k v) -> HashMap k v
bitmapIndexedOrFull b ary
    | b == fullNodeMask = Full ary
    | otherwise         = BitmapIndexed b ary
{-# INLINE bitmapIndexedOrFull #-}


-- | Create a map from two key-value pairs which hashes don't collide.
two :: Shift -> Hash -> k -> v -> Hash -> k -> v -> ST s (HashMap k v)
two = go
  where
    go s h1 k1 v1 h2 k2 v2
        | bp1 == bp2 = do
            st <- go (s+bitsPerSubkey) h1 k1 v1 h2 k2 v2
            ary <- A.singletonM st
            return $! BitmapIndexed bp1 ary
        | otherwise  = do
            mary <- A.new 2 $ Leaf h1 (L k1 v1)
            A.write mary idx2 $ Leaf h2 (L k2 v2)
            ary <- A.unsafeFreeze mary
            return $! BitmapIndexed (bp1 .|. bp2) ary
      where
        bp1  = mask h1 s
        bp2  = mask h2 s
        idx2 | index h1 s < index h2 s = 1
             | otherwise               = 0
{-# INLINE two #-}

-- | /O(n)/ Reduce this map by applying a binary operator to all
-- elements, using the given starting value (typically the
-- right-identity of the operator).
foldrWithKey :: (k -> v -> a -> a) -> a -> HashMap k v -> a
foldrWithKey f = go
  where
    go z Empty                 = z
    go z (Leaf _ (L k v))      = f k v z
    go z (BitmapIndexed _ ary) = A.foldr (flip go) z ary
    go z (Full ary)            = A.foldr (flip go) z ary
    go z (Collision _ ary)     = A.foldr (\ (L k v) z' -> f k v z') z ary
{-# INLINE foldrWithKey #-}

------------------------------------------------------------------------
-- * Filter


-- | /O(n)/ Return a list of this map's elements.  The list is
-- produced lazily. The order of its elements is unspecified.
toList :: HashMap k v -> [(k, v)]
toList t = build (\ c z -> foldrWithKey (curry c) z t)
{-# INLINE toList #-}

-- | /O(n)/ Update the element at the given position in this array.
update16 :: A.Array e -> Int -> e -> A.Array e
update16 ary idx b = runST (update16M ary idx b)
{-# INLINE update16 #-}

-- | /O(n)/ Update the element at the given position in this array.
update16M :: A.Array e -> Int -> e -> ST s (A.Array e)
update16M ary idx b = do
    mary <- clone16 ary
    A.write mary idx b
    A.unsafeFreeze mary
{-# INLINE update16M #-}

-- | Unsafely clone an array of 16 elements.  The length of the input
-- array is not checked.
clone16 :: A.Array e -> ST s (A.MArray s e)
clone16 ary =
#if __GLASGOW_HASKELL__ >= 702
    A.thaw ary 0 16
#else
    do mary <- A.new_ 16
       A.indexM ary 0 >>= A.write mary 0
       A.indexM ary 1 >>= A.write mary 1
       A.indexM ary 2 >>= A.write mary 2
       A.indexM ary 3 >>= A.write mary 3
       A.indexM ary 4 >>= A.write mary 4
       A.indexM ary 5 >>= A.write mary 5
       A.indexM ary 6 >>= A.write mary 6
       A.indexM ary 7 >>= A.write mary 7
       A.indexM ary 8 >>= A.write mary 8
       A.indexM ary 9 >>= A.write mary 9
       A.indexM ary 10 >>= A.write mary 10
       A.indexM ary 11 >>= A.write mary 11
       A.indexM ary 12 >>= A.write mary 12
       A.indexM ary 13 >>= A.write mary 13
       A.indexM ary 14 >>= A.write mary 14
       A.indexM ary 15 >>= A.write mary 15
       return mary
#endif

------------------------------------------------------------------------
-- Bit twiddling

bitsPerSubkey :: Int
bitsPerSubkey = 4

maxChildren :: Int
maxChildren = fromIntegral $ 1 `unsafeShiftL` bitsPerSubkey

subkeyMask :: Bitmap
subkeyMask = 1 `unsafeShiftL` bitsPerSubkey - 1

sparseIndex :: Bitmap -> Bitmap -> Int
sparseIndex b m = popCount (b .&. (m - 1))

mask :: Word -> Shift -> Bitmap
mask w s = 1 `unsafeShiftL` index w s
{-# INLINE mask #-}

-- | Mask out the 'bitsPerSubkey' bits used for indexing at this level
-- of the tree.
index :: Hash -> Shift -> Int
index w s = fromIntegral $ (unsafeShiftR w s) .&. subkeyMask
{-# INLINE index #-}

-- | A bitmask with the 'bitsPerSubkey' least significant bits set.
fullNodeMask :: Bitmap
fullNodeMask = complement (complement 0 `unsafeShiftL` maxChildren)
{-# INLINE fullNodeMask #-}
