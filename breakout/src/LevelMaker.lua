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

    -- local numRows = math.random(1, 5)
    local numRows = level

    local numCols = math.random(math.min(5, level * 2), math.min(11, level * 3))

    -- ensuring the num cols is always odd
    numCols = numCols % 2 == 0 and numCols + 1 or numCols

    -- highest possible spawned brick color in this level
    -- ensure we dont go above 3
    local highestTier = math.min(math.min(4, level), math.floor(level / 5))

    -- highest color of the highest tier
    local highestColor = math.min(math.min(5, level), level % 5 + 3)

    -- iterating on each row
    for y = 1, numRows do
        
        --[[
            for generating bricks, we will mix 2 types of generation mode: skip and alternate color 
            1. skipping brick will cause bricks like: [brick]-blank-[brick]-blank-[brick]
            2. alternate brick will cause bricks like: [brick color 1]-[brick-color-2]-[brick-color-1]-[brick-color-2]
            
            => mixing these 2 types of generation mode, we will have 4 cases:
            1. skipping and alternate
            2. skipping and non-alternate (only 1 solid color)
            3. non-skipping and alternate
            4. non-skipping and non-alternate
        ]]--
        
        -- wether we want to enable skipping for this row, pick a random value
        local skipPattern = math.random(1, 2) == 1 and true or false

        -- wether we want to anable alternating colors for this row, pick a random value
        local alternatePattern = math.random(1, 2) == 1 and true or false

        -- chose two colors to alternate between
        local alternateColor1 = math.random(1, highestColor)
        local alternateColor2 = math.random(1, highestColor)
        local alternateTier1 = math.random(1, highestTier)
        local alternateTier2 = math.random(1, highestTier)

        -- used only when we want to skip a block, use for skip pattern true only
        local skipFlag = math.random(1, 2) == 1 and true or false

        -- used only when we want to alternate a block, use for alternate pattern true only
        local alternateFlag = math.random(1, 2) == 1 and true or false

        -- pick 1 solid color we will use if we are not alternating
        local solidColor = math.random(1, highestColor)
        local solidTier = math.random(1, highestTier)

        -- iterating on each colummn in row 
        for x = 1, numCols do
            -- if skipping is turned on and we are on a skip iteration...
            if skipPattern and skipFlag then
                -- turn skipping off for ther next iteration
                skipFlag = not skipFlag

                -- lua doesnt have a continue statement, so this is the workaround
                -- skip generate brick at this colummn
                goto continue
            else
                -- flip the flag to true on an iteration we dont use it
                skipFlag = not skipFlag
            end

            -- generate new brick at this col
            newBrick = Brick(
                -- x coordinate
                (x - 1) * (BRICK_WIDTH + BRICKS_MAP_GAP)
                + (13 - numCols) * 16,
                -- y coordinate
                (y - 1) * (BRICK_HEIGHT + BRICKS_MAP_GAP) + 24 -- plus 16 for paddling the bricks 16px to the top
            )

            -- if we are alternating, figure out which color and tier we are on
            if alternatePattern and alternateFlag then
                -- if alternate flag = true then the new brick color will be alternate color 1
                newBrick.color = alternateColor1
                newBrick.tier = alternateTier1
                -- toogle alternate flag
                alternateFlag = not alternateFlag
            else
                -- if alternate flag = false then the new brick color will be alternate color 2
                newBrick.color = alternateColor2
                newBrick.tier = alternateTier2
                -- toggle alternate flag
                alternateFlag = not alternateFlag
            end

            -- if not alternating and we made it here, use the solid color and tier
            if not alternatePattern then
                newBrick.color = solidColor
                newBrick.tier = solidTier
            end

            table.insert(bricks, newBrick)
        
            -- lua's version of the 'continue' statement
            ::continue::
        end
    end

    -- in the event we didn't generate any brick, try again
    if #bricks == 0 then
        return self.createMap(level)
    else
        return bricks
    end
end