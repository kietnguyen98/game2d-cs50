EnterHighScoreState = BaseState:extend()

function EnterHighScoreState:init()
    -- individual chars of our string
    self.chars = {
        -- in ascii table 65 = "A"
        -- our name will contain the maximum of 3 characters
        [1] = 65,
        [2] = 65,
        [3] = 65
    }

    -- char which we are currently changing, start with the first char
    self.hightlightedChar = 1
end

function EnterHighScoreState:enter(params)
    self.highScores = params.highScores
    self.score = params.score 
    self.scoreIndex = params.scoreIndex
end

function EnterHighScoreState:update(deltaTime)
    -- player press down/up so update current char
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

    -- player press left/right so change the current hightlighted character
    if love.keyboard.wasPressed('left') then
        if self.hightlightedChar == 1 then
            self.hightlightedChar = 3
        else
            self.hightlightedChar = self.hightlightedChar - 1
        end
    elseif love.keyboard.wasPressed('right') then
        if self.hightlightedChar == 3 then
            self.hightlightedChar = 1
        else
            self.hightlightedChar = self.hightlightedChar + 1
        end
    end

    -- player submit new hight score
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        -- create new player name string
        local name = string.char(self.chars[1])..string.char(self.chars[2])..string.char(self.chars[3])

        -- go backwards through high scores table till 
        for i = 10, self.scoreIndex - 1 do
            -- shift those hight score players down
            self.highScores[i + 1] = {
                name = self.highScores[i]['name'],
                score = self.highScores[i]['score']
            }
        end

        -- update new hightscore at the index position
        self.highScores[self.scoreIndex]['name'] = name
        self.highScores[self.scoreIndex]['score'] = self.score

        -- write the new hight score table to the file
        local scoresStr = ''

        -- convert all data in hight score table to string
        for i = 1, 10 do
            scoresStr = scoresStr..self.highScores[i]['name']..'\n'
            scoresStr = scoresStr..tostring(self.highScores[i]['name'])..'\n'
        end

        -- write hight score string to file
        love.filesystem.write('breakout.lst', scoresStr)

        -- change the game state to hight score state to showcase the new hight score table
        gameStateMachine:change('high-score', {
            highScoresBoard = self.highScores
        })
    end
end

function EnterHighScoreState:render()
    -- render guide text
    love.graphics.setFont(gameFonts['medium'])
    love.graphics.printf("your scores is: "..tostring(self.score), 0, 20, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gameFonts['small'])
    love.graphics.printf("congratulations ! your score is a new high score", 0, VIRTUAL_HEIGHT / 4, VIRTUAL_WIDTH - 40, 'center')
    love.graphics.printf("please enter your name to save the score", 0, VIRTUAL_HEIGHT / 4 + 40, VIRTUAL_WIDTH - 40, 'center')

    -- render all three character name
    love.graphics.setFont(gameFonts['large'])
    for i = 1, 3 do
        if self.hightlightedChar == i then
            -- set the color to light blue
            love.graphics.setColor(love.math.colorFromBytes(103, 255, 255, 255))
        else
           -- reset the color to white
            love.graphics.setColor(1, 1, 1, 1) 
        end
        love.graphics.print(string.char(self.chars[i]), VIRTUAL_WIDTH / 2 - 50 + 25 * i, VIRTUAL_HEIGHT / 2 + 40)
    end    
end