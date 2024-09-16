GameStartState = BaseState:extend()

function GameStartState:init(def)
    self.background = Background()

    -- init physics world
    self.world = love.physics.newWorld(0, 300)

    -- ground
    self.groundBody = love.physics.newBody(self.world, 0, VIRTUAL_HEIGHT, 'static')
    self.groundShape = love.physics.newEdgeShape(0, 0, VIRTUAL_WIDTH, 0)
    self.groundFixture = love.physics.newFixture(self.groundBody, self.groundShape)

    -- walls
    self.leftWallBody = love.physics.newBody(self.world, 0, 0, 'static')
    self.rightWallBody = love.physics.newBody(self.world, VIRTUAL_WIDTH, 0, 'static')
    self.wallShape = love.physics.newEdgeShape(0, 0, 0, VIRTUAL_HEIGHT)
    self.leftWallFixture = love.physics.newFixture(self.leftWallBody, self.wallShape)
    self.rightWallFixture = love.physics.newFixture(self.rightWallBody, self.wallShape)

    -- lots of aliens
    self.aliens = {}

    for i = 1, 100 do
        table.insert(self.aliens, Alien({
            world = self.world,
            type = math.random(2) == 1 and "square" or "circle"
        }))
    end
end

function GameStartState:enter(params)
end

function GameStartState:update(deltaTime)
    if love.keyboard.wasPressed("enter") or love.keyboard.wasPressed("return") then
        gameStateMachine:change("play")
    end

    self.world:update(deltaTime)
    self.background:update(deltaTime)
end

function GameStartState:render(deltaTime)
    -- background
    self.background:render()

    -- render aliens
    for k, alien in pairs(self.aliens) do
        alien:render()
    end

    -- title text
    love.graphics.setColor(64 / 255, 64 / 255, 64 / 255, 200 / 255)
    love.graphics.rectangle('fill', VIRTUAL_WIDTH / 2 - 80, VIRTUAL_HEIGHT / 2 + 32, 160, 80, 3)

    love.graphics.setColor(220 / 255, 220 / 255, 220 / 255, 1)
    love.graphics.setFont(gameFonts['large'])
    love.graphics.printf('Angry Bird', 0, VIRTUAL_HEIGHT / 2 + 40, VIRTUAL_WIDTH, 'center')

    -- instruction text
    love.graphics.setColor(220 / 255, 220 / 255, 220 / 255, 1)
    love.graphics.setFont(gameFonts['medium'])
    love.graphics.printf('Click to start!', 0, VIRTUAL_HEIGHT / 2 + 80, VIRTUAL_WIDTH, 'center')
end
