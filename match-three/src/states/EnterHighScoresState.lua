EnterHighScoresState = BaseState:extend()

function EnterHighScoresState:init()
    self.chars = {
        [1] = 65,
        [2] = 65,
        [3] = 65,
        [4] = 65,
    }

    self.hightlightedChar = 1
end

function EnterHighScoresState:enter(params)
    self.highScoresBoard = params.highScoresBoard
    self.score = params.score 
    self.scoreIndex = params.scoreIndex
end
function EnterHighScoresState:update(deltaTime)
    if love.keyboard.wasPressed('down') then
        if self.chars[self.hightlightedChar] == 65 then
            self.chars[self.hightlightedChar] = 90
        else
            self.chars[self.hightlightedChar] = self.chars[self.hightlightedChar] - 1
        end
    elseif love.keyboard.wasPressed('up') then
        if self.chars[self.hightlightedChar] == 90 then
            self.chars[self.hightlightedChar] = 65
        else
            self.chars[self.hightlightedChar] = self.chars[self.hightlightedChar] + 1
        end
    end

    if love.keyboard.wasPressed('left') then
        if self.hightlightedChar == 1 then
            self.hightlightedChar = 4
        else
            self.hightlightedChar = self.hightlightedChar - 1
        end
    elseif love.keyboard.wasPressed('right') then
        if self.hightlightedChar == 4 then
            self.hightlightedChar = 1
        else
            self.hightlightedChar = self.hightlightedChar + 1
        end
    end

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        -- create new player name string
        local name = string.char(self.chars[1])..string.char(self.chars[2])..string.char(self.chars[3])..string.char(self.chars[4])

        -- go backwards through high scores table till 
        for i = 10, self.scoreIndex + 1, -1 do
            -- shift those hight score players down
            self.highScoresBoard[i] = {
                name = self.highScoresBoard[i - 1]['name'],
                scores = self.highScoresBoard[i - 1]['scores']
            }
        end

        -- update new hightscore at the index position
        self.highScoresBoard[self.scoreIndex]['name'] = name
        self.highScoresBoard[self.scoreIndex]['scores'] = self.score

        -- write the new high score table to the file
        local scoresStr = ''

        -- convert all data in hight score table to string
        for i = 1, 10 do
            scoresStr = scoresStr..self.highScoresBoard[i]['name']..'\n'
            scoresStr = scoresStr..tostring(self.highScoresBoard[i]['scores'])..'\n'
        end

        -- write hight score string to file
        love.filesystem.write('match-three.lst', scoresStr)

        -- change the game state to hight score state to showcase the new hight score table
        gameStateMachine:change('high-scores', {
            highScoresBoard = self.highScoresBoard
        })
    end
end

function EnterHighScoresState:render()
    -- render guide text
    love.graphics.setFont(gameFonts['large'])
    drawTextShadow("your scores is: "..tostring(self.score), 40)
    love.graphics.setColor(TextOptionColor.HIGHT_LIGHT)
    love.graphics.printf("your scores is: "..tostring(self.score), 0, 40, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gameFonts['medium'])
    drawTextShadow("congratulations ! your score is a new high score", VIRTUAL_HEIGHT / 4 + 20)
    drawTextShadow("please enter your name to save the score", VIRTUAL_HEIGHT / 4 + 60)
    love.graphics.setColor(TextOptionColor.NORMAL)
    love.graphics.printf("congratulations ! your score is a new high score", 0, VIRTUAL_HEIGHT / 4 + 20, VIRTUAL_WIDTH , 'center')
    love.graphics.printf("please enter your name to save the score", 0, VIRTUAL_HEIGHT / 4 + 60, VIRTUAL_WIDTH , 'center')

    -- render all three character name
    -- characters background overlay
    love.graphics.setColor(OverlayColor.BLACK_BLUR)
    love.graphics.rectangle('fill', VIRTUAL_WIDTH / 2 - 60, VIRTUAL_HEIGHT / 2 + 50, 130, 50, 8)
    -- characters
    love.graphics.setFont(gameFonts['large'])
    for i = 1, 4 do
        if self.hightlightedChar == i then
            -- set the color to light blue
            love.graphics.setColor(love.math.colorFromBytes(103, 255, 255, 255))
        else
           -- reset the color to white
            love.graphics.setColor(1, 1, 1, 1) 
        end
        love.graphics.print(string.char(self.chars[i]), VIRTUAL_WIDTH / 2 - 80 + 30 * i, VIRTUAL_HEIGHT / 2 + 60)
    end    
end