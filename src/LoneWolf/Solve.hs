module LoneWolf.Solve
    (solveLW, startConstant, startVariable) where

import Solver (Solution(..), Score(..), solve, certain)
import LoneWolf.Choices (flattenDecision)
import LoneWolf.Chapter (ChapterId, Chapter(..))
import LoneWolf.Character
import LoneWolf.Rules
import qualified Memo
import Data.Word


startConstant :: CharacterConstant
startConstant = CharacterConstant 20

startVariable :: CharacterVariable
startVariable = mkCharacter 20 (Inventory 0)

memoState :: Memo.Memo NextStep
memoState = Memo.wrap fromWord64 toWord64 (Memo.pair Memo.bits Memo.bits)

toWord64 :: NextStep -> (Word16, Word64)
toWord64 s = case s of
                 HasLost -> (0, 0)
                 HasWon cvariable -> toWord64 (NewChapter 0 cvariable)
                 NewChapter cid (CharacterVariable cvalue)  ->
                    let cidb16 = fromIntegral cid
                    in  (cidb16, cvalue)

fromWord64 :: (Word16, Word64) -> NextStep
fromWord64 (0, 0) = HasLost
fromWord64 (cid16, cvalue) =
    let cvariable = CharacterVariable cvalue
    in NewChapter (fromIntegral cid16) cvariable

solveLW :: [(ChapterId, Chapter)] -> CharacterConstant -> CharacterVariable -> Solution NextStep String
solveLW book cconstant cvariable = solve memoState step getScore (NewChapter 1 cvariable)
  where
    chapters = book
    step (NewChapter cid curvariable ) = case lookup cid chapters of
                  Nothing -> error ("Unknown chapter: " ++ show cid)
                  Just (Chapter  d) -> do
                      (desc, outcome) <- flattenDecision cconstant curvariable d
                      return (unwords desc, update cconstant curvariable outcome)
    step (HasWon c) = [("won", certain (HasWon c))]
    step HasLost = [("lost", certain HasLost)]
    getScore ns = case ns of
                      NewChapter 200 _ -> Win 1 -- l
                      NewChapter 33 _ -> Win 1
                      NewChapter 88 _ -> Win 1
                      NewChapter 150 _ -> Win 1
                      NewChapter 265 _ -> Win 1
                      HasWon _ -> Win 1
                      HasLost -> Lose
                      _ -> Unknown

