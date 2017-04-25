{-# LANGUAGE BangPatterns, MagicHash, UnboxedTuples, DefaultSignatures, TypeOperators, FlexibleContexts #-}

module Parallel
    (NFData, parMap, rdeepseq) where

--import Data.Traversable
import Control.Monad
import Data.Ratio
import GHC.Exts
import Data.Word

import GHC.Generics
import Control.DeepSeq


infixl 0 `using`

{-
class NFData a where
    rnf :: a -> ()

    default rnf :: (Generic a, GNFData (Rep a)) => a -> ()
    rnf = grnf . from


class GNFData f where
  grnf :: f a -> ()

instance GNFData U1 where
  grnf U1 = ()

instance NFData a => GNFData (K1 i a) where
  grnf = rnf . unK1
  {-# INLINEABLE grnf #-}

instance GNFData a => GNFData (M1 i c a) where
  grnf = grnf . unM1
  {-# INLINEABLE grnf #-}

instance (GNFData a, GNFData b) => GNFData (a :*: b) where
  grnf (x :*: y) = grnf x `seq` grnf y
  {-# INLINEABLE grnf #-}

instance (GNFData a, GNFData b) => GNFData (a :+: b) where
  grnf (L1 x) = grnf x
  grnf (R1 x) = grnf x
  {-# INLINEABLE grnf #-}




instance NFData Int      where rnf !_ = ()
instance NFData Word     where rnf !_ = ()
instance NFData Integer  where rnf !_ = ()
instance NFData Word64   where rnf !_ = ()

instance NFData Char     where rnf !_ = ()
instance NFData Bool     where rnf !_ = ()
instance NFData ()       where rnf !_ = ()


instance NFData a => NFData (Ratio a) where
  rnf !_ = ()


instance (NFData a, NFData b) => NFData (a,b) where
  rnf (x,y) = rnf x `seq` rnf y


instance NFData a => NFData [a] where
    rnf [] = ()
    rnf (x:xs) = rnf x `seq` rnf xs
-}

type Strategy a = a -> Eval a

newtype Eval a = Eval (State# RealWorld -> (# State# RealWorld, a #))



instance Functor Eval where
  fmap = liftM

instance Applicative Eval where
  pure x = Eval $ \s -> (# s, x #)
  (<*>)  = ap

instance Monad Eval where
  return = pure
  Eval x >>= k = Eval $ \s -> case x s of
                                (# s', a #) -> case k a of
                                                      Eval f -> f s'

rpar :: Strategy a
rpar  x = Eval $ \s -> spark# x s

rparWith :: Strategy a -> Strategy a
rparWith s a = do l <- rpar r; return (case l of Lift x -> x)
  where r = case s a of
              Eval f -> case f realWorld# of
                          (# _, a' #) -> Lift a'

data Lift a = Lift a

using :: a -> Strategy a -> a
x `using` strat = runEval (strat x)


rdeepseq :: NFData a => Strategy a
rdeepseq x = do rseq (rnf x); return x

parList :: Strategy a -> Strategy [a]
parList strat = traverse (rparWith strat)

parMap :: Strategy b -> (a -> b) -> [a] -> [b]
parMap strat f = (`using` parList strat) . map f


runEval :: Eval a -> a
runEval (Eval x) = case x realWorld# of (# _, a #) -> a

rseq :: Strategy a
rseq x = Eval $ \s -> seq# x s
