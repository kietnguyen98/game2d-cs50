Player = Entity:extend()

function Player:init(def)
    Entity.init(self, def)
end

function Player:update(deltaTime)
    Entity.update(self, deltaTime)
    if self.isImmortal then
        self.colorTimer = self.colorTimer + deltaTime
        if self.colorTimer > 5 * deltaTime then
            self.colorTimer = 0
        end

        self.immortalTimer = self.immortalTimer + deltaTime
        if self.immortalTimer > self.immortalDuration then
            self.isImmortal = false
            self.immortalTimer = 0
            self.colorTimer = 0
        end
    end
end

function Player:goImmortal(duration)
    self.isImmortal = true
    self.immortalTimer = 0
    self.colorTimer = 0
    self.immortalDuration = duration
end

function Player:render()
    if self.isImmortal then
        if self.colorTimer == 0 then
            love.graphics.setColor(255, 255, 255, 0.75)
        else
            love.graphics.setColor(255, 255, 255, 255)
        end
    end
    love.graphics.draw(gameTextures[self.textureName],
        gameQuads[self.quadsName][self.currentAnimation:getCurrentFrame()], math.floor(self.x - self.offsetX),
        math.floor(self.y - self.offsetY))
    love.graphics.setColor(255, 255, 255, 255)

    self.stateMachine:render()

    -- render player hitbox
    if self.renderHitbox then
        love.graphics.setColor(255 / 255, 0, 0, 255)
        love.graphics.rectangle('line', self.hitbox.x, self.hitbox.y, self.hitbox.width, self.hitbox.height)
        love.graphics.setColor(255, 255, 255, 255)
    end
end
