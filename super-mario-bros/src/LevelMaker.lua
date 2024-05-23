LevelMaker = class()

function LevelMaker:GenerateWorldLevel(mapWidth, mapHeight)
    local tileSheet = love.graphics.newImage('assets/blocks.png')
    local tileQuads = GenerateQuadsTile(tileSheet)
    local tiles = {}

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

    -- next loop for each column and start generate pilar / ground
    for x = 1, mapWidth do

        -- generate chasm
        -- check we should render a chasm on this column
        if math.random(7) == 1 then
            -- if yes just skip this column
            goto continue
        end

        -- generate pilar 
        local shouldGeneratePilar = math.random(5) == 1
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
        end

        -- generate ground
        local groundStartIndex = SKY_MAX_INDEX
        local groundEndIndex = mapHeight
        for y = groundStartIndex, groundEndIndex do
            local shouldGenerateGroundTopper = (not shouldGeneratePilar) and (y == groundStartIndex)
            tiles[x][y] = Tile({
                tileSheet = tileSheet,
                tileQuads = tileQuads,
                id = shouldGenerateGroundTopper and GROUND_TOPPER_INDEX or GROUND_INDEX,
                x = x,
                y = y,
                topper = shouldGenerateGroundTopper
            })
        end

        ::continue::
    end

    local tilesMap = Tiles({
        width = mapWidth,
        height = mapHeight
    })

    tilesMap.tiles = tiles

    return tilesMap
end
