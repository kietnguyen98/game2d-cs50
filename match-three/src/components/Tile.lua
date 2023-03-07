Tile = class()

function Tile:init(gridX, gridY, color, variety)
    -- get tile position to the board
    self.gridX = gridX
    self.gridY = gridY

    -- coordinate position to the board
    self.x = (self.gridX - 1) * TILE_WIDTH
    self.y = (self.gridY - 1) * TILE_HEIGHT

    -- color and variety
    self.color = color 
    self.variety = variety > 6 and 6 or variety
end

function Tile:render(x, y)
    -- render tile shadow
    love.graphics.setColor(love.math.colorFromBytes(34, 32, 52, 255))
    love.graphics.draw(
        gameTextures['tiles'], 
        gameQuads['tiles'][self.color][self.variety],
        x + self.x + 3, -- shift the shadow 3px toward to make the effect
        y + self.y + 3  -- shift the shadow 3px toward to make the effect
    )
    
    -- render the tile
    love.graphics.setColor(love.math.colorFromBytes(255, 255, 255, 255)) -- reset the color to setDefaultFilter
    love.graphics.draw(
        gameTextures['tiles'],
        gameQuads['tiles'][self.color][self.variety],
        x + self.x, -- x = board position in x coordinate
        y + self.y  -- y = board position in y coordinate
    )
end