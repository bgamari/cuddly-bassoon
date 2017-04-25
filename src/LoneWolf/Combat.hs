{-# LANGUAGE RankNTypes #-}
module LoneWolf.Combat (fight) where

import LoneWolf.Character
import LoneWolf.Chapter
import Solver

import qualified Memo
import Lens

fight :: CharacterConstant -> CharacterVariable -> FightDetails -> Probably Endurance
fight _ cvariable fdetails = regroup $ do
      let ohp = fdetails ^. fendurance
      ((php, _), p) <- fightVanillaM (cvariable ^. curendurance) ohp
      return (max 0 php, p)

fightVanillaM :: Endurance -> Endurance -> Probably (Endurance, Endurance)
fightVanillaM = Memo.memo2 Memo.bits Memo.bits fightVanilla

fightVanilla :: Endurance -> Endurance -> Probably (Endurance, Endurance)
fightVanilla php ohp
  | php <= 0 || ohp <= 0 = certain (max 0 php, max 0 ohp)
  | otherwise = regroup $ do
      (odmg, pdmg) <- [(9,3),(10,2),(11,2),(12,2),(14,1),(16,1),(18,0),(100,0),(100,0),(100,0)]
      fightVanillaM (php - pdmg) (ohp - odmg)
