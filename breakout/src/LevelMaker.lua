LevelMaker = class()

-- global patterns used to make the entire map a certain shape
NONE = 1
SINGLE_PYRAMID = 2
MULTI_PYRAMID = 3

-- per row patterns
SOLID = 1               -- all colors the same in this row
ALTERNATE = 2           -- alternate colors
SKIP = 3                -- skip every other block
NONE = 4                -- no blocks this row

function LevelMaker.createMap(level)
    local bricks = {}

    local numRows = math.random(1, 5)

    local numCols = math.random(7, 13)
    -- ensuring the num cols is always odd
    numCols = numCols % 2 == 0 and numCols + 1 or numCols

    for y = 1, numRows do
        for x = 1, numCols do
            newBrick = Brick(
                -- x coordinate
                (x - 1) * BRICK_WIDTH + BRICKS_MAP_GAP
                + (13 - numCols) * 16,
                (y - 1) * BRICK_HEIGHT + BRICKS_MAP_GAP + 16
            )

            table.insert(bricks, newBrick)
        end
    end

    return bricks
end