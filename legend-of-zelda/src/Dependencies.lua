-- [GENERAL NEEDED MODULES]
-- libraries
require "lib/class"
push = require "lib/push"
Event = require "lib/knife/event"
Timer = require "lib/knife/timer"
-- utilities
require "src/Utils"
-- contants
require "src/Constants"
-- needed classes
require "src/StateMachine"
require "src/BaseState"
require "src/Animation"
require "src/Hitbox"

-- [GAME STATES]
require "src/gameState/GameStartState"
require "src/gameState/GamePlayState"

-- [WORLD]
require "src/world/Dungeon"
require "src/world/Room"
require "src/world/Gateway"

-- [GAME ENTITIES]
-- game entity definitions
require "src/entity/entityDefinition/EntityModelDefinitions"
-- entity
require "src/entity/entityDefinition/Entity"
-- main player  
require "src/entity/entityDefinition/Player"
-- game entity states
-- entity
-- main player
require "src/entity/entityState/Player/PlayerIdleState"
require "src/entity/entityState/Player/PlayerMovingState"
require "src/entity/entityState/Player/PlayerSwingSwordState"
-- other entity
require "src/entity/entityState/EntityIdleState"
require "src/entity/entityState/EntityMovingState"

-- [GAME OBJECTS]
-- game object
require "src/gameObject/GameObject"
-- game object definitions
require "src/gameObject/GameObjectModelDefinition"
