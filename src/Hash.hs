module Hash where

import qualified Data.List as L

class Hashable a where
    hashWithSalt :: Int -> a -> Int

    hash :: a -> Int
    hash = hashWithSalt defaultSalt

defaultSalt = -2578643520546668380



--------------------------------------------------------------------------

data HashMap k v
    = Empty
    | BitmapIndexed !Bitmap !(A.Array (HashMap k v))
    | Leaf !Hash !(Leaf k v)
    | Full !(A.Array (HashMap k v))
    | Collision !Hash !(A.Array (Leaf k v))


data Leaf k v = L !k v deriving (Eq)


fromListWith :: (Eq k, Hashable k) => (v -> v -> v) -> [(k, v)] -> HashMap k v
fromListWith f = L.foldl' (\ m (k, v) -> unsafeInsertWith f k v m) empty
{-# INLINE fromListWith #-}
