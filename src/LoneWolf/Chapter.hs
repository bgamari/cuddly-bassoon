{-# LANGUAGE RankNTypes #-}

module LoneWolf.Chapter
    
    where

import LoneWolf.Character
import Solver


type ChapterId = Int
type Rounds = Int
type Price = Int


type Lens' b a = forall f. Functor f => (a -> f a) -> b -> f b


data Chapter = Chapter { _pchoice :: Decision
                       } deriving (Show, Eq)


data Decision
   = Decisions [(String, Decision)]
   | CanTake Item Int Decision
   | Canbuy Item Price Decision
   | Cansell Item Price Decision
   | NoDecision ChapterOutcome
   | EvadeFight Rounds ChapterId FightDetails ChapterOutcome
   | AfterCombat Decision
   | Special SpecialChapter
   deriving (Show, Eq)


data SpecialChapter = Cartwheel
                     | Portholes
                     deriving (Show, Eq)


data ChapterOutcome
        = Fight FightDetails ChapterOutcome
        | Randomly [(Proba, ChapterOutcome)]
        | Conditionally [(ChapterOutcome)]
        | Simple [SimpleOutcome] ChapterOutcome
        | Goto ChapterId
        | GameLost
        | GameWon
        deriving (Show, Eq)

data SimpleOutcome
        = DamagePlayer Endurance
        | HealPlayer Endurance
        | FullHeal
        | HalfHeal
        | GainItem Item Int
        | LoseItem Item Int
        | LoseItemKind [Slot]
        | MustEat CanHunt
        deriving (Show, Eq)


data CanHunt = Hunt | NoHunt
             deriving (Show, Eq)

data FightDetails = FightDetails { _fendurance   :: Endurance } deriving (Show, Eq)


fendurance :: Lens' FightDetails Endurance
fendurance f  e = (\e' -> e { _fendurance = e'}) <$> f (_fendurance e)
