HighScoreState = BaseState:extend()

function HighScoreState:init()
end

function HighScoreState:enter(params)
    self.highScoresBoard = params.highScoresBoard
end

function HighScoreState:update(deltaTime)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        -- return to start state
        gameStateMachine:change('start')
    end    
end

function HighScoreState:render()
    -- render title
    love.graphics.setFont(gameFonts['medium'])
    love.graphics.printf("HIGH SCORE BOARD", 0, 10, VIRTUAL_WIDTH, 'center')

    -- render the high scores board
    love.graphics.setFont(gameFonts['small'])
    for i = 1, #self.highScoresBoard do
        love.graphics.print(tostring(i)..". "..self.highScoresBoard[i]['name'].." ---------- "..self.highScoresBoard[i]['score'],
            VIRTUAL_WIDTH / 2 - 150,
            30 + i * 16
        )
    end

    -- render guide text
    love.graphics.setFont(gameFonts['small'])
    love.graphics.printf("press Enter to return to the menu !", 0, VIRTUAL_HEIGHT - 20, VIRTUAL_WIDTH, 'center')
end