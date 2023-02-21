-- needed libraries
push = require 'lib/push'
Timer = require 'lib/knife.timer'

-- constants
require 'src/utils/Constants'

-- classes
require 'lib/class'
require 'src/StateMachine'
require 'src/components/Board'
require 'src/components/Tile'

-- states
require 'src/states/BaseState'
require 'src/states/BeginGameState'
require 'src/states/StartState'
require 'src/states/PlayState'
require 'src/states/GameOverState'
require 'src/components/HighlightedBorder'

-- utilities
require 'src/utils/HelperFunctions'

-- game objects
gameSounds = {
    
}

gameFonts = {
    ['small'] = love.graphics.newFont('fonts/thebombsound.ttf', 8),
    ['medium'] = love.graphics.newFont('fonts/thebombsound.ttf', 18),
    ['large'] = love.graphics.newFont('fonts/thebombsound.ttf', 36),
}

gameTextures = {
    ['background'] = love.graphics.newImage('assets/background.png'),
    ['tiles'] = love.graphics.newImage('assets/match3.png'),
}

gameQuads = {
    ['tiles'] = GenerateTileQuads(gameTextures['tiles'])
}