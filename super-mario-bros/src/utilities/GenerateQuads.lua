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

function GenerateQuadsEnemy(atlas)
    local quads = {
        ['mushroom'] = {},
        ['turtle'] = {},
        ['cannibal'] = {}
    }

    -- mushroom enemy
    local mushroomX = 16 * 0
    local mushroomY = 16 * 6 - 4

    local MUSHROOM_QUAD_WIDTH = 16 * 1 + 2
    local MUSHROOM_QUAD_HEIGHT = 16 * 1

    local mushroomCounter = 1

    for i = 1, 6 do
        quads['mushroom'][mushroomCounter] = love.graphics.newQuad(mushroomX, mushroomY, MUSHROOM_QUAD_WIDTH,
            MUSHROOM_QUAD_HEIGHT, atlas:getDimensions())
        mushroomX = mushroomX + MUSHROOM_QUAD_WIDTH
        mushroomCounter = mushroomCounter + 1
    end

    -- turtle enemy
    local turtleX = 16 * 4 - 10
    local turtleY = 16 * 10 - 5

    local TURTLE_DEFAULT_QUAD_HEIGHT = 24
    local TURTLE_DEFAULT_QUAD_WIDTH = 18

    local TURTLE_SHRINK_QUAD_HEIGHT = 16
    local TURTLE_SHRINK_QUAD_WIDTH = 18

    local turtleCounter = 1

    for i = 1, 6 do
        quads['turtle'][turtleCounter] = love.graphics.newQuad(turtleX, i < 5 and turtleY or turtleY + 8, i < 5 and
            TURTLE_DEFAULT_QUAD_WIDTH or TURTLE_SHRINK_QUAD_WIDTH, i < 5 and TURTLE_DEFAULT_QUAD_HEIGHT or
            TURTLE_SHRINK_QUAD_HEIGHT, atlas:getDimensions())
        turtleX = turtleX + TURTLE_SHRINK_QUAD_WIDTH
        turtleCounter = turtleCounter + 1
    end

    -- cannibal enemy
    local cannibalX = 16 * 10 + 2
    local cannibalY = 16 * 3

    local CANNIBAL_QUAD_WIDTH = 18
    local CANNIBAL_QUAD_HEIGHT = 24

    local cannibalCounter = 1

    for i = 1, 2 do
        quads['cannibal'][cannibalCounter] = love.graphics.newQuad(cannibalX, cannibalY, CANNIBAL_QUAD_WIDTH,
            CANNIBAL_QUAD_HEIGHT, atlas:getDimensions())
        cannibalX = cannibalX + CANNIBAL_QUAD_WIDTH
        cannibalCounter = cannibalCounter + 1
    end

    return quads
end

function GenerateQuadsObject(atlas)
    local quads = {}
    local GAME_OBJECT_HEIGHT = 16
    local GAME_OBJECT_WIDTH = 16

    -- bush
    local bushX = 16 * 23
    local bushY = 16 * 6

    quads[BUSH_INDEX] = love.graphics.newQuad(bushX, bushY, GAME_OBJECT_WIDTH, 2 * GAME_OBJECT_HEIGHT,
        atlas:getDimensions())

    -- plump
    local plumpX = 16 * 16
    local plumpY = 16 * 6

    quads[PLUMP_INDEX] = love.graphics.newQuad(plumpX, plumpY, 2 * GAME_OBJECT_WIDTH, 2 * GAME_OBJECT_HEIGHT,
        atlas:getDimensions())

    -- top brick
    local brickX = 16 * 0
    local brickY = 16 * 0

    quads[BRICK_INDEX] = love.graphics.newQuad(brickX, brickY, GAME_OBJECT_WIDTH, GAME_OBJECT_HEIGHT,
        atlas:getDimensions())

    -- top question brick
    for k, v in pairs(BRICK_QUESTION_INDEX) do
        local x = 16 * 6
        local y = 16 * 11
        quads[v] = love.graphics.newQuad(x + k * 16, y, GAME_OBJECT_WIDTH, GAME_OBJECT_HEIGHT, atlas:getDimensions())
    end

    -- coin
    local coinX = 16 * 9
    local coinY = 16 * 11

    quads[COIN_INDEX] = love.graphics
                            .newQuad(coinX, coinY, GAME_OBJECT_WIDTH, GAME_OBJECT_HEIGHT, atlas:getDimensions())

    return quads
end
