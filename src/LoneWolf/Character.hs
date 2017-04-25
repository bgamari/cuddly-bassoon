{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module LoneWolf.Character
    (
   
    Endurance(..), CombatSkill(..), Item(..), Slot(..), Discipline(..)

    ,  CharacterConstant(..), CharacterVariable(..)

    , curendurance, mkCharacter
    
    
    , Inventory(..), Weapon(..)
    )
    where

import GHC.Generics
import Data.Hashable
import Data.Word
import Lens
import Data.Bits
import Parallel


data Character = Character
    { _constantData :: CharacterConstant
    , _variableData :: CharacterVariable
    } deriving (Generic, Eq, Show)


newtype CombatSkill = CombatSkill { getCombatSkill :: Int }
  deriving (Show, Eq, Read, Num, Ord, Integral, Real, Enum, Generic, Bits)

newtype Endurance = Endurance { getEndurance :: Int }
  deriving (Show, Eq, Read, Num, Ord, Integral, Real, Enum, Generic, Bits, Hashable)

instance NFData Endurance

data CharacterConstant = CharacterConstant
      { _maxendurance :: Endurance
      } deriving (Generic, Eq, Show, Read)


newtype CharacterVariable = CharacterVariable { getCharacterVariable :: Word64 }
                          deriving (Generic, Eq, Bits, Hashable, NFData, Ord)

mkCharacter :: Endurance -> Inventory -> CharacterVariable
mkCharacter e i = CharacterVariable 0 & curendurance .~ e & equipment .~ i

instance Show CharacterVariable where
  show c = show (c ^. curendurance, c ^. equipment)

curendurance :: Lens' CharacterVariable Endurance
curendurance f (CharacterVariable w) = (\(Endurance ne) -> CharacterVariable ((w .&. 0xff00ffffffffffff) .|. (fromIntegral ne `shiftL` 48))) <$> f (fromIntegral ((w `shiftR` 48) .&. 0xff))
{-# INLINE curendurance #-}

equipment :: Lens' CharacterVariable Inventory
equipment f (CharacterVariable w) = const (CharacterVariable w) <$> f (Inventory 0)
{-# INLINE equipment #-}

newtype Inventory = Inventory { getInventory :: Word64 }
                    deriving (Generic, Eq, Bits, Hashable, NFData, Show)

data Discipline = Camouflage
                | Hunting
                | SixthSense
                | Tracking
                | Healing
                | WeaponSkill Weapon
                | MindShield
                | MindBlast
                | AnimalKinship
                | MindOverMatter
                deriving (Show, Eq, Generic, Read, Ord)

data Weapon = Dagger
            | Spear
            | Mace
            | ShortSword
            | Warhammer
            | Sword
            | Axe
            | Quarterstaff
            | BroadSword
            | MagicSpear
            | Sommerswerd
            deriving (Show, Eq, Generic, Ord, Enum, Bounded, Read)

data Item = Weapon !Weapon
          | Backpack
          | Helmet
          | Shield
          | Meal
          | ChainMail
          | HealingPotion
          | PotentPotion -- heals 5 after combat
          | Gold
          | Laumspur
          | TicketVol2
          | PasswordVol2
          | DocumentsVol2
          | SealHammerdalVol2
          | WhitePassVol2
          | RedPassVol2
          deriving (Show, Eq, Generic, Ord, Read)

instance Bounded Item where
  minBound = Backpack
  maxBound = Weapon maxBound

instance Enum Item where
  fromEnum x = case x of
    Backpack          -> 0
    Helmet            -> 1
    Shield            -> 2
    ChainMail         -> 3
    HealingPotion     -> 4
    PotentPotion      -> 5
    Laumspur          -> 6
    TicketVol2        -> 7
    PasswordVol2      -> 8
    DocumentsVol2     -> 9
    SealHammerdalVol2 -> 10
    WhitePassVol2     -> 11
    RedPassVol2       -> 12
    Gold              -> 13
    Meal              -> 14
    Weapon w          -> fromEnum w + 15

  toEnum n = case n of
    0  -> Backpack
    1  -> Helmet
    2  -> Shield
    3  -> ChainMail
    4  -> HealingPotion
    5  -> PotentPotion
    6  -> Laumspur
    7  -> TicketVol2
    8  -> PasswordVol2
    9  -> DocumentsVol2
    10 -> SealHammerdalVol2
    11 -> WhitePassVol2
    12 -> RedPassVol2
    13 -> Gold
    14 -> Meal
    _  -> Weapon (toEnum (n - 15))

instance Hashable Item
instance Hashable Weapon

data Slot = WeaponSlot
          | BackpackSlot
          | SpecialSlot
          | PouchSlot
          deriving (Show, Eq, Generic)
