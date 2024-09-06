Obstacle = class()

function Obstacle:init(def)
    self.shape = def.shape or 'horizontal'

    if self.shape == 'horizontal' then
        self.frame = 2
    elseif self.shape == 'vertical' then
        self.frame = 4
    end

    self.startX = def.x
    self.startY = def.y

    self.world = def.world

    self.body = love.physics.newBody(self.world, self.startX or math.random(VIRTUAL_WIDTH),
        self.startY or math.random(VIRTUAL_HEIGHT - 35), 'dynamic')

    -- assign width and height based on shape to create physics shape
    if self.shape == 'horizontal' then
        self.width = 110
        self.height = 35
    elseif self.shape == 'vertical' then
        self.width = 35
        self.height = 110
    end

    self.shape = love.physics.newRectangleShape(self.width, self.height)

    self.fixture = love.physics.newFixture(self.body, self.shape)

    self.fixture:setUserData('Obstacle')
end

function Obstacle:update(deltaTime)
end

function Obstacle:render()
    love.graphics.draw(gameTextures['wood'], gameFrames['wood'][self.frame], self.body:getX(), self.body:getY(),
        self.body:getAngle(), 1, 1, self.width / 2, self.height / 2)
end
