LevelMaker = class()

function LevelMaker:GenerateWorldLevel(mapWidth, mapHeight)
    local tileSheet = love.graphics.newImage('assets/blocks.png')
    local tileQuads = GenerateQuadsTile(tileSheet)
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

    -- next loop for each column and start generate pilar / ground
    local maxChasmInARow = 0
    for x = 1, mapWidth do

        -- generate chasm
        -- check we should render a chasm on this column
        if x ~= 1 and math.random(7) == 1 and maxChasmInARow < 2 then
            -- if yes just skip this column
            maxChasmInARow = maxChasmInARow + 1
            goto continue
        end

        maxChasmInARow = 0

        -- generate ground
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

        -- generate game objects
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
            -- remove topper on ground when there is a pilar on it 
            tiles[x][SKY_MAX_INDEX].id = GROUND_INDEX
            tiles[x][SKY_MAX_INDEX].topper = false
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
