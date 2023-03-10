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
require 'src/components/HighlightedBorder'
require 'src/components/Particle'

-- states
require 'src/states/BaseState'
require 'src/states/BeginGameState'
require 'src/states/StartState'
require 'src/states/PlayState'
require 'src/states/GameOverState'
require 'src/states/HighScoresState'
require 'src/states/EnterHighScoresState'

-- utilities
require 'src/utils/HelperFunctions'

-- game objects
gameSounds = {
    ['background_music'] = love.audio.newSource('sounds/background.mp3', 'static'),
    ['change_option'] = love.audio.newSource('sounds/change_option.wav', 'static'),
    ['select_option'] = love.audio.newSource('sounds/select_option.wav', 'static'),
    ['explosion'] = love.audio.newSource('sounds/explosion.wav', 'static'),
    ['tick'] = love.audio.newSource('sounds/tick.wav', 'static'),
    ['warning_tick'] = love.audio.newSource('sounds/warning_tick.wav', 'static'),
    ['tile_select'] = love.audio.newSource('sounds/tile_select.wav', 'static'),
    ['tile_swap_success'] = love.audio.newSource('sounds/swap_success.wav', 'static'),
    ['tile_swap_error'] = love.audio.newSource('sounds/swap_error.wav', 'static'),
    ['level_up'] = love.audio.newSource('sounds/level_up.wav', 'static'),
    ['game_over'] = love.audio.newSource('sounds/game_over.wav', 'static'),
    ['level_complete'] = love.audio.newSource('sounds/level_complete.wav', 'static'),
    ['high-score'] = love.audio.newSource('sounds/high_score.wav', 'static'),
}

gameFonts = {
    ['small'] = love.graphics.newFont('fonts/thebombsound.ttf', 8),
    ['medium'] = love.graphics.newFont('fonts/thebombsound.ttf', 18),
    ['large'] = love.graphics.newFont('fonts/thebombsound.ttf', 36),
}

gameTextures = {
    ['background'] = love.graphics.newImage('assets/background.png'),
    ['tiles'] = love.graphics.newImage('assets/match3.png'),
    ['particle'] = love.graphics.newImage('assets/particle.png'),
    ['shiny_layer'] = love.graphics.newImage('assets/shiny.png')
}

gameQuads = {
    ['tiles'] = GenerateTileQuads(gameTextures['tiles'])
}