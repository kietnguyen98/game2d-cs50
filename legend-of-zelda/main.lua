require "src/Dependencies"

function love.load()
    -- init randomseed for random function
    math.randomseed(os.time())

    -- setup graphics
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- setup window title
    love.window.setTitle('Legend of Zelda')

    -- setup game screen
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable = true,
        canvas = false
    })

    -- setup keyboard to keep track of which keys have been pressed in last frame
    love.keyboard.keysPressed = {}
end

function love.resize(width, height)
    push:resize(width, height)
end

function love.update(deltaTime)
    -- reset keys pressed table
    love.keyboard.keysPressed = {}
end

function love.draw()
    push:start()
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
