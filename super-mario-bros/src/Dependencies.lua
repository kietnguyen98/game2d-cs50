-- init needed library
push = require "lib/push"
require "lib/class"

-- init utilities
require "src/Util"

-- init constants
require "src/constants"

-- init states
require "lib/StateMachine"
require "lib/BaseState"

-- init ingame entity class
require "src/Animation"
require "src/LevelMaker"
require "src/Tile"
require "src/Tiles"
require "src/GameObject"

-- game states
require "src/gameState/PlayState"
require "src/gameState/StartState"

-- init entities
require "src/entity/Entity"

-- main character
require "src/entity/mainCharacter/states/MainCharacterFallingState"
require "src/entity/mainCharacter/states/MainCharacterMovingState"
require "src/entity/mainCharacter/states/MainCharacterIdleState"
require "src/entity/mainCharacter/states/MainCharacterJumpingState"

-- entity states
require "src/entity/mainCharacter/MainCharacterEntity"
