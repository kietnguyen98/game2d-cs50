function GenerateTileQuads(atlas) 
    local x = 0
    local y = 0

    local counter = 1

    local quads = {}

    -- there are 9 rows, which each row consist of 2 line of different tile
    -- looping on each row
    for row = 1, 9 do
        -- we will looping twice on each row for 2 lines
        for line = 1, 2 do
            -- looping 6 time for each line (6 is a number in a set of tile)
            
            quads[counter] = {}
            
            for i = 1, 6 do
                -- create the quad
                local newQuad = love.graphics.newQuad(x, y, TILE_WIDTH, TILE_HEIGHT, atlas:getDimensions())
                table.insert(quads[counter], newQuad)
                -- increase x dimension to the next tile
                x = x + 32
            end

            -- increase counter for the next set of tile
            counter = counter + 1
        end

        -- increase y dimension for the next row
        y = y + 32
        -- reset x dimesion for the next row
        x = 0
    end

    return quads
end