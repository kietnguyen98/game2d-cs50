Particle = class()

function Particle:init(gridX, gridY, color)
    -- get tile position to the board
    self.gridX = gridX
    self.gridY = gridY

    -- coordinate position to the board
    self.x = (self.gridX - 1) * TILE_WIDTH
    self.y = (self.gridY - 1) * TILE_HEIGHT
       
    -- apply particle system
    self.particleSystem = love.graphics.newParticleSystem(gameTextures['particle'], 64)
    -- each particle should last betweenn 0.25s-0.5s
    self.particleSystem:setParticleLifetime(1.5)

    -- give it an acceleration of anywhere between X1, Y1 and X2, Y2 - (-10, -10) and (10, 20) here
    -- gives generally downward
    self.particleSystem:setLinearAcceleration(-15, -15, 0, 60)

    -- spread of particles, normal looks more natural than uniform, which is clumpy;
    -- numbers are amount of standard deviation away in X and Y axis
    self.particleSystem:setEmissionArea('normal', 12, 12)

    -- set particle color
    self.color = color
end

function Particle:update(deltaTime)
    self.particleSystem:update(deltaTime)
end

function Particle:emit()
    self.particleSystem:setColors(
        PARTICLE_COLOR_PALLETES[self.color]['r'] / 255,
        PARTICLE_COLOR_PALLETES[self.color]['g'] / 255,
        PARTICLE_COLOR_PALLETES[self.color]['b'] / 255,
        0.6,
        PARTICLE_COLOR_PALLETES[self.color]['r'] / 255,
        PARTICLE_COLOR_PALLETES[self.color]['g'] / 255,
        PARTICLE_COLOR_PALLETES[self.color]['b'] / 255,
        0
    )

    self.particleSystem:emit(64)
end

function Particle:render(x, y)
    love.graphics.draw(self.particleSystem, x + self.x + TILE_WIDTH / 2, y + self.y + TILE_HEIGHT / 2)
end