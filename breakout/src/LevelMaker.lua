LevelMaker = class()

function LevelMaker.createMap(level)
    local bricks = {}

    local numRows = math.random(1, 5)
    local numCols = math.random(7, 13)

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