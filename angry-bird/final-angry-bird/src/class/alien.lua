Alien = class()

ALIEN_SPRITE_INDEX = {
    ['square'] = {1, 2, 3, 4, 5, 8, 11, 12, 13, 14},
    ['circle'] = {6, 7, 9, 10, 15}
}

ALIEN_WIDTH = 35;
ALIEN_HEIGHT = ALIEN_WIDTH;

function Alien:init(def)
    self.world = def.world
    self.type = def.type or 'square'

    self.body = love.physics.newBody(self.world, def.x or math.random(VIRTUAL_WIDTH),
        def.y or math.random(VIRTUAL_HEIGHT - ALIEN_HEIGHT), 'dynamic')

    -- different shape and sprite based on type passed in
    if self.type == 'square' then
        self.shape = love.physics.newRectangleShape(ALIEN_WIDTH, ALIEN_HEIGHT)
        self.sprite = ALIEN_SPRITE_INDEX.square[math.random(#ALIEN_SPRITE_INDEX.square)]
    elseif self.type == 'circle' then
        self.shape = love.physics.newCircleShape(ALIEN_WIDTH / 2)
        self.sprite = ALIEN_SPRITE_INDEX.circle[math.random(#ALIEN_SPRITE_INDEX.circle)]
    end

    self.fixture = love.physics.newFixture(self.body, self.shape)

    self.fixture:setUserData(userData)

    -- used to keep track of despawning the Alien and flinging it
    self.launched = false
end

function Alien:update(deltaTime)
end

function Alien:render()
    love.graphics.draw(gameTextures['aliens'], gameFrames['aliens'][self.sprite], math.floor(self.body:getX()),
        math.floor(self.body:getY()), self.body:getAngle(), 1, 1, ALIEN_WIDTH / 2, ALIEN_HEIGHT / 2)
end
