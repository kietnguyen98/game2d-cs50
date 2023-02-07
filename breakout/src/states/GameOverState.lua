GameOverState = BaseState:extend()

function GameOverState:init()
end

function GameOverState:enter(params)
    self.score = params.score
    self.highScores = params.highScores
end

function GameOverState:update(deltaTime)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        -- check if player's high score is enough to enter the high score board,
        -- should return the index position in high score board
        local isHighScore = false
        local scoreIndex = 1

        for i = 1, #self.highScores do
            if self.score >= self.highScores[i]['score'] then
                scoreIndex = i
                isHighScore = true
                break
            end
        end

        if isHighScore then
            gameSounds['high-score']:play()
            gameStateMachine:change('enter-high-score', {
                highScores = self.highScores,
                score = self.score,
                scoreIndex = scoreIndex
            })
        else
            gameStateMachine:change('start')
        end
    end
end

function GameOverState:render()
    -- render game over text
    love.graphics.setFont(gameFonts['large'])
    love.graphics.printf("Game Over !", 0, VIRTUAL_HEIGHT / 2 - 40, VIRTUAL_WIDTH, 'center')

    -- render player final score
    love.graphics.setFont(gameFonts['small'])
    love.graphics.printf("Your score is: "..tostring(self.score), 0, VIRTUAL_HEIGHT / 2, VIRTUAL_WIDTH, 'center')

    -- render guide text
    love.graphics.setFont(gameFonts['medium'])
    love.graphics.printf("Press Enter to continue...", 0, VIRTUAL_HEIGHT / 2 + 40, VIRTUAL_WIDTH, 'center')
end