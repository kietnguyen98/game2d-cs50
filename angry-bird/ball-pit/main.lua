VIRTUAL_WIDTH = 640
VIRTUAL_HEIGHT = 360

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

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
    groundBody = love.physics.newBody(world, 0, VIRTUAL_HEIGHT, 'static')

    -- init wall body
    leftWallBody = love.physics.newBody(world, 0, 0, 'static')
    rightWallBody = love.physics.newBody(world, VIRTUAL_WIDTH, 0, 'static')

    -- shape for ground
    groundShape = love.physics.newEdgeShape(0, 0, VIRTUAL_WIDTH, 0);
    wallShape = love.physics.newEdgeShape(0, 0, 0, VIRTUAL_HEIGHT);

    -- create fixture to add shape to the body
    groundFixture = love.physics.newFixture(groundBody, groundShape);
    leftWallFixture = love.physics.newFixture(leftWallBody, wallShape);
    rightWallFixture = love.physics.newFixture(rightWallBody, wallShape);

    -- create dynamic ball
    ballBodies = {}
    ballColors = {}
    ballFixtures = {}
    ballShape = love.physics.newCircleShape(5)

    for i = 1, 1000 do
        ballBody = love.physics.newBody(world, math.random(VIRTUAL_WIDTH), math.random(VIRTUAL_HEIGHT), 'dynamic')
        table.insert(ballBodies, ballBody)
        ballColor = {
            r = math.random(255) / 255,
            g = math.random(255) / 255,
            b = math.random(255) / 255
        }
        table.insert(ballColors, ballColor)
        ballFixture = love.physics.newFixture(ballBody, ballShape)
        table.insert(ballFixtures, ballFixture)
    end

    -- create box
    boxBody = love.physics.newBody(world, math.random(VIRTUAL_WIDTH), 0, "dynamic")
    boxShape = love.physics.newRectangleShape(30, 30)
    boxFixture = love.physics.newFixture(boxBody, boxShape, 20)
end

function push.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    elseif key == "space" then
        boxBody:setPosition(math.random(VIRTUAL_WIDTH), 0)
    end
end

function love.update(deltaTime)
    world:update(deltaTime)
end

function love.draw()
    push:start()
    -- render ground
    love.graphics.setColor(1, 0, 0)
    love.graphics.setLineWidth(2)
    love.graphics.line(groundBody:getWorldPoints(groundShape:getPoints()))

    -- render walls
    love.graphics.setColor(1, 0, 0)
    love.graphics.setLineWidth(2)
    love.graphics.line(leftWallBody:getWorldPoints(wallShape:getPoints()))
    love.graphics.line(rightWallBody:getWorldPoints(wallShape:getPoints()))

    -- render ball pit
    for i = 1, 1000 do
        love.graphics.setColor(ballColors[i].r, ballColors[i].g, ballColors[i].b)
        love.graphics.circle('fill', ballBodies[i]:getX(), ballBodies[i]:getY(), ballShape:getRadius())
    end

    -- render box
    love.graphics.setColor(1, 1, 1)
    love.graphics.polygon("fill", boxBody:getWorldPoints(boxShape:getPoints()))
    push:finish()
end
