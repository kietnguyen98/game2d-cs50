HighlightedBorder = class()

function HighlightedBorder:init()
    -- init border colorsheet
    self.colorSheet = {
        [1] = {230/255, 153/255, 153/255, 1},
        [2] = {230/255, 128/255, 128/255, 1},
        [3] = {230/255, 102/255, 102/255, 1},
        [4] = {230/255, 77/255, 77/255, 1},
        [5] = {230/255, 51/255, 51/255, 1},
        [6] = {230/255, 77/255, 77/255, 1},
        [7] = {230/255, 102/255, 102/255, 1},
        [8] = {230/255, 128/255, 128/255, 1},
    }

    -- init current color
    self.currentColor = self.colorSheet[1]

    -- set the timer to update the current color
    -- the color sheet will be iterate for every 2s while the game is playing
    -- to get the exact color
    self.index = 1
    Timer.every(1.2 / 8, function() 
        self.index = self.index + 1
        if self.index > 8 then
            self.index = 1 -- reset timer to 1
        end
        self.currentColor = self.colorSheet[self.index]
    end)
end

function HighlightedBorder:update(deltaTime)
    Timer.update(deltaTime)
end

function HighlightedBorder:render(x, y)
    love.graphics.setColor(self.currentColor)
    love.graphics.setLineWidth(3)
    love.graphics.rectangle('line', x, y, TILE_WIDTH, TILE_HEIGHT, 4)
end