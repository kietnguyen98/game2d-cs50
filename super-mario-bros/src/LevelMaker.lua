LevelMaker = class()

function LevelMaker:GenerateWorldLevel(mapWidth, mapHeight, mainCharacter)
    local blockTileSheet = love.graphics.newImage('assets/blocks.png')
    local enemiesTileSheet = love.graphics.newImage('assets/enemies.png')
    local tileQuads = GenerateQuadsTile(blockTileSheet)
    local objectQuads = GenerateQuadsObject(blockTileSheet)
    local enemiesQuads = GenerateQuadsEnemy(enemiesTileSheet)
    local tiles = {}
    local objects = {}
    local enemies = {}

    local tilesMap = Tiles({
        width = mapWidth,
        height = mapHeight
    })

    -- generate default Map
    GenerateDefaultMapTiles(blockTileSheet, tileQuads, tiles, mapWidth, mapHeight)

    local colIndex = 1
    while colIndex <= mapWidth do
        -- generate chasms in map
        local shouldGenerateChasm = colIndex ~= 1 and colIndex ~= mapWidth and math.random(8) == 1 and
                                        (not checkIfColIsAChasm(colIndex - 1, tiles, mapHeight))
        local chasmNum = 0
        if shouldGenerateChasm then
            chasmNum = GenerateChasms(blockTileSheet, tileQuads, tiles, mapWidth, mapHeight, colIndex)
        end

        -- generate some game objects
        -- check if this col exist a chasm 
        -- if yes -> should not generate pilar / plump on this col
        local hasGeneratePlump = false
        if not checkIfColIsAChasm(colIndex, tiles, mapHeight) and colIndex ~= 1 and colIndex < mapWidth - 2 then
            if math.random(8) == 1 then
                -- generate pilar 
                GeneratePilar(blockTileSheet, tileQuads, tiles, mapWidth, mapHeight, colIndex)
            elseif math.random(10) == 1 then
                -- generate plump
                GeneratePlump(blockTileSheet, objectQuads, objects, mapWidth, mapHeight, colIndex)
                hasGeneratePlump = true
                -- generate enemies here
            elseif math.random(5) == 1 then
                local turtle
                turtle = TurtleEntity({
                    sheet = enemiesTileSheet,
                    quads = enemiesQuads,
                    x = (colIndex - 1) * TILE_WIDTH,
                    y = (SKY_MAX_INDEX - 1) * TILE_HEIGHT - TURTLE_DEFAULT_HEIGHT * TURTLE_SCALE_RATIO,
                    width = TURTLE_DEFAULT_WIDTH,
                    height = TURTLE_DEFAULT_HEIGHT,
                    scaleRatio = TURTLE_SCALE_RATIO,
                    dx = 0,
                    dy = 0,
                    direction = "left",
                    tilesMap = tilesMap,
                    objects = objects,
                    stateMachine = StateMachine({
                        ['idle'] = function()
                            return TurtleIdleState(turtle, mainCharacter)
                        end,
                        ['moving'] = function()
                            return TurtleMovingState(turtle, mainCharacter, tilesMap)
                        end,
                        ['chasing'] = function()
                            return TurtleChasingState(turtle, mainCharacter, tilesMap)
                        end,
                        ['shrink'] = function()
                            return TurtleShrinkState(turtle, mainCharacter)
                        end
                    })
                })
                turtle:changeState("idle")
                table.insert(enemies, turtle)
            end
        end

        -- generate top bricks
        local shouldGenerateTopBrick = colIndex ~= 1 and colIndex < mapWidth - 3 and math.random(10) == 1

        if shouldGenerateTopBrick then
            GenerateTopBrick(blockTileSheet, objectQuads, objects, mapWidth, mapHeight, colIndex)
        end

        if chasmNum > 0 or hasGeneratePlump then
            colIndex = colIndex + math.max(chasmNum, 2)
        else
            colIndex = colIndex + 1
        end
    end

    tilesMap.tiles = tiles

    return {
        ['tilesMap'] = tilesMap,
        ['objects'] = objects,
        ['enemies'] = enemies
    }
end
