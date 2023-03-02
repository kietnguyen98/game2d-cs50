StartState = BaseState:extend()

function StartState:init()
    -- currently select game optionn
    self.currentSelectedOption = 1

    -- color sheet use to change text color 
    self.colorSheet = {
        [1] = {217/255, 87/255, 99/255, 1},
        [2] = {95/255, 205/255, 228/255, 1},
        [3] = {251/255, 242/255, 54/255, 1},
        [4] = {118/255, 66/255, 138/255, 1},
        [5] = {153/255, 229/255, 80/255, 1},
        [6] = {223/255, 113/255, 38/255, 1},
    }

    -- letter of "Match 3" text and their spacice relative to the center
    self.letterSheet = {
        [1] = {letter = 'M', spacing = -100},
        [2] = {letter = 'A', spacing = -52},
        [3] = {letter = 'T', spacing = -14},
        [4] = {letter = 'C', spacing = 22},
        [5] = {letter = 'H', spacing = 60},
        [6] = {letter = '3', spacing = 120},
    }

    -- time for a color change if it's been half a second
    -- a letter color will be change from color 1 to color 6 in 0.5s
    -- => in 0.5 / 6
    self.colorTimer = Timer.every(0.5 / 6, function() 
        -- shift the color from index 6 -> 1
        self.colorSheet[0] = self.colorSheet[6]

        for i = 6, 1, -1 do
            -- shift the color from index 1 -> 2, 2 -> 3,.. 5 -> 6
            self.colorSheet[i] = self.colorSheet[i - 1]    
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
        gameSounds['change_option']:play()
    end

    -- choose one optionn
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gameSounds['select_option']:play()
        if self.currentSelectedOption == 1 then
            -- change game state to begin game
            -- using tween function from Timer, make trasition change opacity from 0 to 1,
            -- after trasition finish, change state to begin game state
            Timer.tween(1, {
                [self] = { transitionAlpha = 1}
            }):finish(function() 
                gameStateMachine:change('begin',{
                    level = 1
                })
            end)

            -- remove  color Timer
            -- timer is an global object, but in the next state we dont need to tween the color any more
            -- so remove this timer reduce posibility of bug
            self.colorTimer:remove()
        end
        
        -- change game state to high score state
    end

    -- update Timer
    Timer.update(deltaTime)
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

    -- put an overlay on the background and title
    -- make it darker than normal
    love.graphics.setColor(0, 0, 0, 64 / 255)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)

    self:drawTitleText(-64)
    self:drawGameOptions(32)
    
    -- make an overlay over all the this game state ui for game state transition effect
    love.graphics.setColor(1, 1, 1, self.transitionAlpha)
    love.graphics.rectangle('fill', 0 , 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
end

function StartState:drawTitleText(y)
    -- draw a white overlay below the text
    love.graphics.setColor(1, 1, 1, 128/255)
    love.graphics.rectangle('fill', VIRTUAL_WIDTH / 2 - 80, VIRTUAL_HEIGHT / 2 + y - 6, 160, 43, 6) 

    -- draw text shadows
    love.graphics.setFont(gameFonts['large'])
    drawTextShadow('MATCH 3', VIRTUAL_HEIGHT / 2 + y)

    -- render match 3 letters in their corresponding color 
    for i = 1, 6 do
        love.graphics.setColor(self.colorSheet[i])
        love.graphics.printf(self.letterSheet[i]['letter'], 0, VIRTUAL_HEIGHT / 2 + y, VIRTUAL_WIDTH + self.letterSheet[i]['spacing'], 'center')
    end
end

function StartState:drawGameOptions(y)
    -- draw a white overlay belowt the text
    love.graphics.setColor(1, 1, 1, 128/255)
    love.graphics.rectangle('fill', VIRTUAL_WIDTH / 2 - 80, VIRTUAL_HEIGHT / 2 + y - 6, 160, 70, 6) 

    --
    -- render option texts
    --
    love.graphics.setFont(gameFonts['medium'])
    -- render start game text
    drawTextShadow('Start Game', VIRTUAL_HEIGHT / 2 + 40)
    if self.currentSelectedOption == 1 then
        love.graphics.setColor(TextOptionColor.HIGHT_LIGHT)    
    else
        love.graphics.setColor(TextOptionColor.NORMAL)
    end
    love.graphics.printf('Start Game', 0, VIRTUAL_HEIGHT / 2 + 40, VIRTUAL_WIDTH, 'center')

    -- render high score game text
    drawTextShadow('High Score', VIRTUAL_HEIGHT / 2 + 70)
    if self.currentSelectedOption == 2 then
        love.graphics.setColor(TextOptionColor.HIGHT_LIGHT)    
    else
        love.graphics.setColor(TextOptionColor.NORMAL)
    end
    love.graphics.printf('High Score', 0, VIRTUAL_HEIGHT / 2 + 70, VIRTUAL_WIDTH, 'center')
end