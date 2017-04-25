module LoneWolf.Book02 where

import Data.Ratio
import LoneWolf.Chapter
import LoneWolf.Character

chapters :: [(ChapterId, Chapter)]
chapters =
  [ ( 1
    , Chapter
        (Decisions
           [ ( ""
             , NoDecision (Goto 273))
           , ( ""
             , NoDecision (Goto 160))
           ]))
  , ( 2
    , Chapter
        (NoDecision
           (Conditionally
              [(Goto 42), (Goto 168)])))
  , ( 3
    , Chapter
        (Decisions
           [ ( ""
             , NoDecision (Goto 150))
           , ( ""
             , NoDecision (Goto 19))
           ]))
  , ( 4
    , Chapter
        (Decisions
           [ ( ""
             , NoDecision (Goto 104))
           , ( ""
             , NoDecision (Goto 342))
           , ( ""
             , NoDecision (Goto 276))
           ]))
  , ( 5
    , Chapter
        (NoDecision
           (Fight
              (FightDetails
               { _fendurance = Endurance {getEndurance = 20}
               })
              (Goto 166))))
  , ( 6
    , Chapter
        (Decisions
           [ ( ""
             , NoDecision (Goto 266))
           , ( ""
             , NoDecision (Goto 310))
           ]))
  , ( 7
    , Chapter
        (NoDecision
           (Fight
              (FightDetails
               { _fendurance = Endurance {getEndurance = 30}
               })
              (Goto 33))))
  , ( 8
    , Chapter
        (NoDecision GameLost))
  , ( 9
    , Chapter
        (NoDecision (Goto 196)))
  , ( 10
    , Chapter
        (CanTake
           TicketVol2
           1
           (NoDecision
              (Randomly
                 [(2 % 5, Goto 51), (3 % 10, Goto 195), (3 % 10, Goto 339)]))))
  , ( 11
    , Chapter
        (NoDecision GameLost))
  , ( 12
    , Chapter
        (Decisions
           [ ( ""
             , 
                 (NoDecision
                    (Randomly
                       [(1 % 5, Goto 58), (3 % 10, Goto 167), (1 % 2, Goto 329)])))
           , ( ""
             , 
                 (NoDecision
                    (Randomly
                       [ (2 % 5, Goto 58)
                       , (3 % 10, Goto 167)
                       , (3 % 10, Goto 329)
                       ])))
           ]))
  , ( 13
    , Chapter
        (NoDecision (Goto 155)))
  , ( 14
    , Chapter
        (NoDecision (Goto 305)))
  , ( 15
    , Chapter
        (CanTake
           Backpack
           1
           (CanTake
              (Weapon BroadSword)
              1
              (CanTake
                 (Weapon Mace)
                 1
                 (CanTake
                    (Weapon Quarterstaff)
                    1
                    (CanTake
                       HealingPotion
                       1
                       (CanTake Meal 3 (CanTake Gold 12 (NoDecision (Goto 244))))))))))
  , ( 16
    , Chapter
        (NoDecision (Goto 268)))
  , ( 17
    , Chapter
        (NoDecision
           (Simple
              [DamagePlayer (Endurance {getEndurance = 5})]
              (Fight
                 (FightDetails
                  { _fendurance = Endurance {getEndurance = 30}
                  })
                 (Goto 166)))))
  , ( 18
    , Chapter
        (Decisions
           [ ( ""
             , NoDecision (Goto 173))
           , ( ""
             , NoDecision (Goto 266))
           , ( ""
             , NoDecision (Goto 310))
           ]))
  , ( 19
    , Chapter
        (NoDecision (Goto 71)))
  , ( 20
    , Chapter
        (NoDecision (Goto 186)))
  , ( 21
    , Chapter
        (NoDecision
           (Randomly
              [ (1 % 10, Simple [GainItem Gold 2] (Goto 314))
              , (1 % 10, Simple [GainItem Gold 5] (Goto 314))
              , (1 % 10, Simple [GainItem Gold 8] (Goto 314))
              , (1 % 10, Simple [GainItem Gold 11] (Goto 314))
              , (1 % 10, Simple [GainItem Gold 14] (Goto 314))
              , (1 % 10, Simple [GainItem Gold 17] (Goto 314))
              , (1 % 10, Simple [GainItem Gold 20] (Goto 314))
              , (1 % 10, Simple [GainItem Gold 23] (Goto 314))
              , (1 % 10, Simple [GainItem Gold 26] (Goto 314))
              , (1 % 10, Simple [GainItem Gold 29] (Goto 314))
              ])))
  , ( 22
    , Chapter
        (NoDecision (Randomly [(1 % 2, Goto 119), (1 % 2, Goto 341)])))
  , ( 23
    , Chapter
        (NoDecision
           (Conditionally
              [(Goto 144), (Goto 295)])))
  , ( 24
    , Chapter
        (Decisions
           [ ( ""
             , NoDecision (Goto 177))
           , ( ""
             , NoDecision (Goto 253))
           , ( ""
             , NoDecision (Goto 319))
           ]))
  , ( 25
    , Chapter
        (NoDecision
           (Conditionally
              [ ( Goto 116)
              , (Goto 153)
              ])))
  , ( 26
    , Chapter
        (Decisions
           [ ( ""
             , NoDecision (Goto 248))
           , ( ""
             , NoDecision (Goto 66))
           ]))
  , ( 27
    , Chapter
        (NoDecision
           (Simple [HealPlayer (Endurance {getEndurance = 2})] (Goto 312))))
  , ( 28
    , Chapter
        (Decisions
           [ ( ""
             , NoDecision (Goto 106))
           , ( ""
             , NoDecision (Goto 320))
           ]))
  , ( 29
    , Chapter
        (NoDecision
           (Simple [DamagePlayer (Endurance {getEndurance = 2})] (Goto 222))))
  , ( 30
    , Chapter
        (NoDecision
           (Fight
              (FightDetails
               { _fendurance = Endurance {getEndurance = 16}
               })
              (Goto 258))))
  , ( 31
    , Chapter
        (NoDecision
           (Simple
              [HealPlayer (Endurance {getEndurance = 6})]
              (Randomly [(1 % 2, Goto 176), (1 % 2, Goto 254)]))))
  , ( 32
    , Chapter
        (NoDecision (Simple [MustEat Hunt] (Goto 186))))
  , ( 33
    , Chapter
        (Decisions
           [ ("", NoDecision (Goto 296))
           , ( ""
             , NoDecision (Goto 88))
           ]))
  , ( 34
    , Chapter
        (NoDecision
           (Fight
              (FightDetails
               { _fendurance = Endurance {getEndurance = 14}
               })
              (Goto 345))))
  , ( 35
    , Chapter
        (Decisions
           [ ( ""
             ,  (NoDecision (Goto 13)))
           , ( ""
             , 
                 (NoDecision (Goto 155)))
           , ( ""
             , 
                 (NoDecision (Goto 293)))
           ]))
  , ( 36
    , Chapter
        (NoDecision
           (Conditionally
              [ (Goto 145)
              , (Goto 210)
              , (Goto 275)
              ])))
  , ( 37
    , Chapter
        (Decisions
           [ ( ""
             , NoDecision (Simple [MustEat Hunt] (Goto 122)))
           , ( ""
             , NoDecision (Simple [MustEat Hunt] (Goto 323)))
           , ( ""
             , NoDecision (Simple [MustEat Hunt] (Goto 257)))
           ]))
  , ( 38
    , Chapter
        (Decisions
           [ ( ""
             , NoDecision (Goto 269))
           , ( ""
             , NoDecision (Goto 313))
           ]))
  , ( 39
    , Chapter
        (NoDecision
           (Conditionally
              [(Goto 346), (Goto 156)])))
  , ( 40
    , Chapter
        (NoDecision
           (Simple
              [GainItem PotentPotion 1, FullHeal]
              (Conditionally
                 [(Goto 97), (Goto 242)]))))
  , ( 41
    , Chapter
        (Decisions
           [ ( ""
             , NoDecision
                 (Simple [HealPlayer (Endurance {getEndurance = 1})] (Goto 194)))
           , ( ""
             , NoDecision (Goto 251))
           ]))
  , ( 42
    , Chapter
        (NoDecision (Goto 168)))
  , ( 43
    , Chapter
        (NoDecision (Goto 286)))
  , ( 44
    , Chapter
        (NoDecision GameLost))
  , ( 45
    , Chapter
        (NoDecision (Randomly [(4 % 5, Goto 311), (1 % 5, Goto 159)])))
  , ( 46
    , Chapter
        (Decisions
           [ ( ""
             , NoDecision (Goto 214))
           , ( ""
             , NoDecision (Goto 230))
           ]))
  , ( 47
    , Chapter
        (NoDecision
           (Conditionally
              [(Goto 111), (Goto 307)])))
  , ( 48
    , Chapter
        (NoDecision (Goto 268)))
  , ( 49
    , Chapter
        (NoDecision (Goto 100)))
  , ( 50
    , Chapter
        (NoDecision (Goto 249)))
  , ( 51
    , Chapter
        (Decisions
           [ ( ""
             , NoDecision (Goto 103))
           , ( ""
             , NoDecision (Goto 249))
           ]))
  , ( 52
    , Chapter
        (NoDecision
           (Conditionally
              [ (Goto 338)
              , (Goto 234)
              ])))
  , ( 53
    , Chapter
        (Decisions
           [ ( ""
             , NoDecision (Goto 321))
           , ( ""
             , NoDecision (Goto 154))
           ]))
  , ( 54
    , Chapter
        (NoDecision GameLost))
  , ( 55
    , Chapter
        (Canbuy
           (Weapon BroadSword)
           12
           (Decisions
              [ ( ""
                , NoDecision (Goto 347))
              , ( ""
                , NoDecision (Goto 3))
              ])))
  , ( 56
    , Chapter
        (NoDecision (Goto 127)))
  , ( 57
    , Chapter
        (NoDecision
           (Randomly
              [ (1 % 10, Simple [LoseItem Gold 1] (Goto 282))
              , (1 % 10, Simple [LoseItem Gold 2] (Goto 282))
              , (1 % 10, Simple [LoseItem Gold 3] (Goto 282))
              , (1 % 10, Simple [LoseItem Gold 4] (Goto 282))
              , (1 % 10, Simple [LoseItem Gold 5] (Goto 282))
              , (1 % 10, Simple [LoseItem Gold 6] (Goto 282))
              , (1 % 10, Simple [LoseItem Gold 7] (Goto 282))
              , (1 % 10, Simple [LoseItem Gold 8] (Goto 282))
              , (1 % 10, Simple [LoseItem Gold 9] (Goto 282))
              , (1 % 10, Simple [LoseItem Gold 10] (Goto 282))
              ])))
  , ( 58
    , Chapter
        (NoDecision (Goto 197)))
  , ( 59
    , Chapter
        (NoDecision
           (Conditionally
              [ (Goto 332)
              , (Goto 311)
              ])))
  , ( 60
    , Chapter
        (NoDecision
           (Fight
              (FightDetails
               { _fendurance = Endurance {getEndurance = 11}
               })
              (Goto 76))))
  , ( 61
    , Chapter
        (NoDecision (Goto 181)))
  , ( 63
    , Chapter
        (Decisions
           [ ( ""
             ,  (NoDecision (Goto 264)))
           , ( ""
             , 
                 (NoDecision (Goto 188)))
           , ( ""
             , 
                 (NoDecision (Goto 201)))
           ]))
  , ( 64
    , Chapter
        (Decisions
           [ ( ""
             ,  (NoDecision (Goto 229)))
           , ( ""
             , 
                 (NoDecision (Goto 134)))
           , ( ""
             , 
                 (NoDecision (Goto 208)))
           ]))
  , ( 65
    , Chapter
        (NoDecision (Goto 32)))
  , ( 66
    , Chapter
        (NoDecision
           (Fight
              (FightDetails
               { _fendurance = Endurance {getEndurance = 15}
               })
              (Goto 218))))
  , ( 67
    , Chapter
        (NoDecision (Goto 300)))
  , ( 68
    , Chapter
        (NoDecision (Goto 306)))
  , ( 69
    , Chapter
        (NoDecision
           (Conditionally
              [ (Goto 311)
              , ( Simple
                    [DamagePlayer (Endurance {getEndurance = 2})]
                    (Goto 311))
              ])))
  , ( 70
    , Chapter
        (NoDecision (Goto 44)))
  , ( 71
    , Chapter
        (Decisions
           [ ( ""
             , NoDecision (Goto 11))
           , ( ""
             , NoDecision (Goto 54))
           , ( ""
             , NoDecision (Goto 235))
           ]))
  , ( 72
    , Chapter
        (Decisions
           [ ( ""
             , NoDecision
                 (Simple [HealPlayer (Endurance {getEndurance = 1})] (Goto 226)))
           , ( ""
             , NoDecision
                 (Simple [HealPlayer (Endurance {getEndurance = 1})] (Goto 56)))
           , ( ""
             , NoDecision
                 (Simple [HealPlayer (Endurance {getEndurance = 1})] (Goto 276)))
           ]))
  , ( 73
    , Chapter
        (NoDecision (Goto 336)))
  , ( 74
    , Chapter
        (NoDecision (Goto 240)))
  , ( 76
    , Chapter
        (CanTake (Weapon Dagger) 1 (CanTake Gold 2 (NoDecision (Goto 33)))))
  , ( 77
    , Chapter
        (Decisions
           [ ( ""
             , NoDecision (Goto 320))
           , ( ""
             , NoDecision (Goto 28))
           ]))
  , ( 78
    , Chapter
        (Decisions
           [ ( ""
             , NoDecision
                 (Simple
                    [ DamagePlayer (Endurance {getEndurance = 1})
                    , LoseItem ChainMail 99
                    ]
                    (Goto 278)))
           , ( ""
             , NoDecision
                 (Simple
                    [ DamagePlayer (Endurance {getEndurance = 1})
                    , LoseItem ChainMail 99
                    ]
                    (Goto 337)))
           ]))
  , ( 79
    , Chapter
        (CanTake (Weapon Sommerswerd) 1 (NoDecision (Goto 40))))
  , ( 80
    , Chapter
        (Decisions
           [ ( ""
             ,  (NoDecision (Goto 15)))
           , ( ""
             , NoDecision (Goto 189))
           ]))
  , ( 81
    , Chapter
        (NoDecision (Randomly [(1 % 2, Goto 260), (1 % 2, Goto 281)])))
  , ( 82
    , Chapter
        (Decisions
           [ ( ""
             , NoDecision (Goto 55))
           , ( ""
             , NoDecision (Goto 347))
           ]))
  , ( 83
    , Chapter
        (Decisions
           [ ( ""
             , NoDecision (Goto 227))
           , ( ""
             , NoDecision (Goto 297))
           ]))
  , ( 85
    , Chapter
        (NoDecision
           (Fight
              (FightDetails
               { _fendurance = Endurance {getEndurance = 27}
               })
              (Goto 124))))
  , ( 86
    , Chapter
        (CanTake
           (Weapon Mace)
           1
           (CanTake
              Gold
              3
              (Decisions
                 [ ( ""
                   , NoDecision (Goto 215))
                 , ( ""
                   , NoDecision (Goto 303))
                 , ( ""
                   , NoDecision (Goto 129))
                 ]))))
  , ( 87
    , Chapter
        (NoDecision GameLost))
  , ( 88
    , Chapter
        (Decisions
           [ ( ""
             ,  (NoDecision (Goto 179)))
           , ( ""
             , NoDecision (Goto 150))
           , ( ""
             , NoDecision (Goto 71))
           ]))
  , ( 89
    , Chapter
        (Decisions
           [ ( ""
             , NoDecision (Goto 233))
           , ("", NoDecision (Goto 212))
           ]))
  , ( 90
    , Chapter
        (EvadeFight
           0
           132
           (FightDetails
            { _fendurance = Endurance {getEndurance = 16}
            })
           (Fight
              (FightDetails
               { _fendurance = Endurance {getEndurance = 9}
               })
              (Fight
                 (FightDetails
                  { _fendurance = Endurance {getEndurance = 14}
                  })
                 (Fight
                    (FightDetails
                     {  _fendurance = Endurance {getEndurance = 8}
                     })
                    (Fight
                       (FightDetails
                        {  _fendurance = Endurance {getEndurance = 17}
                        })
                       (Goto 274)))))))
  , ( 91
    , Chapter
        (Decisions
           [ ( ""
             , CanTake Backpack 1 (CanTake Meal 1 (NoDecision (Goto 245))))
           , ( ""
             , CanTake
                 (Weapon Quarterstaff)
                 1
                 (CanTake Backpack 1 (NoDecision (Goto 245))))
           , ( ""
             , CanTake
                 (Weapon Quarterstaff)
                 1
                 (CanTake Meal 1 (NoDecision (Goto 245))))
           , ( ""
             , CanTake Meal 1 (CanTake Meal 1 (NoDecision (Goto 245))))
           , ( ""
             , CanTake
                 (Weapon Dagger)
                 1
                 (CanTake Backpack 1 (NoDecision (Goto 245))))
           , ( ""
             , CanTake
                 (Weapon Dagger)
                 1
                 (CanTake (Weapon Quarterstaff) 1 (NoDecision (Goto 245))))
           , ( ""
             , CanTake
                 (Weapon Dagger)
                 1
                 (CanTake Meal 1 (NoDecision (Goto 245))))
           ]))
  , ( 92
    , Chapter
        (NoDecision (Goto 183)))
  , ( 93
    , Chapter
        (NoDecision (Goto 137)))
  , ( 94
    , Chapter
        (NoDecision (Goto 240)))
  , ( 95
    , Chapter
        (NoDecision
           (Conditionally
              [(Goto 239), (Goto 28)])))
  , ( 96
    , Chapter
        (NoDecision (Goto 112)))
  , ( 97
    , Chapter
        (NoDecision (Goto 152)))
  , ( 98
    , Chapter
        (Decisions
           [ ( ""
             , NoDecision (Goto 244))
           , ( ""
             , NoDecision (Goto 115))
           ]))
  , ( 99
    , Chapter
        (NoDecision (Randomly [(1 % 2, Goto 326), (1 % 2, Goto 163)])))
  , ( 100
    , Chapter
        (Decisions
           [ ( ""
             , NoDecision (Goto 30))
           , ( ""
             , NoDecision (Goto 267))
           ]))
  , ( 101
    , Chapter
        (NoDecision (Goto 222)))
  , ( 102
    , Chapter
        (Decisions
           [ ( ""
             ,   (NoDecision (Goto 325)))
           , ( ""
             ,   (NoDecision (Goto 64)))
           , ( ""
             , 
                 (NoDecision (Goto 164)))
           ]))
  , ( 103
    , Chapter
        (Decisions
           [ ( ""
             , NoDecision
                 (Simple [HealPlayer (Endurance {getEndurance = 3})] (Goto 249)))
           , ("", CanTake Laumspur 1 (NoDecision (Goto 249)))
           ]))
  , ( 104
    , Chapter
        (Decisions
           [ ( ""
             , NoDecision (Goto 231))
           , ( ""
             , NoDecision (Goto 177))
           ]))
  , ( 105
    , Chapter
        (NoDecision (Randomly [(1 % 2, Goto 286), (1 % 2, Goto 120)])))
  , ( 106
    , Chapter
        (CanTake
           (Weapon MagicSpear)
           1
           (NoDecision
              (Fight
                 (FightDetails
                  {  _fendurance = Endurance {getEndurance = 30}
                  })
                 (Goto 320)))))
  , ( 107
    , Chapter
        (NoDecision
           (Conditionally
              [(Goto 74), (Goto 294)])))
  , ( 108
    , Chapter
        (NoDecision
           (Simple
              [DamagePlayer (Endurance {getEndurance = 2})]
              (Conditionally
                 [(Goto 343), (Goto 168)]))))
  , ( 109
    , Chapter
        (NoDecision (Goto 120)))
  , ( 110
    , Chapter
        (EvadeFight
           0
           65
           (FightDetails
            { _fendurance = Endurance {getEndurance = 22}
            })
           (Goto 331)))
  , ( 111
    , Chapter
        (NoDecision (Goto 265)))
  , ( 112
    , Chapter
        (NoDecision (Goto 230)))
  , ( 113
    , Chapter
        (Decisions
           [ ( ""
             , NoDecision (Goto 73))
           , ( ""
             , NoDecision (Goto 267))
           ]))
  , ( 114
    , Chapter
        (NoDecision
           (Randomly [(2 % 5, Goto 206), (2 % 5, Goto 63), (1 % 5, Goto 8)])))
  , ( 115
    , Chapter
        (Decisions
           [ ( ""
             , NoDecision (Goto 80))
           , ( ""
             , NoDecision (Goto 324))
           , ( ""
             , NoDecision (Goto 162))
           ]))
  , ( 116
    , Chapter
        (NoDecision
           (Randomly
              [ (1 % 10, Simple [GainItem Gold 5] (Goto 314))
              , (1 % 10, Simple [GainItem Gold 6] (Goto 314))
              , (1 % 10, Simple [GainItem Gold 7] (Goto 314))
              , (1 % 10, Simple [GainItem Gold 8] (Goto 314))
              , (1 % 10, Simple [GainItem Gold 9] (Goto 314))
              , (1 % 10, Simple [GainItem Gold 10] (Goto 314))
              , (1 % 10, Simple [GainItem Gold 11] (Goto 314))
              , (1 % 10, Simple [GainItem Gold 12] (Goto 314))
              , (1 % 10, Simple [GainItem Gold 13] (Goto 314))
              , (1 % 10, Simple [GainItem Gold 14] (Goto 314))
              ])))
  , ( 117
    , Chapter
        (Decisions
           [ ( ""
             , 
                 (NoDecision (Simple [LoseItem Gold 3] (Goto 37))))
           , ( ""
             , 
                 (NoDecision (Simple [LoseItem Gold 1] (Goto 148))))
           , ( ""
             , NoDecision (Goto 292))
           ]))
  , ( 118
    , Chapter
        (Decisions
           [ ( ""
             ,  (NoDecision (Goto 279)))
           , ( ""
             , 
                 (NoDecision (Goto 23)))
           , ( ""
             , 
                 (NoDecision (Goto 340)))
           ]))
  , ( 119
    , Chapter
        (NoDecision (Goto 240)))
  , ( 120
    , Chapter
        (NoDecision (Goto 225)))
  , ( 121
    , Chapter
        (NoDecision (Goto 186)))
  , ( 122
    , Chapter
        (NoDecision
           (Conditionally
              [ (Goto 96)
              , (Randomly [(1 % 2, Goto 46), (1 % 2, Goto 112)])
              ])))
  , ( 123
    , Chapter
        (CanTake (Weapon Sommerswerd) 1 (NoDecision (Goto 40))))
  , ( 124
    , Chapter
        (CanTake
           (Weapon ShortSword)
           1
           (CanTake Gold 42 (CanTake (Weapon Dagger) 1 (NoDecision (Goto 33))))))
  , ( 125
    , Chapter
        (NoDecision (Goto 300)))
  , ( 127
    , Chapter
        (Decisions
           [ ( ""
             , NoDecision (Simple [MustEat Hunt] (Goto 217)))
           , ( ""
             , NoDecision (Simple [MustEat Hunt] (Goto 143)))
           ]))
  , ( 128
    , Chapter
        (NoDecision
           (Fight
              (FightDetails
               {  _fendurance = Endurance {getEndurance = 19}
               })
              (Goto 237))))
  , ( 129
    , Chapter
        (NoDecision (Goto 4)))
  , ( 130
    , Chapter
        (NoDecision (Goto 314)))
  , ( 131
    , Chapter
        (EvadeFight
           0
           121
           (FightDetails
            { _fendurance = Endurance {getEndurance = 23}
            })
           (Fight
              (FightDetails
               { _fendurance = Endurance {getEndurance = 21}
               })
              (Fight
                 (FightDetails
                  { _fendurance = Endurance {getEndurance = 20}
                  })
                 (Goto 301)))))
  , ( 132
    , Chapter
        (CanTake
           (Weapon Spear)
           1
           (Decisions
              [ ( ""
                , NoDecision (Goto 317))
              , ( ""
                , NoDecision (Goto 150))
              ])))
  , ( 133
    , Chapter
        (NoDecision (Goto 268)))
  , ( 134
    , Chapter
        (NoDecision
           (Conditionally
              [ (Goto 38)
              , (Goto 304)
              ])))
  , ( 135
    , Chapter
        (NoDecision (Goto 244)))
  , ( 136
    , Chapter
        (NoDecision (Simple [LoseItem Gold 20] (Goto 10))))
  , ( 137
    , Chapter
        (Decisions
           [ ( ""
             , NoDecision (Goto 259))
           , ( ""
             , NoDecision (Goto 20))
           ]))
  , ( 138
    , Chapter
        (Decisions
           [ ( ""
             , NoDecision (Goto 232))
           , ( ""
             , NoDecision (Goto 244))
           ]))
  , ( 139
    , Chapter
        (CanTake
           Meal
           2
           (Decisions
              [ ("", NoDecision (Goto 27))
              , ( ""
                , NoDecision (Goto 114))
              ])))
  , ( 140
    , Chapter
        (NoDecision (Goto 265)))
  , ( 141
    , Chapter
        (Decisions
           [ ( ""
             , NoDecision
                 (Simple
                    [ DamagePlayer (Endurance {getEndurance = 2})
                    , LoseItem ChainMail 99
                    ]
                    (Goto 278)))
           , ( ""
             , NoDecision
                 (Simple
                    [ DamagePlayer (Endurance {getEndurance = 2})
                    , LoseItem ChainMail 99
                    ]
                    (Goto 337)))
           ]))
  , ( 143
    , Chapter
        (Decisions
           [ ( ""
             , NoDecision (Goto 289))
           , ( ""
             , NoDecision (Goto 186))
           ]))
  , ( 144
    , Chapter
        (CanTake
           Meal
           2
           (NoDecision (Simple [LoseItemKind [PouchSlot]] (Goto 349)))))
  , ( 145
    , Chapter
        (NoDecision
           (Simple [DamagePlayer (Endurance {getEndurance = 5})] (Goto 200))))
  , ( 146
    , Chapter
        (NoDecision
           (Fight
              (FightDetails
               { _fendurance = Endurance {getEndurance = 15}
               })
              (Goto 345))))
  , ( 147
    , Chapter
        (NoDecision (Goto 47)))
  , ( 148
    , Chapter
        (Decisions
           [ ( ""
             , NoDecision (Simple [MustEat Hunt] (Goto 122)))
           , ( ""
             , NoDecision (Simple [MustEat Hunt] (Goto 323)))
           , ( ""
             , NoDecision (Simple [MustEat Hunt] (Goto 257)))
           ]))
  , ( 149
    , Chapter
        (Decisions
           [ ( ""
             ,  (NoDecision (Goto 223)))
           , ( ""
             , NoDecision (Goto 250))
           ]))
  , ( 150
    , Chapter
        (Decisions
           [ ( ""
             , NoDecision (Simple [MustEat Hunt] (Goto 261)))
           , ( ""
             , NoDecision (Simple [MustEat Hunt] (Goto 334)))
           ]))
  , ( 151
    , Chapter
        (NoDecision (Randomly [(1 % 2, Goto 262), (1 % 2, Goto 110)])))
  , ( 152
    , Chapter
        (NoDecision
           (Randomly [(2 % 5, Goto 216), (3 % 10, Goto 49), (3 % 10, Goto 193)])))
  , ( 153
    , Chapter
        (Decisions
           [ ( ""
             , NoDecision (Goto 241))
           , ( ""
             , NoDecision (Goto 130))
           ]))
  , ( 154
    , Chapter
        (Decisions
           [ ( ""
             , NoDecision
                 (Simple
                    [DamagePlayer (Endurance {getEndurance = 2})]
                    (Goto 308)))
           , ( ""
             , NoDecision
                 (Simple
                    [DamagePlayer (Endurance {getEndurance = 2})]
                    (Goto 197)))
           ]))
  , ( 155
    , Chapter
        (NoDecision (Goto 265)))
  , ( 156
    , Chapter
        (NoDecision (Goto 213)))
  , ( 157
    , Chapter
        (EvadeFight
           0
           65
           (FightDetails
            { _fendurance = Endurance {getEndurance = 22}
            })
           (Goto 331)))
  , ( 158
    , Chapter
        (NoDecision
           (Fight
              (FightDetails
               { _fendurance = Endurance {getEndurance = 23}
               })
              (Goto 220))))
  , ( 159
    , Chapter
        (NoDecision GameLost))
  , ( 160
    , Chapter
        (NoDecision (Goto 268)))
  , ( 161
    , Chapter
        (NoDecision (Goto 186)))
  , ( 162
    , Chapter
        (EvadeFight
           0
           244
           (FightDetails
            { _fendurance = Endurance {getEndurance = 27}
            })
           (Goto 302)))
  , ( 163
    , Chapter
        (NoDecision (Goto 240)))
  , ( 164
    , Chapter
        (Decisions
           [ ( ""
             ,  (NoDecision (Goto 172)))
           , ( ""
             , 
                 (NoDecision (Goto 52)))
           , ( ""
             , 
                 (NoDecision (Goto 256)))
           ]))
  , ( 165
    , Chapter
        (NoDecision (Simple [LoseItem SealHammerdalVol2 1] (Goto 186))))
  , ( 166
    , Chapter
        (Decisions
           [ ( ""
             , NoDecision (Goto 328))
           , ( ""
             , NoDecision (Goto 267))
           ]))
  , ( 167
    , Chapter
        (NoDecision (Goto 197)))
  , ( 168
    , Chapter
        (NoDecision
           (Conditionally
              [ (Simple [LoseItem Gold 1] (Goto 314))
              , (Goto 25)
              ])))
  , ( 169
    , Chapter
        (NoDecision
           (Randomly [(2 % 5, Goto 39), (3 % 10, Goto 249), (3 % 10, Goto 339)])))
  , ( 171
    , Chapter
        (Decisions
           [ ("", NoDecision (Goto 27))
           , ("", NoDecision (Goto 114))
           ]))
  , ( 172
    , Chapter
        (Decisions
           [ ( ""
             , NoDecision (Goto 52))
           , ( ""
             , NoDecision (Goto 256))
           , ( ""
             , NoDecision (Goto 64))
           ]))
  , ( 173
    , Chapter
        (Decisions
           [ ( ""
             , NoDecision (Goto 91))
           , ( ""
             , NoDecision (Goto 6))
           , ( ""
             , NoDecision (Goto 283))
           ]))
  , ( 174
    , Chapter
        (NoDecision (Goto 162)))
  , ( 175
    , Chapter
        (NoDecision (Randomly [(1 % 2, Goto 53), (1 % 2, Goto 209)])))
  , ( 176
    , Chapter
        (Decisions
           [ ( ""
             ,  (NoDecision (Goto 322)))
           , ( ""
             , 
                 (NoDecision (Goto 45)))
           , ( ""
             , 
                 (NoDecision (Goto 277)))
           ]))
  , ( 177
    , Chapter
        (Decisions
           [ ( ""
             , NoDecision (Goto 276))
           , ( ""
             , NoDecision (Goto 342))
           ]))
  , ( 178
    , Chapter
        (NoDecision (Goto 200)))
  , ( 179
    , Chapter
        (Decisions
           [ ( ""
             , NoDecision (Goto 82))
           , ( ""
             , NoDecision (Goto 150))
           , ( ""
             , NoDecision (Goto 71))
           ]))
  , ( 180
    , Chapter
        (NoDecision (Goto 337)))
  , ( 181
    , Chapter
        (Canbuy
           Backpack
           1
           (Canbuy
              (Weapon Mace)
              4
              (Canbuy
                 (Weapon Spear)
                 5
                 (Canbuy
                    (Weapon Warhammer)
                    6
                    (Canbuy
                       (Weapon ShortSword)
                       3
                       (Canbuy
                          (Weapon Dagger)
                          2
                          (Canbuy (Weapon Sword) 4 (NoDecision (Goto 186))))))))))
  , ( 182
    , Chapter
        (NoDecision (Goto 177)))
  , ( 183
    , Chapter
        (NoDecision (Randomly [(9 % 10, Goto 311), (1 % 1, Goto 159)])))
  , ( 184
    , Chapter
        (NoDecision (Goto 240)))
  , ( 185
    , Chapter
        (EvadeFight
           0
           286
           (FightDetails
            { _fendurance = Endurance {getEndurance = 25}
            })
           (Fight
              (FightDetails
               { _fendurance = Endurance {getEndurance = 26}
               })
              (Goto 120))))
  , ( 186
    , Chapter
        (Special Cartwheel))
  , ( 187
    , Chapter
        (CanTake
           Gold
           6
           (CanTake
              (Weapon Spear)
              2
              (CanTake (Weapon Spear) 2 (NoDecision (Goto 265))))))
  , ( 188
    , Chapter
        (NoDecision (Goto 312)))
  , ( 189
    , Chapter
        (Decisions
           [ ( ""
             , NoDecision
                 (Simple
                    [DamagePlayer (Endurance {getEndurance = 2})]
                    (Goto 162)))
           , ( ""
             , NoDecision
                 (Simple
                    [DamagePlayer (Endurance {getEndurance = 2})]
                    (Goto 244)))
           ]))
  , ( 190
    , Chapter
        (NoDecision GameLost))
  , ( 192
    , Chapter
        (NoDecision (Goto 32)))
  , ( 193
    , Chapter
        (NoDecision (Goto 100)))
  , ( 194
    , Chapter
        (Decisions
           [ ( ""
             , NoDecision
                 (Simple
                    [ LoseItemKind
                        [PouchSlot, BackpackSlot, WeaponSlot, SpecialSlot]
                    ]
                    (Goto 215)))
           , ( ""
             , NoDecision
                 (Simple
                    [ LoseItemKind
                        [PouchSlot, BackpackSlot, WeaponSlot, SpecialSlot]
                    ]
                    (Goto 303)))
           , ( ""
             , NoDecision
                 (Simple
                    [ LoseItemKind
                        [PouchSlot, BackpackSlot, WeaponSlot, SpecialSlot]
                    ]
                    (Goto 129)))
           , ( ""
             , NoDecision
                 (Simple
                    [ LoseItemKind
                        [PouchSlot, BackpackSlot, WeaponSlot, SpecialSlot]
                    ]
                    (Goto 86)))
           ]))
  , ( 195
    , Chapter
        (NoDecision
           (Conditionally
              [ (Simple [LoseItem Gold 1] (Goto 249))
              , (Goto 50)
              ])))
  , ( 196
    , Chapter
        (NoDecision
           (Simple
              [LoseItem SealHammerdalVol2 1]
              (Conditionally
                 [(Goto 79), (Goto 123)]))))
  , ( 197
    , Chapter
        (NoDecision
           (Randomly [(2 % 5, Goto 78), (1 % 2, Goto 141), (1 % 1, Goto 247)])))
  , ( 198
    , Chapter
        (NoDecision
           (Simple [DamagePlayer (Endurance {getEndurance = 1})] (Goto 138))))
  , ( 199
    , Chapter
        (NoDecision (Goto 143)))
  , ( 200
    , Chapter
        (Decisions
           [ ( ""
             , NoDecision (Goto 7))
           , ( ""
             , NoDecision (Goto 60))
           , ( ""
             , NoDecision (Goto 85))
           , ( ""
             , NoDecision (Goto 158))
           , ( ""
             , NoDecision (Goto 270))
           ]))
  , ( 201
    , Chapter
        (NoDecision (Randomly [(1 % 2, Goto 285), (1 % 2, Goto 70)])))
  , ( 202
    , Chapter
        (NoDecision (Goto 31)))
  , ( 203
    , Chapter
        (NoDecision (Goto 268)))
  , ( 204
    , Chapter
        (Decisions
           [ ( ""
             , NoDecision (Goto 73))
           , ( ""
             , NoDecision (Goto 267))
           ]))
  , ( 205
    , Chapter
        (NoDecision (Goto 213)))
  , ( 206
    , Chapter
        (NoDecision (Goto 312)))
  , ( 207
    , Chapter
        (NoDecision (Goto 47)))
  , ( 208
    , Chapter
        (NoDecision (Goto 134)))
  , ( 209
    , Chapter
        (NoDecision (Goto 197)))
  , ( 210
    , Chapter
        (NoDecision (Randomly [(1 % 2, Goto 275), (1 % 2, Goto 330)])))
  , ( 212
    , Chapter
        (NoDecision GameLost))
  , ( 213
    , Chapter
        (NoDecision GameLost))
  , ( 214
    , Chapter
        (NoDecision GameLost))
  , ( 215
    , Chapter
        (Decisions
           [ ( ""
             , NoDecision (Goto 4))
           , ( ""
             , NoDecision (Goto 83))
           ]))
  , ( 216
    , Chapter
        (NoDecision (Goto 100)))
  , ( 217
    , Chapter
        (Decisions
           [ ( ""
             , 
                 (NoDecision (Simple [LoseItem Gold 1] (Goto 199))))
           , ( ""
             , NoDecision (Goto 143))
           ]))
  , ( 218
    , Chapter
        (Decisions
           [ ("", NoDecision (Goto 43))
           , ( ""
             , NoDecision (Goto 105))
           ]))
  , ( 219
    , Chapter
        (NoDecision
           (Simple [DamagePlayer (Endurance {getEndurance = 3})] (Goto 312))))
  , ( 220
    , Chapter
        (CanTake Gold 23 (NoDecision (Goto 33))))
  , ( 221
    , Chapter
        (NoDecision (Goto 88)))
  , ( 222
    , Chapter
        (Decisions
           [ ("", NoDecision (Goto 175))
           , ( ""
             , NoDecision (Goto 315))
           ]))
  , ( 223
    , Chapter
        (NoDecision (Goto 265)))
  , ( 224
    , Chapter
        (Decisions
           [ ( ""
             , NoDecision (Goto 146))
           , ( ""
             , NoDecision (Goto 34))
           ]))
  , ( 225
    , Chapter
        (NoDecision (Goto 350)))
  , ( 226
    , Chapter
        (Decisions
           [ ( ""
             , 
                 (NoDecision (Simple [LoseItem Gold 2] (Goto 56))))
           , ( ""
             , NoDecision (Goto 276))
           ]))
  , ( 227
    , Chapter
        (NoDecision (Goto 4)))
  , ( 228
    , Chapter
        (Decisions
           [ ("", NoDecision (Goto 27))
           , ("", NoDecision (Goto 114))
           ]))
  , ( 229
    , Chapter
        (Decisions
           [ ( ""
             , NoDecision (Goto 134))
           , ( ""
             , NoDecision (Goto 208))
           , ( ""
             , NoDecision (Goto 164))
           ]))
  , ( 230
    , Chapter
        (Decisions
           [ ( ""
             , NoDecision (Goto 93))
           , ( ""
             , NoDecision (Goto 137))
           ]))
  , ( 231
    , Chapter
        (CanTake
           (Weapon Dagger)
           1
           (CanTake
              Gold
              5
              (CanTake
                 SealHammerdalVol2
                 1
                 (Decisions
                    [ ( ""
                      , 
                          (NoDecision (Goto 182)))
                    , ( ""
                      , 
                          (NoDecision (Goto 177)))
                    , ( ""
                      , 
                          (NoDecision (Goto 24)))
                    , ( ""
                      , 
                          (NoDecision (Goto 253)))
                    , ( ""
                      , 
                          (NoDecision (Goto 319)))
                    ])))))
  , ( 232
    , Chapter
        (Decisions
           [ ( ""
             ,  (NoDecision (Goto 149)))
           , ( ""
             , NoDecision (Goto 250))
           , ( ""
             , NoDecision (Goto 68))
           , ( ""
             ,   (NoDecision (Goto 223)))
           ]))
  , ( 233
    , Chapter
        (Decisions
           [ ( ""
             , 
                 (NoDecision (Simple [LoseItem Gold 3] (Goto 37))))
           , ( ""
             , 
                 (NoDecision (Simple [LoseItem Gold 1] (Goto 148))))
           , ( ""
             , NoDecision (Goto 292))
           ]))
  , ( 234
    , Chapter
        (NoDecision GameLost))
  , ( 235
    , Chapter
        (CanTake
           (Weapon ShortSword)
           1
           (Decisions
              [ ( ""
                , NoDecision (Goto 132))
              , ( ""
                , NoDecision (Goto 90))
              ])))
  , ( 236
    , Chapter
        (NoDecision (Goto 222)))
  , ( 237
    , Chapter
        (NoDecision
           (Fight
              (FightDetails
               { _fendurance = Endurance {getEndurance = 30}
               })
              (Goto 309))))
  , ( 238
    , Chapter
        (Special Cartwheel))
  , ( 239
    , Chapter
        (NoDecision
           (Conditionally
              [(Goto 77), (Goto 28)])))
  , ( 240
    , Chapter
        (Decisions
           [ ( ""
             , 
                 (Decisions
                    [ ( ""
                      , NoDecision (Simple [FullHeal] (Goto 29)))
                    , ( ""
                      , NoDecision (Simple [FullHeal] (Goto 236)))
                    , ( ""
                      , NoDecision (Simple [FullHeal] (Goto 101)))
                    ]))
           , ( ""
             , 
                 (Decisions
                    [ ( ""
                      , NoDecision (Simple [HalfHeal] (Goto 29)))
                    , ( ""
                      , NoDecision (Simple [HalfHeal] (Goto 236)))
                    , ( ""
                      , NoDecision (Simple [HalfHeal] (Goto 101)))
                    ]))
           ]))
  , ( 241
    , Chapter
        (NoDecision
           (Fight
              (FightDetails
               { _fendurance = Endurance {getEndurance = 25}
               })
              (Goto 21))))
  , ( 242
    , Chapter
        (NoDecision (Goto 152)))
  , ( 243
    , Chapter
        (NoDecision (Goto 240)))
  , ( 244
    , Chapter
        (Decisions
           [ ( ""
             ,  (NoDecision (Goto 147)))
           , ( ""
             ,  (NoDecision (Goto 47)))
           , ( ""
             , 
                 (NoDecision (Goto 207)))
           ]))
  , ( 245
    , Chapter
        (Decisions
           [ ( ""
             , NoDecision (Goto 266))
           , ( ""
             , NoDecision (Goto 310))
           ]))
  , ( 247
    , Chapter
        (NoDecision GameLost))
  , ( 248
    , Chapter
        (NoDecision GameLost))
  , ( 249
    , Chapter
        (NoDecision (Goto 39)))
  , ( 250
    , Chapter
        (Decisions
           [ ( ""
             , NoDecision (Goto 244))
           , ( ""
             , NoDecision (Goto 68))
           , ( ""
             ,   (NoDecision (Goto 223)))
           ]))
  , ( 251
    , Chapter
        (NoDecision (Goto 194)))
  , ( 253
    , Chapter
        (Decisions
           [ ( ""
             , NoDecision (Goto 303))
           , ( ""
             , NoDecision (Goto 177))
           ]))
  , ( 254
    , Chapter
        (Decisions
           [ ( ""
             ,  (NoDecision (Goto 344)))
           , ( ""
             , 
                 (NoDecision (Goto 69)))
           , ( ""
             , 
                 (NoDecision (Goto 183)))
           ]))
  , ( 255
    , Chapter
        (NoDecision (Goto 268)))
  , ( 256
    , Chapter
        (NoDecision (Goto 134)))
  , ( 257
    , Chapter
        (Decisions
           [ ( ""
             , NoDecision (Goto 335))
           , ( ""
             , NoDecision (Goto 181))
           ]))
  , ( 258
    , Chapter
        (Decisions
           [ ( ""
             ,  (NoDecision (Goto 272)))
           , ( ""
             , 
                 (NoDecision (Goto 17)))
           , ( ""
             , 
                 (NoDecision (Goto 5)))
           ]))
  , ( 259
    , Chapter
        (NoDecision (Goto 161)))
  , ( 260
    , Chapter
        (CanTake (Weapon Sword) 1 (NoDecision (Goto 240))))
  , ( 261
    , Chapter
        (Decisions
           [ ( ""
             , NoDecision (Goto 95))
           , ( ""
             , NoDecision (Goto 198))
           ]))
  , ( 262
    , Chapter
        (CanTake
           Meal
           6
           (CanTake
              Gold
              6
              (CanTake
                 (Weapon Quarterstaff)
                 1
                 (CanTake
                    (Weapon Mace)
                    1
                    (CanTake (Weapon Sword) 1 (NoDecision (Goto 65))))))))
  , ( 264
    , Chapter
        (NoDecision (Goto 312)))
  , ( 265
    , Chapter
        (NoDecision
           (Conditionally
              [ (Goto 202)
              , (Simple [LoseItem Gold 6] (Goto 202))
              ])))
  , ( 266
    , Chapter
        (Canbuy
           (Weapon Quarterstaff)
           3
           (Canbuy
              (Weapon Axe)
              3
              (Canbuy
                 (Weapon Mace)
                 4
                 (Canbuy
                    (Weapon Spear)
                    5
                    (Canbuy
                       (Weapon Warhammer)
                       6
                       (Canbuy
                          (Weapon ShortSword)
                          3
                          (Canbuy
                             (Weapon BroadSword)
                             7
                             (Canbuy
                                (Weapon Dagger)
                                2
                                (Canbuy
                                   (Weapon Sword)
                                   4
                                   (Cansell
                                      (Weapon Quarterstaff)
                                      2
                                      (Cansell
                                         (Weapon Axe)
                                         2
                                         (Cansell
                                            (Weapon Mace)
                                            3
                                            (Cansell
                                               (Weapon Spear)
                                               4
                                               (Cansell
                                                  (Weapon Warhammer)
                                                  5
                                                  (Cansell
                                                     (Weapon ShortSword)
                                                     2
                                                     (Cansell
                                                        (Weapon BroadSword)
                                                        6
                                                        (Cansell
                                                           (Weapon Dagger)
                                                           1
                                                           (Cansell
                                                              (Weapon Sword)
                                                              3
                                                              (NoDecision
                                                                 (Goto 32)))))))))))))))))))))
  , ( 267
    , Chapter
        (Decisions
           [ ( ""
             , NoDecision (Goto 128))
           , ( ""
             , NoDecision (Goto 309))
           ]))
  , ( 268
    , Chapter
        (EvadeFight
           2
           125
           (FightDetails
            { _fendurance = Endurance {getEndurance = 25}
            })
           (Goto 333)))
  , ( 269
    , Chapter
        (NoDecision (Goto 349)))
  , ( 270
    , Chapter
        (NoDecision
           (Fight
              (FightDetails
               { _fendurance = Endurance {getEndurance = 30}
               })
              (Goto 33))))
  , ( 271
    , Chapter
        (Decisions
           [ ( ""
             ,  (NoDecision (Goto 151)))
           , ( ""
             , 
                 (NoDecision (Goto 157)))
           , ( ""
             , 
                 (NoDecision (Goto 65)))
           ]))
  , ( 272
    , Chapter
        (NoDecision (Goto 5)))
  , ( 273
    , Chapter
        (NoDecision (Goto 160)))
  , ( 274
    , Chapter
        (CanTake
           Gold
           6
           (CanTake
              (Weapon Mace)
              1
              (CanTake (Weapon Sword) 1 (NoDecision (Goto 132))))))
  , ( 275
    , Chapter
        (NoDecision GameLost))
  , ( 276
    , Chapter
        (Decisions
           [ ( ""
             ,  (NoDecision (Goto 14)))
           , ( ""
             , 
                 (NoDecision
                    (Fight
                       (FightDetails
                        { _fendurance = Endurance {getEndurance = 25}
                        })
                       (Goto 305))))
           ]))
  , ( 277
    , Chapter
        (Decisions
           [ ( ""
             , NoDecision (Goto 311))
           , ( ""
             , NoDecision (Goto 59))
           ]))
  , ( 278
    , Chapter
        (NoDecision (Randomly [(7 % 10, Goto 41), (3 % 10, Goto 180)])))
  , ( 279
    , Chapter
        (Decisions
           [ ( ""
             , NoDecision (Goto 23))
           , ( ""
             , NoDecision (Goto 340))
           ]))
  , ( 280
    , Chapter
        (NoDecision (Randomly [(1 % 2, Goto 2), (1 % 2, Goto 108)])))
  , ( 281
    , Chapter
        (NoDecision (Goto 240)))
  , ( 282
    , Chapter
        (NoDecision
           (Fight
              (FightDetails
               { _fendurance = Endurance {getEndurance = 24}
               })
              (Fight
                 (FightDetails
                  { _fendurance = Endurance {getEndurance = 22}
                  })
                 (Goto 187)))))
  , ( 283
    , Chapter
        (Canbuy
           Backpack
           1
           (Canbuy
              Meal
              2
              (Canbuy
                 Meal
                 2
                 (Canbuy
                    Meal
                    2
                    (Canbuy
                       (Weapon Spear)
                       5
                       (Canbuy
                          (Weapon BroadSword)
                          6
                          (Canbuy
                             (Weapon Dagger)
                             2
                             (Canbuy (Weapon Sword) 4 (NoDecision (Goto 245)))))))))))
  , ( 284
    , Chapter
        (NoDecision (Simple [MustEat Hunt] (Goto 9))))
  , ( 285
    , Chapter
        (NoDecision (Goto 312)))
  , ( 286
    , Chapter
        (NoDecision (Goto 109)))
  , ( 287
    , Chapter
        (NoDecision (Goto 175)))
  , ( 288
    , Chapter
        (NoDecision (Goto 244)))
  , ( 289
    , Chapter
        (Decisions
           [ ( ""
             , NoDecision
                 (Simple
                    [LoseItem SealHammerdalVol2 1, GainItem Gold 40]
                    (Goto 165)))
           , ( ""
             , NoDecision (Goto 186))
           ]))
  , ( 290
    , Chapter
        (NoDecision (Goto 200)))
  , ( 291
    , Chapter
        (NoDecision (Goto 244)))
  , ( 292
    , Chapter
        (NoDecision GameLost))
  , ( 293
    , Chapter
        (NoDecision (Goto 155)))
  , ( 294
    , Chapter
        (NoDecision (Goto 240)))
  , ( 295
    , Chapter
        (NoDecision (Goto 340)))
  , ( 296
    , Chapter
        (EvadeFight
           0
           88
           (FightDetails
            { _fendurance = Endurance {getEndurance = 22}
            })
           (Fight
              (FightDetails
               { _fendurance = Endurance {getEndurance = 20}
               })
              (Fight
                 (FightDetails
                  { _fendurance = Endurance {getEndurance = 19}
                  })
                 (Fight
                    (FightDetails
                     { _fendurance = Endurance {getEndurance = 19}
                     })
                    (Fight
                       (FightDetails
                        { _fendurance = Endurance {getEndurance = 18}
                        })
                       (Fight
                          (FightDetails
                           { _fendurance = Endurance {getEndurance = 17}
                           })
                          (Goto 221))))))))
  , ( 297
    , Chapter
        (NoDecision (Goto 32)))
  , ( 298
    , Chapter
        (EvadeFight
           0
           121
           (FightDetails
            { _fendurance = Endurance {getEndurance = 23}
            })
           (Fight
              (FightDetails
               { _fendurance = Endurance {getEndurance = 21}
               })
              (Fight
                 (FightDetails
                  { _fendurance = Endurance {getEndurance = 20}
                  })
                 (Goto 301)))))
  , ( 299
    , Chapter
        (Decisions
           [ ( ""
             , NoDecision (Simple [LoseItem (Weapon MagicSpear) 1] (Goto 118)))
           , ( ""
             , 
                 (NoDecision (Goto 102)))
           ]))
  , ( 300
    , Chapter
        (NoDecision
           (Randomly
              [ (1 % 5, Goto 224)
              , (1 % 5, Goto 316)
              , (1 % 5, Goto 81)
              , (1 % 5, Goto 22)
              , (1 % 5, Goto 99)
              ])))
  , ( 301
    , Chapter
        (CanTake
           Gold
           3
           (CanTake
              (Weapon Dagger)
              1
              (CanTake (Weapon ShortSword) 1 (NoDecision (Goto 20))))))
  , ( 302
    , Chapter
        (NoDecision (Goto 15)))
  , ( 303
    , Chapter
        (Decisions
           [ ( ""
             , NoDecision (Goto 173))
           , ( ""
             , NoDecision (Goto 18))
           ]))
  , ( 304
    , Chapter
        (NoDecision GameLost))
  , ( 305
    , Chapter
        (CanTake Gold 5 (NoDecision (Goto 32))))
  , ( 306
    , Chapter
        (NoDecision
           (Fight
              (FightDetails
               { _fendurance = Endurance {getEndurance = 24}
               })
              (Goto 35))))
  , ( 307
    , Chapter
        (Decisions
           [ ( ""
             , NoDecision (Goto 57))
           , ( ""
             ,  (NoDecision (Goto 140)))
           , ( ""
             , NoDecision (Goto 282))
           ]))
  , ( 308
    , Chapter
        (Special Portholes))
  , ( 309
    , Chapter
        (NoDecision (Goto 26)))
  , ( 310
    , Chapter
        (NoDecision (Goto 32)))
  , ( 311
    , Chapter
        (NoDecision (Goto 299)))
  , ( 312
    , Chapter
        (Decisions
           [ ( ""
             , NoDecision (Goto 117))
           , ( ""
             , NoDecision (Goto 89))
           ]))
  , ( 313
    , Chapter
        (NoDecision
           (Simple [DamagePlayer (Endurance {getEndurance = 4})] (Goto 349))))
  , ( 314
    , Chapter
        (Decisions
           [ ( ""
             ,  (NoDecision (Goto 290)))
           , ( ""
             ,  (NoDecision (Goto 36)))
           , ( ""
             , 
                 (NoDecision (Simple [MustEat NoHunt] (Goto 178))))
           ]))
  , ( 315
    , Chapter
        (Decisions
           [ ( ""
             , 
                 (NoDecision (Goto 287)))
           , ( ""
             , 
                 (NoDecision (Goto 190)))
           , ( ""
             , 
                 (NoDecision (Goto 175)))
           ]))
  , ( 316
    , Chapter
        (NoDecision (Randomly [(1 % 2, Goto 107), (1 % 2, Goto 94)])))
  , ( 317
    , Chapter
        (NoDecision GameLost))
  , ( 319
    , Chapter
        (Decisions
           [ ( ""
             , NoDecision (Goto 271))
           , ( ""
             , NoDecision (Goto 177))
           ]))
  , ( 320
    , Chapter
        (NoDecision (Goto 138)))
  , ( 321
    , Chapter
        (Decisions
           [ ( ""
             , 
                 (Decisions
                    [ ( ""
                      , NoDecision (Simple [LoseItem Meal 1] (Goto 12)))
                    , ( ""
                      , NoDecision (Simple [LoseItem Meal 1] (Goto 197)))
                    ]))
           , ( ""
             , 
                 (Decisions
                    [ ( ""
                      , NoDecision
                          (Simple
                             [DamagePlayer (Endurance {getEndurance = 2})]
                             (Goto 12)))
                    , ( ""
                      , NoDecision
                          (Simple
                             [DamagePlayer (Endurance {getEndurance = 2})]
                             (Goto 197)))
                    ]))
           ]))
  , ( 322
    , Chapter
        (NoDecision (Goto 277)))
  , ( 323
    , Chapter
        (Decisions
           [ ( ""
             , NoDecision (Goto 131))
           , ( ""
             , NoDecision (Goto 298))
           , ( ""
             , NoDecision (Goto 121))
           ]))
  , ( 324
    , Chapter
        (Decisions
           [ ( ""
             , NoDecision (Goto 135))
           , ( ""
             , NoDecision (Goto 174))
           , ( ""
             , NoDecision (Goto 288))
           ]))
  , ( 325
    , Chapter
        (Decisions
           [ ( ""
             , NoDecision (Goto 64))
           , ( ""
             , NoDecision (Goto 164))
           ]))
  , ( 326
    , Chapter
        (NoDecision
           (Fight
              (FightDetails
               { _fendurance = Endurance {getEndurance = 25}
               })
              (Goto 184))))
  , ( 328
    , Chapter
        (Decisions
           [ ( ""
             ,  (NoDecision (Goto 113)))
           , ( ""
             ,  (NoDecision (Goto 204)))
           , ( ""
             ,  (NoDecision (Goto 73)))
           , ( ""
             , 
                 (NoDecision (Goto 267)))
           ]))
  , ( 329
    , Chapter
        (CanTake Gold 10 (NoDecision (Goto 197))))
  , ( 330
    , Chapter
        (NoDecision
           (Simple [DamagePlayer (Endurance {getEndurance = 5})] (Goto 200))))
  , ( 331
    , Chapter
        (CanTake
           Gold
           3
           (CanTake
              (Weapon Dagger)
              1
              (CanTake (Weapon Sword) 1 (NoDecision (Goto 65))))))
  , ( 332
    , Chapter
        (EvadeFight
           0
           92
           (FightDetails
            { _fendurance = Endurance {getEndurance = 30}
            })
           (Goto 183)))
  , ( 333
    , Chapter
        (Decisions
           [ ( ""
             , NoDecision (Goto 300))
           , ( ""
             , NoDecision (Goto 67))
           ]))
  , ( 334
    , Chapter
        (Decisions
           [ ( ""
             ,  (NoDecision (Goto 98)))
           , ( ""
             , 
                 (NoDecision (Goto 115)))
           , ( ""
             , 
                 (NoDecision (Goto 291)))
           ]))
  , ( 335
    , Chapter
        (Decisions
           [ ( ""
             , NoDecision (Goto 161))
           , ( ""
             , NoDecision (Goto 61))
           ]))
  , ( 336
    , Chapter
        (Decisions
           [ ( ""
             , NoDecision (Goto 109))
           , ( ""
             , NoDecision (Goto 185))
           ]))
  , ( 337
    , Chapter
        (Decisions
           [ ( ""
             , 
                 (NoDecision
                    (Simple [LoseItemKind [BackpackSlot, WeaponSlot]] (Goto 139))))
           , ( ""
             , 
                 (NoDecision
                    (Simple [LoseItemKind [BackpackSlot, WeaponSlot]] (Goto 228))))
           , ( ""
             , 
                 (NoDecision
                    (Simple [LoseItemKind [BackpackSlot, WeaponSlot]] (Goto 171))))
           ]))
  , ( 338
    , Chapter
        (Decisions
           [ ( ""
             , NoDecision
                 (Simple
                    [DamagePlayer (Endurance {getEndurance = 2})]
                    (Goto 269)))
           , ( ""
             , NoDecision
                 (Simple
                    [DamagePlayer (Endurance {getEndurance = 2})]
                    (Goto 349)))
           ]))
  , ( 339
    , Chapter
        (NoDecision
           (Conditionally
              [ ( Simple [LoseItem Gold 1] (Goto 249))
              , (Goto 50)
              ])))
  , ( 340
    , Chapter
        (Decisions
           [ ( ""
             , NoDecision (Goto 64))
           , ( ""
             , NoDecision (Goto 164))
           ]))
  , ( 341
    , Chapter
        (NoDecision (Goto 240)))
  , ( 342
    , Chapter
        (Decisions
           [ ( ""
             , 
                 (NoDecision (Simple [LoseItem Gold 1] (Goto 72))))
           , ( ""
             , 
                 (NoDecision (Simple [LoseItem Gold 2] (Goto 56))))
           , ( ""
             , NoDecision (Goto 226))
           ]))
  , ( 343
    , Chapter
        (NoDecision (Goto 168)))
  , ( 344
    , Chapter
        (NoDecision (Goto 183)))
  , ( 345
    , Chapter
        (NoDecision
           (Fight
              (FightDetails
               { _fendurance = Endurance {getEndurance = 24}
               })
              (Goto 243))))
  , ( 346
    , Chapter
        (Decisions
           [ ( ""
             , 
                 (NoDecision (Simple [LoseItem Gold 2] (Goto 280))))
           , ( ""
             , 
                 (NoDecision
                    (Simple
                       [LoseItem Gold 1]
                       (Simple [MustEat NoHunt] (Goto 280)))))
           , ("", NoDecision (Simple [MustEat NoHunt] (Goto 205)))
           ]))
  , ( 347
    , Chapter
        (NoDecision
           (Simple [DamagePlayer (Endurance {getEndurance = 1})] (Goto 150))))
  , ( 348
    , Chapter
        (EvadeFight
           2
           125
           (FightDetails
            { _fendurance = Endurance {getEndurance = 25}
            })
           (Goto 333)))
  , ( 349
    , Chapter
        (Decisions
           [ ( ""
             , NoDecision (Goto 87))
           , ( ""
             , NoDecision (Goto 284))
           ]))
  , ( 350
    , Chapter
        (NoDecision GameWon))


  ]
