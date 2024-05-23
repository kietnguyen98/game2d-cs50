-- init needed library
push = require "lib/push"
require "lib/class"

-- init utilities
require "src/Util"

-- init constants
require "src/constants"

-- init ingame entity class
require "src/Animation"
require "src/MainCharacter"
require "src/Tiles"


-- init states
require "lib/StateMachine" 
require "lib/BaseState"
-- game states

-- init entities
require "src/entity/Entity"

-- main character
require "src/entity/mainCharacter/states/MainCharacterFallingState"
require "src/entity/mainCharacter/states/MainCharacterMovingState"
require "src/entity/mainCharacter/states/MainCharacterIdleState"
require "src/entity/mainCharacter/states/MainCharacterJumpingState"

-- entity states
require "src/entity/mainCharacter/MainCharacterEntity"