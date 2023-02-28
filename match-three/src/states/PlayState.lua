PlayState = BaseState:extend()

function PlayState:init()
    -- start state transitionn animation, using fade in animation
    self.transitionAlpha = 1

    -- init highlighted tile position on the board grid
    -- start at x = 0, y = 0, first tile of the board on top-left
    self.highlightedTileX = 0
    self.highlightedTileY = 0
    self.highlightedBorder = HighlightedBorder() 

    -- init currennt chosen tile
    self.currentChosenTile = nil
    
    -- state variable for accept player input
    self.canInput = true
end

function PlayState:enter(params)
    -- init game level
    self.level = params.level
    -- init game tiles board
    self.board = params.board

end

function PlayState:update(deltaTime)

    if self.canInput then
            -- handle player input to move and change the current highlighted tile
        if love.keyboard.wasPressed('up') then
           self.highlightedTileY = math.max(0, self.highlightedTileY - 1) -- must >= 0
        elseif love.keyboard.wasPressed('down') then
           self.highlightedTileY = math.min(7, self.highlightedTileY + 1) -- must <= 7
        elseif love.keyboard.wasPressed('left') then 
           self.highlightedTileX = math.max(0, self.highlightedTileX - 1) -- must >= 0
        elseif love.keyboard.wasPressed('right') then 
           self.highlightedTileX = math.min(7, self.highlightedTileX + 1) -- must <= 7
        end
    
        -- handle player to select title
        if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
            local selectedTile = self.board.tiles[self.highlightedTileY + 1][self.highlightedTileX + 1]
            -- check if there is a chosen tile and it is the same with the selected 
            if self.currentChosenTile then
                if self.currentChosenTile == selectedTile then
                    -- deselect the current
                    self.currentChosenTile = nil 
                else
                    -- check if the selected tile and the current highlighted tile are neighbor in X and Y coordinate
                    -- if true then the total from there absolute dif in x and y axis must be 1
                    if  math.abs(self.currentChosenTile.gridX - selectedTile.gridX) + math.abs(self.currentChosenTile.gridY - selectedTile.gridY) > 1 then
                        -- not neighbor
                        -- just deselect the current tile
                        self.currentChosenTile = nil
                    else
                        -- neighbor
                        -- swap grid position of two tiles
                        local tempCurrentGridX = self.currentChosenTile.gridX
                        local tempCurrentGridY = self.currentChosenTile.gridY
                   
                        self.currentChosenTile.gridX = selectedTile.gridX
                        self.currentChosenTile.gridY = selectedTile.gridY
                        selectedTile.gridX = tempCurrentGridX
                        selectedTile.gridY = tempCurrentGridY
                        -- swap tiles in the tiles board
                        self.board.tiles[self.currentChosenTile.gridY][self.currentChosenTile.gridX] = self.currentChosenTile
                        self.board.tiles[selectedTile.gridY][selectedTile.gridX] = selectedTile
                   
                   
                        Timer.tween(0.2, {
                            [self.currentChosenTile] = {x = selectedTile.x, y = selectedTile.y},
                            [selectedTile] = {x = self.currentChosenTile.x, y = self.currentChosenTile.y}
                        }):finish(function() 
                            -- after switch reset current chosen tile to nil
                            self.currentChosenTile = nil
                            self:calculateMatches()
                        end)
                    end
                end
            else
                -- if there is not tile hightlighted, the just highlight it
                self.currentChosenTile = selectedTile
            end
        end
    end

    Timer.update(deltaTime)
    self.highlightedBorder:update(deltaTime)
end

function PlayState:calculateMatches()
    local matches = self.board:calculateMatches()

    if matches then
        -- remove the highlighted border
        self.highlightedBorder.isShow = false
        self.canInput = false

        -- remove all the matches in the board
        self.board:removeMatches()

        -- shift all the tiles above removed matches go down
        local faillingTweens = self.board:getTilesFallingDownTable()
        Timer.tween(0.5, faillingTweens):finish(function() 
            self.highlightedBorder.isShow = true
            self.canInput = true
        end)
    else
        self.highlightedBorder.isShow = true
        self.canInput = true
    end
end

function PlayState:render()
    -- render tiles board
    self.board:render()

    -- render an overlay on the current selected tile
    if self.currentChosenTile then
        -- multiply so drawing white rect make it brighter
        love.graphics.setBlendMode('add')
        
        love.graphics.setColor(OverlayColor.WHITE_BLUR)
        love.graphics.rectangle(
            'fill', 
            self.board.x + self.currentChosenTile.x, 
            self.board.y + self.currentChosenTile.y, 
            TILE_WIDTH, 
            TILE_HEIGHT, 
            4
        )

        -- get back to alpha mode 
        love.graphics.setBlendMode('alpha')
    end

    -- render the highlighted tile border
    self.highlightedBorder:render(
        self.board.x + self.highlightedTileX * TILE_WIDTH,
        self.board.y + self.highlightedTileY * TILE_HEIGHT
    )
end