StartState = BaseState:extend()

function StartState:init()
    -- currently select game optionn
    self.currentSelectedOption = 1

    -- color sheet use to change text color 
    self.colorSheet = {
        [1] = love.math.colorFromBytes(217, 87, 99, 1),
        [2] = love.math.colorFromBytes(95, 205, 228, 1),
        [3] = love.math.colorFromBytes(251, 242, 54, 1),
        [4] = love.math.colorFromBytes(118, 66, 138, 1),
        [5] = love.math.colorFromBytes(153, 229, 80, 1),
        [6] = love.math.colorFromBytes(223, 113, 38, 1),
    }

    -- letter of "Match 3" text and their spacice relative to the center
    self.letterSheet = {
        [1] = {letter = 'M', spacing = -108},
        [2] = {letter = 'A', spacing = -64},
        [3] = {letter = 'T', spacing = -28},
        [4] = {letter = 'C', spacing = 2},
        [5] = {letter = 'H', spacing = 40},
        [6] = {letter = '3', spacing = 112},
    }

    -- time for a color change if it's been half a second
    -- a letter color will be change from color 1 to color 6 in 0.5s
    -- => in 0.5 / 6 = 0.075
    self.colorTimer = Timer.every(0.075, function() 
        -- shift the color from index 6 -> 1
        self.colorSheet[1] = self.colorSheet[6]

        for i = 1, 5 do
            -- shift the color from index 1 -> 2, 2 -> 3,.. 5 -> 6
            self.colorSheet[i + 1] = self.colorSheet[i]    
        end 
    end)

    -- generate full table of tile to display
    self.tileQuadsTable = {}
    
    -- total 64 tiles in a 8x8 table
    -- pick random tile in the tile quads sheet to create a 8x8 tile quads table with random quad values
    for i = 1, 64 do
        table.insert(self.tileQuadsTable, gameQuads['tiles'][math.random(18)][math.random(6)])
    end

    -- init transition alpha for animation
    self.transitionAlpha = 0

    -- if the state is in trasition effect, then input / select options will be disabled
    self.isTransition = false
end

function StartState:enter(params)
end

function StartState:update(deltaTime)

    -- handle player input event

    -- change menu option
    if love.keyboard.wasPressed('up') or love.keyboard.wasPressed('down') then
        self.currentSelectedOption = self.currentSelectedOption == 1 and 2 or 1
    end

    -- choose one optionn
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('escape') then
        -- change game state to begin game

        -- change game state to high score state
    end
end

function StartState:render()
    -- render all tiles and there drop shadows
    for y = 1, 8 do
        for x = 1, 8 do
            -- render the shadow first
            love.graphics.setColor(0, 0, 0, 1)
            love.graphics.draw(gameTextures['tiles'], self.tileQuadsTable[(y - 1) * x + x],
            -- position x
            (x - 1) * TILE_WIDTH + 128 + 3, -- 128 = tiles board start x offset, 3 = shift 3px to make the effect
            -- position y
            (y - 1) * TILE_HEIGHT + 16 + 3 -- 16 = tiles board start y offset, 3 = shift 3px to make the effect
        )

            -- next, render all the tiles
            love.graphics.setColor(1, 1, 1, 1) -- reset the color
            love.graphics.draw(gameTextures['tiles'], self.tileQuadsTable[(y - 1) * x + x],
             -- position x
             (x - 1) * TILE_WIDTH + 128 + 3, -- 128 = tiles board start x offset, 3 = shift 3px to make the effect
             -- position y
             (y - 1) * TILE_HEIGHT + 16 + 3 -- 16 = tiles board start y offset, 3 = shift 3px to make the effect
        )
        end
    end
end