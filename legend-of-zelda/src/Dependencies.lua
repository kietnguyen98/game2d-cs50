-- libraries
require "lib/class"
push = require "lib/push"
-- utilities
require "src/Utils"
-- contants
require "src/Constants"
-- init state machine
require "src/StateMachine"
require "src/BaseState"
-- init game state
require "src/gameState/GameStartState"
require "src/gameState/GamePlayState"
-- world
require "src/world/Dungeon"
require "src/world/Room"
require "src/world/Gateway"
