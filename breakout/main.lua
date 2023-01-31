-- import needed libary and dependencies
require "src/Dependencies"

-- define main functions
function love.load()
    -- set up graphics
    love.graphics.setDefaultFilter('nearest', 'nearest')
    -- set up math random seed
    math.randomseed(os.time())
    -- set up window
    love.window.setTitle('Breakout')
    -- set up fonts
    gameFonts = {
        ["small"] = love.graphics.newFont('fonts/halo.TTF',12),
        ["medium"] = love.graphics.newFont('fonts/halo.TTF', 16),
        ["large"] = love.graphics.newFont('fonts/halo.TTF', 24),
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
    gameSounds = {
        ['paddle-hit'] = love.audio.newSource('sounds/paddle_hit.wav', 'static'),
        ['score'] = love.audio.newSource('sounds/score.wav', 'static'),
        ['wall-hit'] = love.audio.newSource('sounds/wall_hit.wav', 'static'),
        ['confirm'] = love.audio.newSource('sounds/confirm.wav', 'static'),
        ['select'] = love.audio.newSource('sounds/select.wav', 'static'),
        ['no-select'] = love.audio.newSource('sounds/no_select.wav', 'static'),
        ['brick-hit-1'] = love.audio.newSource('sounds/brick_hit_1.wav', 'static'),
        ['brick-hit-2'] = love.audio.newSource('sounds/brick_hit_2.wav', 'static'),
        ['hurt'] = love.audio.newSource('sounds/hurt.wav', 'static'),
        ['victory'] = love.audio.newSource('sounds/victory.wav', 'static'),
        ['recover'] = love.audio.newSource('sounds/recover.wav', 'static'),
        ['high-score'] = love.audio.newSource('sounds/high_score.wav', 'static'),
        ['pause'] = love.audio.newSource('sounds/pause.wav', 'static'),
    
        ['music'] = love.audio.newSource('sounds/background_music.mp3', 'static'),
    }
    
    -- init fsm and setup init state
    gameStateMachine = StateMachine({
        ['start'] = function() return StartState() end
    })

    -- run initial state
    gameStateMachine:change('start')

    -- setup keyboard to keep track of which keys have been pressed in last frame
    love.keyboard.keysPressed = {}
end

function love.update()
    gameStateMachine:update()

    -- reset keys pressed table
    love.keyboard.keysPressed = {}

end

function love.draw()
    -- init push library
    push:apply('start')

    -- init background
    local backgroundWidth = gameTextures['background']:getWidth()
    local backgroundHeight = gameTextures['background']:getHeight()

    love.graphics.draw(gameTextures['background'], 0 , 0, 0, VIRTUAL_WIDTH / (backgroundWidth - 1), VIRTUAL_HEIGHT / (backgroundHeight - 1))

    -- render current state
    gameStateMachine:render()

    -- finish using push
    push:apply('end')
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true

    if love.keyboard.keysPressed["escape"] then
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
