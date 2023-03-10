function GenerateQuads(atlas, tileWidth, tileHeight)
    local sheetWidth = atlas:getWidth() / tileWidth
    local sheetHeight = atlas:getHeight() / tileHeight

    local sheetCounter = 1
    local spritesheet = {}

    for y = 0, sheetHeight - 1 do
        for x = 0, sheetWidth - 1 do
            spritesheet[sheetCounter] = love.graphics.newQuad(x * tileWidth, y * tileHeight, tileWidth, tileHeight, atlas:getDimensions())
            sheetCounter = sheetCounter + 1
        end
    end

    return spritesheet
end

function table.slice(tbl, first, last, step)
    local sliced = {}

    for i = first or 1, last or #tbl, step or 1 do
        sliced[#sliced + 1] = tbl[i]
    end

    return sliced
end

function GenerateQuadsPaddles(atlas)
    local x = 0
    local y = 64 -- these paddles sprites start at y = 64

    local counter = 1
    local quads = {}

    for i = 0, 3 do
        -- smallest
        quads[counter] = love.graphics.newQuad(x, y, 32, 16, atlas:getDimensions())
        counter = counter + 1
        -- medium
        quads[counter] = love.graphics.newQuad(x + 32, y, 64, 16, atlas:getDimensions())
        counter = counter + 1
        -- large
        quads[counter] = love.graphics.newQuad(x + 96, y, 96, 16, atlas:getDimensions())
        counter = counter + 1
        -- huge
        quads[counter] = love.graphics.newQuad(x, y + 16, 128, 16, atlas:getDimensions())
        counter = counter + 1
        
        -- prepare x and y for the next paddle
        x = 0
        y = y + 32
    end

    return quads
end

function GenerateQuadsBall(atlas)
    -- ball quads start at line 1 (x = 96, y = 48), 4 balls
    local x = 96
    local y = 48

    local counter = 1
    local quads = {}

    for i = 0, 3 do
        quads[counter] = love.graphics.newQuad(x, y, 8, 8, atlas:getDimensions())
        counter = counter + 1
        x = x + 8
    end

    -- ball quads start at line 2 (x = 96, y = 56), 3 balls
    
    x = 96
    y = 56

    for i = 0, 2 do
        quads[counter] = love.graphics.newQuad(x, y, 8, 8, atlas:getDimensions())
        counter = counter + 1
        x = x + 8
    end
    
    return quads
end

function GenerateQuadsBricks(atlas)
    return table.slice(GenerateQuads(atlas, 32, 16), 1, 21)
end

function GenerateQuadsHearts(atlas)
    local x = 0
    local y = 0

    local counter = 1
    local quads = {}

    for i = 0, 1 do
        quads[counter] = love.graphics.newQuad(x, y, 10, 9, atlas:getDimensions())
        x = x + 10
        counter = counter + 1
    end

    return quads
end

function GenerateQuadsArrows(atlas)
    local x = 0
    local y = 0

    local counter = 1
    local quads = {}

    for i = 0, 1 do
        quads[counter] = love.graphics.newQuad(x, y, 24, 24, atlas:getDimensions())
        x = x + 24
        counter = counter + 1
    end
    
    return quads
end