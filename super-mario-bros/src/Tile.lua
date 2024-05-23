Tile = class()

function Tile:init(def)
    self.id = def.id

    self.tileSheet = def.tileSheet
    self.tileQuads = def.tileQuads

    self.x = def.x
    self.y = def.y

    self.width = TILE_WIDTH
    self.height = TILE_HEIGHT

    self.topper = def.topper
end

function Tile:update(deltaTime)
end

function Tile:isCollidable()
    for k, v in pairs(COLLIDABLE_TILE_INDEX) do
        if v == self.id then
            return true
        end
    end

    return false
end

function Tile:render()
    love.graphics.draw(self.tileSheet, self.tileQuads[self.id], (self.x - 1) * self.width, (self.y - 1) * self.height)
end
