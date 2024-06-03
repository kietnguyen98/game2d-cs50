require 'src/Dependencies'

function love.load()
    -- init randomseed for random function
    math.randomseed(os.time())

    -- setup graphics
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- setup window title
    love.window.setTitle('Super Mario Bros')

    -- setup game screen
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable = true,
        canvas = false
    })

    -- init font
    fontExtraSmall = love.graphics.newFont('fonts/font.ttf', 8)
    fontSmall = love.graphics.newFont('fonts/supermario85dxsuper.ttf', 16)
    fontMedium = love.graphics.newFont('fonts/supermario85dxsuper.ttf', 24)
    fontLarge = love.graphics.newFont('fonts/supermario85dxsuper.ttf', 32)
    fontExtraLarge = love.graphics.newFont('fonts/supermario85dxsuper.ttf', 40)

    -- game state
    gameStateMachine = StateMachine({
        ['start'] = function()
            return StartState()
        end,
        ['play'] = function()
            return PlayState()
        end
    })

    gameStateMachine:change("start")

    -- setup keyboard to keep track of which keys have been pressed in last frame
    love.keyboard.keysPressed = {}
end

function love.resize(width, height)
    push:resize(width, height)
end

function love.update(deltaTime)
    gameStateMachine:update(deltaTime)
    -- reset keys pressed table
    love.keyboard.keysPressed = {}
end

function love.draw()
    push:start()
    gameStateMachine:render()
    push:finish()
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true

    if love.keyboard.keysPressed["escape"] then
        love.event.quit()
    end
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end
