Player = Entity:extend()

function Player:init(def)
    Entity.init(self, def)
end

function Player:update(deltaTime)
    Entity.update(self, deltaTime)
end

function Player:render()
    love.graphics.draw(gameTextures[self.textureName],
        gameQuads[self.quadsName][self.currentAnimation:getCurrentFrame()], math.floor(self.x - self.offsetX),
        math.floor(self.y - self.offsetY))
end
