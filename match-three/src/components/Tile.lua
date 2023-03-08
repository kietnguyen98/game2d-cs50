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

    self.isShiny = math.random(1, 20) > 19

    if self.isShiny then
        self.shinyAlpha = 0.8
        Timer.every(0.4, function()
            self.shinyAlpha = self.shinyAlpha == 0.3 and 0.1 or 0.3
        end)
    end
end

function Tile:update(deltaTime)
    -- if self.isShiny then
    --     Timer.update(deltaTime)
    -- end
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

    -- render a shiny layer on above the tile if it is a shiny tile
    if self.isShiny then
        love.graphics.draw(gameTextures['shiny_layer'], x + self.x, y + self.y)
    end
end