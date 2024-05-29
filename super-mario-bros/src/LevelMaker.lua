LevelMaker = class()

local MAX_CHASM_IN_A_ROW = 1
local MAX_TOP_BRICK_IN_A_ROW = 3

function LevelMaker:GenerateWorldLevel(mapWidth, mapHeight)
    local tileSheet = love.graphics.newImage('assets/blocks.png')
    local tileQuads = GenerateQuadsTile(tileSheet)
    local gameObjectQuads = GenerateQuadsGameObject(tileSheet)
    local tiles = {}
    local objects = {}

    -- first all of tiles should be fill with blank 
    for x = 1, mapWidth do
        table.insert(tiles, {})
        for y = 1, mapHeight do
            table.insert(tiles[x], Tile({
                tileSheet = tileSheet,
                tileQuads = tileQuads,
                id = BLANK_INDEX,
                x = x,
                y = y,
                topper = false
            }))
        end
    end

    -- generate ground

    for x = 1, mapWidth do
        local groundStartIndex = SKY_MAX_INDEX
        local groundEndIndex = mapHeight
        for y = groundStartIndex, groundEndIndex do
            tiles[x][y] = Tile({
                tileSheet = tileSheet,
                tileQuads = tileQuads,
                id = y == groundStartIndex and GROUND_TOPPER_INDEX or GROUND_INDEX,
                x = x,
                y = y,
                topper = y == groundStartIndex
            })
        end
    end

    -- next loop for each column and start generate pilar / ground
    local numChasmInARow = 0

    local x = 1
    while x <= mapWidth do

        -- generate chasm
        -- check we should render a chasm on this column
        -- should not make a chasm when on the first row and last row
        local shouldGenerateChasm = x ~= 1 and x ~= mapWidth and math.random(8) == 1
        if shouldGenerateChasm then
            local chasmStartIndex = SKY_MAX_INDEX
            local chasmEndIndex = mapHeight
            for y = chasmStartIndex, chasmEndIndex do
                tiles[x][y] = Tile({
                    tileSheet = tileSheet,
                    tileQuads = tileQuads,
                    id = BLANK_INDEX,
                    x = x,
                    y = y,
                    topper = false
                })
            end

            x = x + 1
            goto continue
        end

        -- generate game objects
        -- generate pilar 
        local shouldGeneratePilar = math.random(6) == 1
        if shouldGeneratePilar then
            local pilarStartIndex = SKY_MAX_INDEX - PILAR_HEIGHT - 1
            local pilarEndIndex = SKY_MAX_INDEX - 1
            for y = pilarStartIndex, pilarEndIndex do
                tiles[x][y] = Tile({
                    tileSheet = tileSheet,
                    tileQuads = tileQuads,
                    id = y == pilarStartIndex and GROUND_TOPPER_INDEX or GROUND_INDEX,
                    x = x,
                    y = y,
                    topper = y == pilarStartIndex
                })
            end
            -- remove topper on ground when there is a pilar on it 
            tiles[x][SKY_MAX_INDEX].id = GROUND_INDEX
            tiles[x][SKY_MAX_INDEX].topper = false
        elseif math.random(12) == 1 then
            -- generate bush
            table.insert(objects, GameObject({
                objectSheet = tileSheet,
                objectQuads = gameObjectQuads,
                id = BUSH_INDEX,
                width = GAME_OBJECT_WIDTH,
                height = 2 * GAME_OBJECT_HEIGHT,
                x = (x - 1) * TILE_WIDTH,
                y = (SKY_MAX_INDEX - 1) * TILE_HEIGHT - 2 * GAME_OBJECT_HEIGHT,
                collidable = false,
                consumable = false,
                solid = true
            }))
        elseif math.random(15) == 1 then
            -- generate plump
            table.insert(objects, GameObject({
                objectSheet = tileSheet,
                objectQuads = gameObjectQuads,
                id = PLUMP_INDEX,
                width = 2 * GAME_OBJECT_WIDTH,
                height = 2 * GAME_OBJECT_HEIGHT,
                x = (x - 1) * TILE_WIDTH,
                y = (SKY_MAX_INDEX - 1) * TILE_HEIGHT - 2 * GAME_OBJECT_HEIGHT,
                collidable = false,
                consumable = false,
                solid = true
            }))

            x = x + 2
            goto continue
        end

        -- generate top bricks
        local shouldGenerateTopBrick = x ~= 1 and math.random(10) == 1

        if shouldGenerateTopBrick then
            for j = x, MAX_TOP_BRICK_IN_A_ROW do
                local shouldGenerateQuestionBrick = math.random(2) == 1
                local topBrickX = (j - 1) * TILE_WIDTH
                local topBrickY = (TOP_BRICK_Y_POSITION - 1) * TILE_HEIGHT - 4
                table.insert(objects, GameObject({
                    objectSheet = tileSheet,
                    objectQuads = gameObjectQuads,
                    id = shouldGenerateQuestionBrick and BRICK_QUESTION_INDEX[0] or BRICK_INDEX,
                    x = topBrickX,
                    -- should minus 2 to keep the distance from top brick and pilar >= main player height
                    -- then the player can always go pass the top brick and pilar if they spawn at the same row
                    y = topBrickY,
                    collidable = shouldGenerateQuestionBrick,
                    consumable = false,
                    solid = true,
                    hitTimes = 0,
                    onCollide = not shouldGenerateQuestionBrick and nil or function(self)
                        if self.hitTimes < 2 then
                            self.hitTimes = self.hitTimes + 1
                            self.id = BRICK_QUESTION_INDEX[self.hitTimes]

                            if self.hitTimes == 2 then
                                -- should spawn coin if player hit question brick 2 times 
                                local shouldGenerateCoin = math.random(2) == 1
                                if shouldGenerateCoin then
                                    table.insert(objects, GameObject({
                                        objectSheet = tileSheet,
                                        objectQuads = gameObjectQuads,
                                        id = COIN_INDEX,
                                        x = topBrickX,
                                        -- minus 2 so the coin will have a space to the question brick
                                        y = topBrickY - GAME_OBJECT_HEIGHT - 2,
                                        collidable = false,
                                        consumable = true,
                                        solid = false
                                    }))
                                end
                            end
                        end
                    end
                }))
                j = j + 1
            end
        end

        x = x + 1
        ::continue::
    end

    local tilesMap = Tiles({
        width = mapWidth,
        height = mapHeight
    })

    tilesMap.tiles = tiles

    return {
        ['tilesMap'] = tilesMap,
        ['objects'] = objects
    }
end
