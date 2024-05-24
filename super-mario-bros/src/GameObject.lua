GameObject = class()

function GameObject:init(def)
    self.id = def.id
    self.objectSheet = def.objectSheet
    self.objectQuads = def.objectQuads

    self.width = GAME_OBJECT_WIDTH
    self.height = GAME_OBJECT_HEIGHT

    self.collidable = def.collidable
    self.consumable = def.consumable
end

function GameObject:collides(target)
    -- using AABB   
    return (self.x < target.x + target.width) and (self.x + self.width > target.x) and
               (self.y < target.y + target.height) and (self.y + self.height > target.y)
end

function GameObject:update(deltaTime)
end

function GameObject:render()
    love.graphics.draw(self.objectSheet, self.objectQuads[self.id], (self.x - 1) * self.width,
        (self.y - 1) * self.height)
end
