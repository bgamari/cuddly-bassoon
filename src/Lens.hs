{-# LANGUAGE RankNTypes #-}

module Lens where

import Data.Functor.Identity
import Control.Applicative


(&) :: a -> (a -> b) -> b
a & f = f a
infixl 1 &

(.~) = set

type Lens' b a = forall f. Functor f => (a -> f a) -> b -> f b

set l b = runIdentity . l (\_ -> Identity b)

s ^. l = getConst ( l Const s)
