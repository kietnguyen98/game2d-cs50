function checkIfColIsAChasm(colIndex, tiles, mapHeight)
    for y = 1, mapHeight do
        if tiles[colIndex][y].id ~= BLANK_INDEX then
            return false
        end
    end
    return true
end

function GenerateDefaultMapTiles(tileSheet, tileQuads, tiles, mapWidth, mapHeight)
    -- first thing, all of tiles should be fill with blank 
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

    -- generate ground for the map
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
end
