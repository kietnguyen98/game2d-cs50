Tiles = class()

function Tiles:init()
    self.tileSheet = love.graphics.newImage('assets/blocks.png');
    self.tileQuads = GenerateQuadsTile(self.tileSheet)
    self.tiles = GenerateWorldLevel(MAP_WIDTH, MAP_HEIGHT)
    self.width = #self.tiles
    self.height = #self.tiles[1]
end

function Tiles:update(deltaTime)
end

function Tiles:render()
    for x = 1, MAP_WIDTH do
        for y = 1, MAP_HEIGHT do
            local tile = self.tiles[x][y]

            love.graphics.draw(self.tileSheet, self.tileQuads[tile.quadId], (x - 1) * TILE_WIDTH, (y - 1) * TILE_HEIGHT)
        end
    end
end

function Tiles:getTileFromCharacterPos(characterX, characterY)
    if characterX < 0 or characterX > self.width * TILE_WIDTH or characterY < 0 or characterY > self.height * TILE_HEIGHT then
        return nil
    else 
        return self.tiles[characterX / TILE_WIDTH + 1][characterY / TILE_HEIGHT + 1]
    end
end