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

function drawTextShadow(text, y)
    love.graphics.setColor(love.math.colorFromBytes(34, 32, 52, 255))
    love.graphics.printf(text, 2, y + 1, VIRTUAL_WIDTH, 'center')
    love.graphics.printf(text, 1, y + 1, VIRTUAL_WIDTH, 'center')
    love.graphics.printf(text, 0, y + 1, VIRTUAL_WIDTH, 'center')
    love.graphics.printf(text, 1, y + 2, VIRTUAL_WIDTH, 'center')
end

function getLevelScoreGap(level)
    if level == 0 then
        return  0
    else
        return 2 * getLevelScoreGap(level - 1) + 1
    end
end

function timerDisplay(timer) 
    local minutes = math.floor(timer / 60)
    local seconds = timer - minutes * 60
    return (minutes < 10 and "0"..tostring(minutes) or tostring(minutes))..":"..(seconds < 10 and "0"..tostring(seconds) or tostring(seconds))
end

function loadHighScores()
    love.filesystem.setIdentity('match-three')

    if not love.filesystem.getInfo('match-three.lst') then
        local scores = ''
        for i = 10, 1, -1 do
            scores = scores..'Unkn\n'
            scores = scores..'10'..'\n'
        end

        love.filesystem.write('match-three.lst', scores)
    end

    -- reading data
    local isReadingName = true
    local currentName = nil
    local counter = 1

    local scores = {}
    
    for i = 1, 10 do
        table.insert(scores, {
            name = nil,
            score = nil
        })
    end

    for line in love.filesystem.lines('match-three.lst') do
        if isReadingName then
            scores[counter]['name'] = string.sub(line, 1, 4)
            isReadingName = false
        else
            scores[counter]['scores'] = tonumber(line)
            counter = counter + 1
            isReadingName = true
        end
    end

    return scores
end