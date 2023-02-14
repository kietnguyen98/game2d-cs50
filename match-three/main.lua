-- import needed modules via dependencies
require 'src/dependencies'

-- define main functions
function love.load()
    -- setup graphics
    love.graphics.setDefaultFilter('nearest', 'nearest')
    -- setup window title
    love.window.setTitle('match three')
    -- setup screen resolution and max dimensions
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT,{
        vsync = true,
        fullscreen = false,
        resizeable = true,
    })

    -- setup timer variables
    currentSecond = 0
    timer = 0

    -- define player keypressed table
    love.keyboard.keysPressed = {}
end

function love.update(deltaTime)
   -- define all of the intervals for our labels
   intervals = {1, 2, 4, 3, 2}

   -- define all of counnters for our labels
   counters = {0, 0, 0, 0, 0}

   -- create Timer entries for each interval and counter
   for i = 1, 5 do
    -- anonymous function that gets every interval[i], in seconnds
        Timer.every(intervals[i], function() 
            counters[i] = counters[i] + 1
        end)
   end

    -- reset keysPressed table
    love.keyboard.keysPressed = {}
end

function love.draw()
    push:apply('start')
    love.graphics.printf('Timer: '..tostring(currentSecond), 0, VIRTUAL_HEIGHT / 2, VIRTUAL_WIDTH, 'center')
    push:apply('end')
end

function love.resize(width, height)
    push:resize(width, height)
end

-- handle player press any key event
function love.keypressed(key)
    love.keyboard.keysPressed[key] = true

    -- close the game if player press escape button
    if love.keyboard.keysPressed["escape"] then
        love.event.quit()
    end
end