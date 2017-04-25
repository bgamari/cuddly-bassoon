{-# LANGUAGE TupleSections #-}
module LoneWolf.Choices (flattenDecision) where


import LoneWolf.Character (CharacterConstant(..), CharacterVariable(..))
import LoneWolf.Chapter (Decision(..), ChapterOutcome(..))


flattenDecision :: CharacterConstant -> CharacterVariable -> Decision -> [([String], ChapterOutcome)]
flattenDecision cconstant cvariable d = case d of
        AfterCombat nxt   -> flattenDecision cconstant cvariable nxt
        NoDecision o -> [([], o)]
        EvadeFight _ _ fdetails co -> [ ([], Fight fdetails co) ]
        Decisions lst -> do
            (desc, d') <- lst
            (alldesc, o) <- flattenDecision cconstant cvariable d'
            return (desc : alldesc, o)
        CanTake _ _ nxt -> flattenDecision cconstant cvariable nxt

        _ -> []
