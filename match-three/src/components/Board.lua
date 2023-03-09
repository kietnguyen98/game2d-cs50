Board = class()

function Board:init(x, y, level)
    -- init board with x, y dimension
    self.x = x    
    self.y = y
    self.level = level
    -- init matches table to manage all the tile in this board
    self.matches = {}
    self:initializeTiles()
end

function Board:initializeTiles()
    -- initialize tiles table
    self.tiles = {}
    -- initialize tile particle table
    self.particles = {}

    for tileY = 1, 8 do
        self.tiles[tileY] = {}
        self.particles[tileY] = {}
        for tileX = 1, 8 do
            local tileColor = math.random(#TileColorList)

            -- create a new tile at x and y position  with a random color and variety
            table.insert(self.tiles[tileY], tileX, Tile(tileX, tileY, TileColorList[tileColor], self.level))
       
            -- create a new particle with the same x, y position and same color at the new tile
            table.insert(self.particles[tileY], tileX, Particle(tileX, tileY, TileColorList[tileColor]))
        end
    end
end

function Board:render()
    -- render the board border annd background
    -- shadow
    love.graphics.setColor(GlobalColor.LIGHT_BLACK)
    love.graphics.rectangle('fill', self.x, self.y, 8 * TILE_WIDTH + 10, 8 * TILE_HEIGHT + 10, 5)
  
    -- background
    love.graphics.setColor(GlobalColor.DARK_GRAY)
    love.graphics.rectangle('fill', self.x - 5, self.y - 5, 8 * TILE_WIDTH + 10, 8 * TILE_HEIGHT + 10, 5)

    -- border
    love.graphics.setColor(GlobalColor.LIGHT_GRAY)
    love.graphics.setLineWidth(1)
    love.graphics.rectangle('line', self.x - 5, self.y - 5, 8 * TILE_WIDTH + 10, 8 * TILE_HEIGHT + 10, 5)

    -- render all the tiles in the board
    for y = 1, #self.tiles do
        for x = 1, #self.tiles[y] do
            if self.tiles[y][x] then
                self.tiles[y][x]:render(self.x, self.y)
            end

            self.particles[y][x]:render(self.x, self.y)
        end
    end
end

function Board:update(deltaTime)
    -- update each tile in the board
    for y = 1, #self.tiles do
        for x = 1, #self.tiles[y] do
            if self.tiles[y][x] then
                self.tiles[y][x]:update(deltaTime)
            end
        end
    end
    
    -- update each particle in the board
    for y = 1, #self.tiles do
        for x = 1, #self.tiles[y] do
            self.particles[y][x]:update(deltaTime)
        end
    end
end

function Board:calculateShinyMatches(matchDirection, currentGridY, currentGridX)
    local match = {}
    for xi = 1, 8 do
        if matchDirection == "col" then
            if xi ~= currentGridX then
                table.insert(match, self.tiles[currentGridY][xi])
            end
        elseif matchDirection == "row" then
            table.insert(match, self.tiles[currentGridY][xi])
        end
    end

    return match
end

function Board:calculateMatches()
    -- init a table of all matches in the board
    local matches = {}

    -- init a variable to record how many tiles that match in a rows
    local matchNum = 1
    
    -- checking matches in horizontal direction
    -- iterate on every rows
    for y = 1, 8 do
        -- set the currentColor by the first tile of the row's color
        local currentColor = self.tiles[y][1].color

        -- reset matchNum
        matchNum = 1
        
        -- iterate on every tiles in this row
        for x = 2, 8 do
            
            -- if this is the tile with the same color with the current 
            if self.tiles[y][x].color == currentColor then
                matchNum = matchNum + 1
            else
                -- this tile color doesnt match with the current color so switch current color to the new tile's color
                currentColor = self.tiles[y][x].color 

                -- check if we have a match of 3 tiles or higher up till now
                if matchNum >= 3 then
                    local match = {}
                    for xi = x - 1, x - matchNum, -1 do
                        table.insert(match, self.tiles[y][xi])
                        if self.tiles[y][xi].isShiny then
                            match = {}
                            table.insert(matches, self:calculateShinyMatches('row', y, xi))
                            break
                        end
                    end

                    -- insert the new match to matches table
                    table.insert(matches, match)
                end

                -- reset the matchNum to count new color's matches from the start
                matchNum = 1

                -- if we are at the 7th tile, stop and turnn to the next row
                -- because we have 2 tiles left and 2 tiles cant make the match 3 any way
                if x == 7 then
                    break
                end
            end
        end

        -- we are at the last tile in a row, the 8th tile
        -- after iterate all tiles in the row, check if there is any match
        -- that is placed in the end of the row
        if matchNum >= 3 then
            local match = {}
            for xi = 8, 8 - matchNum + 1, -1 do
                table.insert(match, self.tiles[y][xi])
                if self.tiles[y][xi].isShiny then
                    match = {}
                    table.insert(matches, self:calculateShinyMatches('row', y, xi))
                    break
                end
            end
            
            table.insert(matches, match)
        end
    end

    -- checking matches on vertical direction
    -- iterate on every cols
    for x = 1, 8 do
        -- set the current color for the first tile of the colummn's color 
        local currentColor = self.tiles[1][x].color

        -- reset the matchNum
        matchNum = 1

        -- iterate on every row in this col
        for y = 2, 8 do
            if self.tiles[y][x].color == currentColor then
                matchNum = matchNum + 1
            else
                currentColor = self.tiles[y][x].color

                if matchNum >= 3 then

                    local match = {}

                    for yi = y - 1, y - matchNum, -1 do
                        table.insert(match, self.tiles[yi][x])
                        if self.tiles[yi][x].isShiny then
                            local rowMatch = {}
                            table.insert(matches, self:calculateShinyMatches('col', yi, x))
                        end
                    end

                    table.insert(matches, match)
                end

                matchNum = 1

                if y == 7 then
                    break
                end
            end
        end

        if matchNum >= 3 then
            local match = {}

            for yi = 8, 8 - matchNum + 1, -1 do
                table.insert(match, self.tiles[yi][x])
                if self.tiles[yi][x].isShiny then
                    local rowMatch = {}
                    table.insert(matches, self:calculateShinyMatches('col', yi, x))
                end
            end

            table.insert(matches, match)
        end
    end

    -- save current matches to properties
    self.matches = matches
    
    return #self.matches > 0 and self.matches or false
end

function Board:removeMatches()
    if #self.matches > 0 then
        for i, matches in pairs(self.matches) do
            for j, match in pairs(matches) do
                -- emit the particle to apply the destruction effect
                self.particles[match.gridY][match.gridX]:emit()

                -- remove the tile from the tiles table after the animation is done
                self.tiles[match.gridY][match.gridX] = nil
            end
            -- apply sound effect
            gameSounds['explosion']:play()
        end
    end

    -- reset the matches after remove all the match
    self.matches = {}
end

function Board:getTilesFallingDownTable(level)
    -- tween table, with tiles as key and their x and y as values
    local tweens = {}

    -- iterate on each col from left to right
    for x = 1, 8 do
        local isSpace = false
        local spaceGridY = 0

        local currentYGrid = 8
        while currentYGrid >= 1 do
            local currentTile = self.tiles[currentYGrid][x]

            if isSpace then 
                -- if there is a space under this grid should check if there is a tile at current grid
                -- if there is a tile, should swap this tile and the lowest space grid
                if currentTile then
                    -- set the lowest space grid to currentTile
                    -- update tiles table
                    self.tiles[spaceGridY][x] = currentTile
                    
                    -- update current tile grid properties
                    currentTile.gridY = spaceGridY
                    
                    -- set the current tile grid to nil
                    self.tiles[currentYGrid][x] = nil

                    -- add to tween list
                    tweens[currentTile] = {
                        x = currentTile.x, -- the x position remain the same while we the tiles falling down only in y coordinate
                        y = (spaceGridY - 1) * TILE_HEIGHT 
                    }

                    -- update current particle color which position is the same 
                    -- as currennt tile to new tile color
                    self.particles[spaceGridY][x].color = currentTile.color
                
                    -- reset state
                    isSpace = false
                    currentYGrid = spaceGridY

                    spaceGridY = 0
                end
            elseif currentTile == nil then
                isSpace = true

                if spaceGridY == 0 then
                    spaceGridY = currentYGrid
                end
            end

            currentYGrid = currentYGrid - 1
        end
    end

    -- generate new tile above the board
    -- preparing the above tiles to replace those tiles which have been destroyed
    for x = 1, 8 do
        local blankYGrid = 0
        for y = 8, 1, -1 do
            local tile = self.tiles[y][x]
            
            -- check if the current tile is nill
            if not tile then
                blankYGrid = blankYGrid + 1
                -- create a new tile to replace the nill tile
                local newTile = Tile(x, y, TileColorList[math.random(#TileColorList)], level)
                -- update new tile's y value for tweening effect
                newTile.y = blankYGrid * -32
                -- add new tile to tiles list
                self.tiles[y][x] = newTile
                
                -- update current particle color which position is the same 
                -- as currennt tile to new tile color
                self.particles[y][x].color = newTile.color
                
                -- add to tween table
                tweens[newTile] = {
                    x = newTile.x,
                    y = (y - 1) * 32
                }
            end
        end

        -- reset blank y grid
        blankYGrid = 0
    end
    
    return tweens
end