-- init needed library
push = require "lib/push"
require "lib/class"

-- init utilities
require "src/utilities/GenerateQuads"
require "src/utilities/GenerateObjects"
require "src/utilities/GenerateTiles"
require "src/utilities/GenerateEnemies"

-- init constants
require "src/constants"

-- init states
require "lib/StateMachine"
require "lib/BaseState"

-- init ingame entity class
require "src/Animation"
require "src/Tile"
require "src/Tiles"
require "src/Object"

-- init level and map maker
require "src/LevelMaker"

-- game entities
-- base entity class
require "src/Entity"
-- main character entity class
require "src/entities/mainCharacter/MainCharacterEntity"
require "src/entities/enemies/mushroom/MushroomEntity"
require "src/entities/enemies/cannibal/CannibalEntity"
require "src/entities/enemies/turtle/TurtleEntity"

-- game states
require "src/gameStates/PlayState"
require "src/gameStates/StartState"
-- entity states
-- main character state
require "src/entities/mainCharacter/states/MainCharacterFallingState"
require "src/entities/mainCharacter/states/MainCharacterMovingState"
require "src/entities/mainCharacter/states/MainCharacterIdleState"
require "src/entities/mainCharacter/states/MainCharacterJumpingState"
require "src/entities/mainCharacter/states/MainCharacterBounceState"

-- enemies state 
-- mushroom
require "src/entities/enemies/mushroom/states/MushroomIdleState"
require "src/entities/enemies/mushroom/states/MushroomMovingState"
require "src/entities/enemies/mushroom/states/MushroomChasingState"
require "src/entities/enemies/mushroom/states/MushroomShrinkState"
-- turtle
require "src/entities/enemies/turtle/states/TurtleIdleState"
require "src/entities/enemies/turtle/states/TurtleChasingState"
require "src/entities/enemies/turtle/states/TurtleMovingState"
require "src/entities/enemies/turtle/states/TurtleShrinkState"
-- cannibal
require "src/entities/enemies/cannibal/states/CannibalIdleState"
require "src/entities/enemies/cannibal/states/CannibalAttackState"
