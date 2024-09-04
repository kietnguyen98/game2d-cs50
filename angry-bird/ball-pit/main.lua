VIRTUAL_WIDTH = 640
VIRTUAL_HEIGHT = 360

WINDOW_WIDTH = 1920
WINDOW_HEIGHT = 1080

DEGREES_TO_RADIANS = math.pi / 180
RADIANS_TO_DEGREES = 180 / math.pi

push = require "./library/push"

function love.load()
    math.randomseed(os.time())
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setTitle("Ball Pit Example")

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable = true
    })

    -- init physics world
    world = love.physics.newWorld(0, 300)

    -- init ground body
    groundBody = love.physics.newBody(world, 0, VIRTUAL_HEIGHT - 30, 'static')

    -- init wall body
    leftWallBody = love.physics.newBody(world, 0, 0, 'static')
    rightWallBody = love.physics.newBody(world, VIRTUAL_WIDTH, 0, 'static')

    -- shape for ground
    groundShape = love.physics.newEdgeShape(0, 0, VIRTUAL_WIDTH, 0);
    wallShape = love.physics.newEdgeShape(0, 0, 0, VIRTUAL_HEIGHT);

    -- create fixture to add shape to the body
    groundFixture = love.physics.newFixture(groundBody, groundShape);
    leftWallFixture = love.physics.newFixture(leftWallBody, wallShape);
    rightWallBody = love.physics.newFixture(rightWallBody, wallShape);

end

function push.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end

function love.update(deltaTime)
end

function love.draw()
end
