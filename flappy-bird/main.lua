-- import need libraries
push = require "library/push"
require "library/class"
require "Bird"
require "Pipe"
require "Coin"
require "PipePair"
require "StateMachine"
require "states/BaseState"
require "states/PlayState"
require "states/TitleScreenState"
require "states/ScoreState"
require "states/CountDownState"

-- define general constants for window settings
WINDOW_WIDTH = 900
WINDOW_HEIGHT = 506.25

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

-- define background and ground image object
local background = love.graphics.newImage('assets/background.png')
local ground = love.graphics.newImage('assets/ground.png')

-- define background and ground scroll position
local backgroundScroll = 0
local groundScroll = 0

-- define background and ground scroll velocity
local BACKGROUND_SCROLL_SPEED = 30
local GROUND_SCROLL_SPEED = 60

-- define background looping point
local BACKGROUND_LOOPING_POINT = 413

-- define is scrooling
isScrolling = true

function love.load()
    -- define init setting

    -- seed the random number
    math.randomseed(os.time())

    -- graphics
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- window
    love.window.setTitle('Flappy Bird')
    
    -- init font
    fontSmall = love.graphics.newFont('fonts/WheatonCapitals.otf', 16)
    fontMedium = love.graphics.newFont('fonts/WheatonCapitals.otf', 20)
    fontLarge = love.graphics.newFont('fonts/WheatonCapitals.otf', 24)
    fontExtraLarge = love.graphics.newFont('fonts/WheatonCapitals.otf', 60)

    -- init sounds
    sounds = {
        ['jump'] = love.audio.newSource('sounds/jump.wav', 'static'),
        ['score'] = love.audio.newSource('sounds/score.wav', 'static'),
        ['hurt'] = love.audio.newSource('sounds/hurt.wav', 'static'),
        ['explosion'] = love.audio.newSource('sounds/explosion.wav', 'static'),
        ['music'] = love.audio.newSource('sounds/music.mp3', 'static'),
    }

    -- play background music
    sounds['music']:setLooping(true)
    sounds['music']:play()

    -- push
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT,{
        fullscreen = false,
        resizable = true,
        vsync = true,
    })

    -- init game state machine with all state-returning function
    gameStateMachine = StateMachine({
        ['title'] = function() return TitleScreenState() end,
        ['play'] = function() return PlayState() end,
        ['score'] = function() return ScoreState() end,
        ['countDown'] = function () return CountDownState() end,
    })

    -- init state
    gameStateMachine:change('title')

    -- init keyboard keys pressed list
    love.keyboard.keysPressed = {}

end

function love.update(deltaTime)
    -- scroll the background and ground to the back and looping that again to make the infinite scrooling effect
    if isScrolling then
        backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * deltaTime) % BACKGROUND_LOOPING_POINT
        groundScroll = (groundScroll + GROUND_SCROLL_SPEED * deltaTime) % VIRTUAL_WIDTH
    end
    
    gameStateMachine:update(deltaTime)
    
    -- reset keyboard keys pressed list
    love.keyboard.keysPressed = {}
end

function love.draw()
    push:start()
    -- init background and ground
    love.graphics.draw(background, -backgroundScroll, 0)
    gameStateMachine:render()
    love.graphics.draw(ground, -groundScroll, VIRTUAL_HEIGHT - 16) -- ground image height = 16

    push:finish()
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true

    if key == 'escape' then
        love.event.quit()
    end
end

function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
        return true
    else
        return false
    end
end

function love.resize(width, height)
    push:resize(width, height)
end