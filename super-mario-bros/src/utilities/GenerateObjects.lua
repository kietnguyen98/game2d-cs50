function GenerateChasms(tileSheet, tileQuads, tiles, mapWidth, mapHeight, colIndex)
    local chasmNum = colIndex == mapWidth - 1 and 1 or math.random(2) -- 1 or 2 or 3
    for i = 1, chasmNum do
        for y = SKY_MAX_INDEX, mapHeight do
            tiles[colIndex][y] = Tile({
                tileSheet = tileSheet,
                tileQuads = tileQuads,
                id = BLANK_INDEX,
                x = colIndex,
                y = y,
                topper = false
            })
        end

        colIndex = colIndex + 1
    end

    return chasmNum
end

function GeneratePilar(tileSheet, tileQuads, tiles, mapWidth, mapHeight, colIndex)
    local pilarStartIndex = SKY_MAX_INDEX - PILAR_HEIGHT - 1
    local pilarEndIndex = SKY_MAX_INDEX - 1
    for y = pilarStartIndex, pilarEndIndex do
        tiles[colIndex][y] = Tile({
            tileSheet = tileSheet,
            tileQuads = tileQuads,
            id = y == pilarStartIndex and GROUND_TOPPER_INDEX or GROUND_INDEX,
            x = colIndex,
            y = y,
            topper = y == pilarStartIndex
        })
    end
    -- remove topper on ground when there is a pilar on it
    if tiles[colIndex][SKY_MAX_INDEX].id == GROUND_TOPPER_INDEX then
        tiles[colIndex][SKY_MAX_INDEX].id = GROUND_INDEX
        tiles[colIndex][SKY_MAX_INDEX].topper = false
    end
end

function GeneratePlump(tileSheet, objectQuads, objects, mapWidth, mapHeight, colIndex)
    table.insert(objects, Object({
        objectSheet = tileSheet,
        objectQuads = objectQuads,
        id = PLUMP_INDEX,
        width = 2 * GAME_OBJECT_WIDTH,
        height = 2 * GAME_OBJECT_HEIGHT,
        x = (colIndex - 1) * TILE_WIDTH,
        y = (SKY_MAX_INDEX - 1) * TILE_HEIGHT - 2 * GAME_OBJECT_HEIGHT,
        collidable = false,
        consumable = false,
        solid = true
    }))
end

-- for question brick with coin
function GenerateQuestionBrickCoin(tileSheet, objectQuads, objects, topBrickX, topBrickY, mainCharacter)
    table.insert(objects, Object({
        objectSheet = tileSheet,
        objectQuads = objectQuads,
        id = COIN_INDEX,
        x = topBrickX,
        -- minus 2 so the coin will have a space to the question brick
        y = topBrickY - GAME_OBJECT_HEIGHT - 2,
        width = GAME_OBJECT_WIDTH,
        height = GAME_OBJECT_HEIGHT,
        collidable = false,
        consumable = true,
        solid = false,
        onConsume = function()
            mainCharacter.score = mainCharacter.score + 100
        end
    }))
end

function GenerateTopBrick(tileSheet, objectQuads, objects, mapWidth, mapHeight, colIndex, mainCharacter)
    local TopBrickLength = math.random(2, 3)
    for j = 1, TopBrickLength do
        local shouldGenerateQuestionBrick = math.random(3) == 1
        local topBrickX = ((colIndex - 1) + (j - 1)) * GAME_OBJECT_WIDTH
        local topBrickY = (TOP_BRICK_Y_POSITION - 1) * GAME_OBJECT_HEIGHT - TILE_HEIGHT / 2
        table.insert(objects, Object({
            objectSheet = tileSheet,
            objectQuads = objectQuads,
            id = shouldGenerateQuestionBrick and BRICK_QUESTION_INDEX[0] or BRICK_INDEX,
            x = topBrickX,
            -- should minus 2 to keep the distance from top brick and pilar >= main player height
            -- then the player can always go pass the top brick and pilar if they spawn at the same row
            y = topBrickY,
            width = GAME_OBJECT_WIDTH,
            height = GAME_OBJECT_HEIGHT,
            collidable = shouldGenerateQuestionBrick,
            consumable = false,
            solid = true,
            hitTimes = 0,
            onCollide = shouldGenerateQuestionBrick and function(self)
                if self.hitTimes < 2 then
                    self.hitTimes = self.hitTimes + 1
                    self.id = BRICK_QUESTION_INDEX[self.hitTimes]

                    if self.hitTimes == 2 then
                        -- should spawn coin if player hit question brick 2 times 
                        local shouldGenerateCoin = math.random(2) == 1
                        if shouldGenerateCoin then
                            GenerateQuestionBrickCoin(tileSheet, objectQuads, objects, topBrickX, topBrickY,
                                mainCharacter)
                        end
                    end
                end
            end
        }))
    end
end
