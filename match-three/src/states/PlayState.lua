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

    -- init goal score 
    self.goalScore = 0
    self.currentScore = 0

    self.timer = 60

    -- start a timer
    Timer.every(2, function()
        -- check if player finish current level then stop countdown\
        if not self:isFinishCurrentLevel() then
            self.timer = self.timer - 1
            
            if self.timer <= 5 then
                gameSounds['warning_tick']:play()
            else
                gameSounds['tick']:play()
            end
        end
    end)

    self.firstCalculate = true
    self.isTweening = false
end

function PlayState:enter(params)
    -- init game level
    self.level = params.level
    -- init game tiles board
    self.board = params.board
    self.currentScore = params.score
    -- increase goal score after each level
    self.goalScore =  params.level * 500 + getLevelScoreGap(params.level) * 100

     -- calculate matches for the first time in play state
     if self.board and self.firstCalculate then
        self.firstCalculate = false
        self:calculateMatches()
    end
end

function PlayState:isFinishCurrentLevel()
    return self.currentScore >= self.goalScore
end

function PlayState:checkLevelUp()
  -- check current play state's winning condition
    if self:isFinishCurrentLevel() and not self.isTweening then
        self.canInput = false
        -- clear Timer
        Timer.clear()
          
        -- change to begin game state with new level
        gameStateMachine:change('begin', {
            level = self.level + 1,
            score = self.currentScore,
            currentBoard = self.board,
            isStart = false
        })
    end
end

function PlayState:checkGameOver()
     -- check game over logic
     if self.timer <= 0 then
        -- clear Timer
        Timer.clear()

        gameStateMachine:change('game-over',{
            score = self.currentScore
        })
    end
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
            gameSounds['tile_select']:play()
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

                        -- swap the color of the particle in 2 tile position
                        self.board.particles[self.currentChosenTile.gridY][self.currentChosenTile.gridX].color = self.currentChosenTile.color
                        self.board.particles[selectedTile.gridY][selectedTile.gridX].color = selectedTile.color

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

    -- check game play state
    self:checkGameOver()
    self:checkLevelUp()

    -- update components and Timer
    Timer.update(deltaTime)
    self.highlightedBorder:update(deltaTime)
    self.board:update(deltaTime)
end

function PlayState:calculateMatches()
    -- first calculate
    local matches = self.board:calculateMatches()

    -- matches exist
    while matches do
         -- remove the highlighted border
         self.highlightedBorder.isShow = false
         self.canInput = false
 
         -- update current score before remove all the matches
        -- for each tile in the match, add 1s to player's timer  
         for k, match in pairs(matches) do
            for i, tile in pairs(match) do
                self.currentScore = self.currentScore + 50 + (tile.variety - 1) * 10
            end
            self.timer = self.timer + #match
         end

        -- remove all the matches in the board
        self.board:removeMatches()

        -- shift all the tiles above removed matches go down
        local faillingTweens = self.board:getTilesFallingDownTable(self.level)
        
        self.isTweening = true
        Timer.tween(1, faillingTweens):finish(function()

            self.highlightedBorder.isShow = true
            self.canInput = true

            if self:isFinishCurrentLevel() then
                -- stop background music and play level complete sound effect
                love.audio.stop(gameSounds['background_music'])
                gameSounds['level_complete']:play()
            end
            
            Timer.after(1.5, function()
                -- delay 0.5s for finish particle animation
                self.isTweening = false
                -- resume background music
                if self:isFinishCurrentLevel() then
                    love.audio.play(gameSounds['background_music'])
                end
            end)
        end)
        
        matches = self.board:calculateMatches()
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

    -- render GUI overlay
    love.graphics.setColor(OverlayColor.BLACK_BLUR)
    love.graphics.rectangle('fill', 10, 11, 152, 110, 8)
    -- render GUI text 
    love.graphics.setColor(TextOptionColor.HIGHT_LIGHT)
    love.graphics.setFont(gameFonts['medium'])
    love.graphics.printf('Level: '..tostring(self.level), 20, 21, 142, 'left')
    love.graphics.printf('score: '..tostring(self.currentScore), 20, 46, 142, 'left')
    love.graphics.setColor(TextOptionColor.NORMAL)
    love.graphics.printf('goal: '..tostring(self.goalScore), 20, 71, 142, 'left')
    if(self.timer > 5) then
        love.graphics.setColor(TextOptionColor.HIGHT_LIGHT)
    else
        love.graphics.setColor(GlobalColor.RED)
    end
    love.graphics.printf('Timer: '..tostring(self.timer), 20, 96, 142, 'left')

end
