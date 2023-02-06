Brick = class()

function Brick:init(x, y)
    -- init brick tier value
    self.tier = 1
    self.color = 1

    -- init brick positional values
    self.x = x
    self.y = y
    
    -- init brick dimensional values
    self.width = BRICK_WIDTH
    self.height = BRICK_HEIGHT

    -- this value is use to determine whether this brick should be rendered
    self.inPlay = true

    -- particle system belonging to the brick, emitted on hit
    self.particleSystem = love.graphics.newParticleSystem(gameTextures['particle'], 64)

    -- the particle should lasts between 0.5s - 1s
    self.particleSystem:setParticleLifetime(0.5, 1)

    -- give it an acceleration of anywhere between X1, Y1 and X2, Y2 - (0, 0) and (80, 80) here
    -- gives generally downward
    self.particleSystem:setLinearAcceleration(-15, 0, 15, 80)

    -- spread of particles, normal looks more natural than uniform, which is clumpy;
    -- numbers are amount of standard deviation away in X and Y axis
    self.particleSystem:setEmissionArea('normal', 10, 10)
end

function Brick:hit()
    -- set the particle system color. The particle system will interpolate between each color evenly over the particle's lifetime.
    -- it our self.color but with varying alpha; brighter for higher tiers, fader for lower tier
    self.particleSystem:setColors(
        PARTICLE_COLOR_PALLETES[self.color]['r'] / 255,
        PARTICLE_COLOR_PALLETES[self.color]['g'] / 255,
        PARTICLE_COLOR_PALLETES[self.color]['b'] / 255,
        55 * self.tier / 255,
        PARTICLE_COLOR_PALLETES[self.color]['r'] / 255,
        PARTICLE_COLOR_PALLETES[self.color]['g'] / 255,
        PARTICLE_COLOR_PALLETES[self.color]['b'] / 255,
        0
    )

    -- emits a burst of particles from the particle emitter
    self.particleSystem:emit(64)

    -- logic to implement brick level system
    if self.tier > 1 then
        if self.color == 1 then
            -- the brick is now at the lowest color level of its tier
            -- it should be reduce to lower tier and its color must be the highest in the new tier  
            self.tier = self.tier - 1
            self.color = 5
        else
            -- the brick color level is > 1 then just reduce its level color
            self.color = self.color - 1
        end    
    else
        -- the brick tier = 1
        if self.color == 1 then
            -- its tier is the lowest and also its level color
            -- remove it out of the game
            self.tier = 0
            self.inPlay = false
        else
            -- just reduce it level color
            self.color = self.color - 1
        end
    end

    if self.tier == 0 then
        gameSounds['brick-hit-1']:stop()
        gameSounds['brick-hit-1']:play()
    else
        gameSounds['brick-hit-2']:stop()
        gameSounds['brick-hit-2']:play()
    end
end

function Brick:update(deltaTime)
    self.particleSystem:update(deltaTime)
end

function Brick:render()
    if self.inPlay then
        love.graphics.draw(gameTextures['main'], gameObjectQuads['bricks'][((self.color - 1) * 4) + self.tier], self.x, self.y)
    end
end

function Brick:renderParticles()
    love.graphics.draw(self.particleSystem, self.x + BRICK_WIDTH / 2, self.y + BRICK_HEIGHT / 2)
end