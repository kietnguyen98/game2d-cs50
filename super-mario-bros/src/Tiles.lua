Tiles = class()

function Tiles:init(def)
    self.width = def.width
    self.height = def.height
    self.tiles = {}
end

function Tiles:update(deltaTime)
end

function Tiles:render()
    for x = 1, self.width do
        for y = 1, self.height do
            self.tiles[x][y]:render()
        end
    end
end

function Tiles:getTileFromPosition(x, y)
    if x < 0 or x > self.width * TILE_WIDTH or y < 0 or y > self.height * TILE_HEIGHT then
        return nil
    else
        return self.tiles[math.floor(x / TILE_WIDTH) + 1][math.floor(y / TILE_HEIGHT) + 1]
    end
end
