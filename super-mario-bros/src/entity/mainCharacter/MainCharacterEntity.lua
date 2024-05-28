MainCharacterEntity = Entity:extend()

function MainCharacterEntity:init(def)
    self.score = 0
    Entity.init(self, def)
end

function MainCharacterEntity:update(deltaTime)
    Entity.update(self, deltaTime)

    -- constraint main character to not go out of the mapHeight
    if self.x >= self.tilesMap.width * TILE_WIDTH - self.width then
        self.x = self.tilesMap.width * TILE_WIDTH - self.width
    elseif self.x <= 0 then
        self.x = 0
    end
end

function MainCharacterEntity:render()
    Entity.render(self)
end

function MainCharacterEntity:moveLeft(deltaTime)
    self.x = self.x - CHARACTER_SPEED * deltaTime
    self.direction = "left"
    self:checkLeftCollisions(deltaTime)
end

function MainCharacterEntity:moveRight(deltaTime)
    self.x = self.x + CHARACTER_SPEED * deltaTime
    self.direction = "right"
    self:checkRightCollisions(deltaTime)
end

function MainCharacterEntity:checkLeftCollisions(deltaTime)
    local topLeftTile = self.tilesMap:getTileFromPosition(self.x + 1, self.y + 1)
    local bottomLeftTile = self.tilesMap:getTileFromPosition(self.x + 1, self.y + self.height - 1)

    if (topLeftTile and bottomLeftTile) and (topLeftTile:isCollidable() or bottomLeftTile:isCollidable()) then
        -- collide
        -- should reset player position to the most right side of the collide object
        self.x = topLeftTile.x * topLeftTile.width - 1
    else
        -- not collide

    end
end

function MainCharacterEntity:checkRightCollisions(deltaTime)
    local topRightTile = self.tilesMap:getTileFromPosition(self.x + self.width - 1, self.y + 1)
    local bottomRightTile = self.tilesMap:getTileFromPosition(self.x + self.width - 1, self.y + self.height - 1)

    if (topRightTile and bottomRightTile) and (topRightTile:isCollidable() or bottomRightTile:isCollidable()) then
        -- collide
        -- should reset player position to the most right side of the collide object
        self.x = (topRightTile.x - 1) * topRightTile.width - self.width
    else
        -- not collide

    end
end

function MainCharacterEntity:checkObjectCollisions(deltaTime)
end
