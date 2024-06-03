CannibalEntity = Entity:extend()

function CannibalEntity:init(def)
    Entity.init(self, def)
    self.scaleRatio = def.scaleRatio
    self.collidable = def.collidable
    self.consumable = def.consumable
    self.onCollide = def.onCollide
    self.onConsume = def.onConsume
end

function CannibalEntity:update(deltaTime)
    Entity.update(self, deltaTime)
end

function CannibalEntity:render()
    love.graphics.draw( -- draw object
    self.sheet, self.quads[self.currentAnimation:getCurrentFrame()], -- position of object on x axis
    self.x + self.width / 2, -- position of object on y axis
    self.y + self.height / 2, -- rotate degree
    0, -- scale on x axis
    (self.direction == "right" and -1 or 1) * self.scaleRatio, -- scale on y axis
    self.scaleRatio, -- origin offset on x axis
    self.width / self.scaleRatio / 2, -- origin offset on y axis
    self.height / self.scaleRatio / 2)
end

