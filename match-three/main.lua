-- import needed modules via dependencies
require 'src/Dependencies'

-- define main functions
function love.load()
    -- setup graphics
    love.graphics.setDefaultFilter('nearest', 'nearest')
    
    -- setup window title
    love.window.setTitle('match three')

    -- init randome seed
    math.randomseed(os.time())

    -- setup screen resolution and max dimensions
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT,{
        vsync = true,
        fullscreen = false,
        resizeable = true,
        canvas = true,
    })

    -- define game State machine
    gameStateMachine = StateMachine(
        {
            ['start'] = function() return StartState() end,
            ['begin'] = function() return BeginGameState() end,
            ['play'] = function() return PlayState() end,
            ['game-over'] = function() return GameOverState() end,
        }
    ) 

    -- init start state
    -- gameStateMachine:change('start')
    gameStateMachine:change('game-over',{
        score = 200
    })

    -- init background position
    backgroundPosX = 0
    
    -- define player keypressed table
    love.keyboard.keysPressed = {}
end

function love.update(deltaTime)
    -- scroll the background and looping it
    backgroundPosX = backgroundPosX - BACKGROUND_SCROLL_SPEED * deltaTime
    
    -- reset background position if it scrolled the entire image
    if  backgroundPosX <= -1024 + VIRTUAL_WIDTH - 4 + 51 then
        backgroundPosX = 0
    end

    -- update current game state
    gameStateMachine:update(deltaTime)

    -- reset keysPressed table
    love.keyboard.keysPressed = {}

end

function love.draw()
    push:apply('start')

    -- render the background
    love.graphics.draw(gameTextures['background'], backgroundPosX, 0)

    -- render current game state
    gameStateMachine:render()
    push:apply('end')
end

function love.resize(width, height)
    push:resize(width, height)
end

-- handle player press any key event
-- love.keyPress trigger when ever player press a key
function love.keypressed(key)
    love.keyboard.keysPressed[key] = true

    -- close the game if player press escape button
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