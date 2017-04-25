{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE BangPatterns #-}


module Solver (Score(..), Proba, Probably, regroup, certain, Solution(..), solve, winStates) where

import qualified Memo
import Data.Ord (comparing)
import Data.List
import Data.Hashable
import qualified Data.HashMap.Strict as HM
import Parallel
import GHC.Generics
import Control.DeepSeq

type Proba = Rational
type Probably a = [(a, Proba)]
type Choice state description = [(description, Probably state)]

data Solution state description = Node { _desc :: description
                                       , _stt  :: state
                                       , _score :: Rational
                                       , _outcome :: Probably (Solution state description)
                                       }
                                | LeafLost
                                | LeafWin Rational state
                                deriving (Show, Eq, Generic)

instance (NFData state, NFData description) => NFData (Solution state description)

data Score = Lose | Win Rational | Unknown

certain :: a -> Probably a
certain a = [(a,1)]



regroup :: (NFData a, Show a, Hashable a, Eq a, Ord a) => Probably a -> Probably a
regroup xs =
    let xs' = HM.toList $ HM.fromListWith (+) xs
        !s' = sum (map snd xs')
        s  = sum (map snd xs)
     in if s' /= s
            then error $ "very bad" ++ show ("s'" :: String, s', "s" :: String, s)
            else xs'

winStates :: (Show state, NFData state, Eq state, Hashable state, Ord state) => Solution state description -> Probably state
winStates s = case s of
  LeafLost -> []
  LeafWin _ st -> certain st
  Node _ _ _ ps -> regroup $ concat $ parMap rdeepseq (\(o,p) -> fmap (*p) <$> winStates o) ps

getSolScore :: Solution state description -> Rational
getSolScore s = case s of
                 LeafLost -> 0
                 LeafWin x _ -> x
                 Node _ _ x _ -> x

solve ::  (NFData state, NFData description)
       => Memo.Memo state
       -> (state -> Choice state description) -- the choice function
       -> (state -> Score)
       -> state
       -> Solution state description
solve memo getChoice score = go
  where
    go = memo solve'
    solve' stt =
      case score stt of
          Lose -> LeafLost
          Win x -> LeafWin x stt
          Unknown -> if null choices
                      then LeafLost
                      else maximumBy (comparing getSolScore) scored
      where
        choices = getChoice stt
        scored = parMap rdeepseq scoreTree (getChoice stt)
        scoreTree (cdesc, pstates) = let ptrees = map (\(o, p) -> (go o, p)) pstates
                                     in Node cdesc stt (sum (map (\(o, p) -> p * getSolScore o) ptrees)) ptrees

