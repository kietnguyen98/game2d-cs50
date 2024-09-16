require "src/dependencies"

function love.load()
    math.randomseed(os.time())
    love.graphics.setDefaultFilter("nearest", "nearest");
    love.window.setTitle("Angry Bird")

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable = true
    })

    gameStateMachine = StateMachine({
        ["start"] = function()
            return GameStartState()
        end,
        ["play"] = function()
            return GamePlayState()
        end
    })

    gameStateMachine:change("start")

    love.keyboard.keysPressed = {}
    love.mouse.keysPressed = {}
    love.mouse.keysReleased = {}

    isGamePaused = false
end

function push.resize(width, height)
    push:resize(width, height)
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    elseif key == 'p' then
        isGamePaused = not isGamePaused
    end

    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.mousepressed(x, y, buttonKey)
    love.mouse.keysPressed[buttonKey] = true
end

function love.mouse.wasPressed(buttonKey)
    return love.mouse.keysPressed[buttonKey]
end

function love.mousereleased(x, y, buttonKey)
    love.mouse.keysReleased[buttonKey] = true
end

function love.mouse.wasReleased(buttonKey)
    return love.mouse.keysReleased[buttonKey]
end

function love.update(deltaTime)
    if not isGamePaused then
        gameStateMachine:update(deltaTime)
        love.keyboard.keysPressed = {}
        love.mouse.keysPressed = {}
        love.mouse.keysReleased = {}
    end
end

function love.draw()
    push:start()
    gameStateMachine:render()
    push:finish()
end
