GameObject = class()

function GameObject:init(def)
    self.id = def.id
    self.objectSheet = def.objectSheet
    self.objectQuads = def.objectQuads

    self.x = def.x
    self.y = def.y

    self.width = def.width or GAME_OBJECT_WIDTH
    self.height = def.height or GAME_OBJECT_HEIGHT

    self.collidable = def.collidable
    self.onCollide = def.onCollide
    self.consumable = def.consumable
    self.onConsume = def.onConsume
    self.solid = def.solid

    self.hitTimes = def.hitTimes
end

function GameObject:collides(target)
    local diffFromTargetAndTile = target.width - TILE_WIDTH
    -- using AABB   
    return (self.x < target.x + target.width - diffFromTargetAndTile) and (self.x + self.width > target.x + 1) and
               (self.y < target.y + target.height) and (self.y + self.height > target.y)
end

function GameObject:update(deltaTime)
end

function GameObject:render()
    love.graphics.draw(self.objectSheet, self.objectQuads[self.id], self.x, self.y)
end
