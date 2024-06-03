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
                -- has a chance to generate cannibal enemy on plump
                if math.random(3) == 1 then
                    GenerateEnemyCannibal(enemies, enemiesTileSheet, enemiesQuads['cannibal'], mainCharacter, colIndex)
                end
            elseif math.random(12) == 1 then
                -- has a chance to generate turtle enenmy on solid ground
                GenerateEnemyTurtle(enemies, enemiesTileSheet, enemiesQuads['turtle'], tilesMap, objects, mainCharacter,
                    colIndex)
            elseif math.random(10) == 1 then
                -- has a chance to generate mushroom enemy on solid ground
                GenerateEnemyMushroom(enemies, enemiesTileSheet, enemiesQuads['mushroom'], tilesMap, objects,
                    mainCharacter, colIndex)
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
