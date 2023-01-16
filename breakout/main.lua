-- define needed library
push = require "lib/push"

require "src/constants"

require "src/StateMachine"

-- define main functions
function love.load()
    -- set up graphics
    love.graphics.setDefault('nearest', 'nearest')
    -- set up math random seed
    math.randomseed(os.time())
    -- set up window
    love.window.setTitle('Breakout')
    -- set up fonts
    gameFonts = {
        ["small"] = love.graphics.newFont('fonts/halo.TTF',12),
        ["medium"] = love.graphics.newFont('fonts/halo.TTF', 20),
        ["large"] = love.graphics.newFont('fonts/halo.TTF', 32),
    }
    love.graphics.setFont(gameFonts["small"])
    -- set up all the assets/textures in the game
    gameTextures = {
        ["background"] = love.graphics.newImage('assets/background.png'),
        ["main"] = love.graphics.newImage('assets/breakout.png'),
        ["arrows"] = love.graphics.newImage('assets/arrows.png'),
        ["hearts"] = love.graphics.newImage('assets/hearts.png'),
        ["particle"] = love.graphics.newImage('assets/particle.png'),
    }
    -- setup window screen, init virtual resolution
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT,{
        vsync = true,
        fullscreen = false,
        resizeable = true,
    })

    -- setup all sounds for the game

    -- init fsm and setup init state
    gameStateMachine = StateMachine({
        ['start'] = function() return StartState() end
    })

    gameStateMachine:change('start')

    -- setup keyboard to keep track of which keys have been pressed in last frame
    love.keyboard.keysPressed = {}
end

function love.update()
    
end

function love.draw()
end