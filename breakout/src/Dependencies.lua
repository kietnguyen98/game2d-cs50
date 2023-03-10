-- import push library
push = require "lib/push"

-- import class
require "lib/class"

-- import game constant values
require "src/constants"

-- import base state machine class
require "src/StateMachine"

-- import base state
require "src/states/BaseState"

-- import game states
require "src/states/StartState"
require "src/states/PlayState"
require "src/states/SelectPaddleState"
require "src/states/ServeState"
require "src/states/GameOverState"
require "src/states/VictoryState"
require "src/states/EnterHighScoreState"
require "src/states/HighScoreState"

-- import uitlity functions, mainly for splitting our sprite sheet
require "src/Util"

-- import all game objects class
require "src/Paddle"
require "src/Ball"
require "src/Brick"

-- import brick level maker
require "src/LevelMaker"