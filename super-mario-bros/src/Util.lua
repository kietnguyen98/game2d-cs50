function GenerateQuads(atlas, tileWidth, tileHeight)
    local sheetWidth = atlas:getWidth() / tileWidth
    local sheetHeight = atlas:getHeight() / tileHeight

    local sheetCounter = 1
    local spritesheet = {}

    for y = 0, sheetHeight - 1 do
        for x = 0, sheetWidth - 1 do
            spritesheet[sheetCounter] = love.graphics.newQuad(x * tileWidth, y * tileHeight, tileWidth, tileHeight,
                atlas:getDimensions())
            sheetCounter = sheetCounter + 1
        end
    end

    return spritesheet
end

function GenerateQuadsTile(atlas)
    local quads = {}

    -- blank
    local skyX = 16 * 2
    local skyY = 16 * 12
    quads[BLANK_INDEX] = love.graphics.newQuad(skyX, skyY, TILE_WIDTH, TILE_HEIGHT, atlas:getDimensions())

    -- ground
    local groundX = 16 * 1
    local groundY = 16 * 0
    quads[GROUND_INDEX] = love.graphics.newQuad(groundX, groundY, TILE_WIDTH, TILE_HEIGHT, atlas:getDimensions())

    -- ground topper
    local groundTopperX = 16 * 0
    local groundTopperY = 16 * 1
    quads[GROUND_TOPPER_INDEX] = love.graphics.newQuad(groundTopperX, groundTopperY, TILE_WIDTH, TILE_HEIGHT,
        atlas:getDimensions())

    -- brick
    local brickX = 16 * 1
    local brickY = 16 * 0
    quads[BRICK_INDEX] = love.graphics.newQuad(brickX, brickY, TILE_WIDTH, TILE_HEIGHT, atlas:getDimensions())

    return quads
end

function GenerateQuadsCharacter(atlas)
    local x = 0
    local y = 72

    local CHARACTER_HEIGHT = 18
    local CHARACTER_WIDTH = 18

    local counter = 1
    local quads = {}

    for i = 0, 13 do
        quads[counter] = love.graphics.newQuad(x, y, CHARACTER_WIDTH, CHARACTER_HEIGHT, atlas:getDimensions())
        x = x + CHARACTER_WIDTH
        counter = counter + 1
    end

    return quads
end
