GameOverState = BaseState:extend()

function GameOverState:init()
    self.transitionAlpha = 1

    self.gameOverTextAlpha = 1
    -- change game over text alpha for every 0.25s 
    Timer.every(0.5, function() 
        self.gameOverTextAlpha = self.gameOverTextAlpha == 1 and 0 or 1 
    end)
end

function GameOverState:enter(params)
    self.currentScore = params.score
    self.highScoresBoard = params.highScoresBoard
    -- apply sound effect
    gameSounds['game_over']:play()
end

function GameOverState:update(deltaTime)
    -- apply animation logic using tween function
    Timer.tween(1, {
        [self] = {transitionAlpha = 0}
    })
    -- change to start state when ever user press enter key
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gameSounds['select_option']:play()
        -- check if player's high score is enough to enter the high score board,
        -- should return the index position in high score board
        local isHighScore = false
        local scoreIndex = 1

        for i = 1, #self.highScoresBoard do
            if self.currentScore >= self.highScoresBoard[i]['scores'] then
                scoreIndex = i
                isHighScore = true
                break
            end
        end

        if isHighScore then
            gameSounds['high-score']:play()
            gameStateMachine:change('enter-high-scores', {
                highScoresBoard = self.highScoresBoard,
                score = self.currentScore,
                scoreIndex = scoreIndex
            })
        else
            gameStateMachine:change('start')
        end
    end

    Timer.update(deltaTime)
end

function GameOverState:render()
    -- render game over text and gui text
    love.graphics.setColor(OverlayColor.BLACK_BLUR)
    love.graphics.rectangle('fill', VIRTUAL_WIDTH / 2 - 128, 64, 256, 136, 16)
    
    -- render game over text
    love.graphics.setFont(gameFonts['large'])
    -- render text shadow
    drawTextShadow('GAME OVER', 80)
    -- render the text
    love.graphics.setColor(GlobalColor.DARK_RED)
    love.graphics.printf('GAME OVER', VIRTUAL_WIDTH / 2 - 128, 80, 256, 'center')
    
    love.graphics.setColor(TextOptionColor.NORMAL)
    love.graphics.setFont(gameFonts['medium'])
    love.graphics.printf('Your score: '..tostring(self.currentScore), VIRTUAL_WIDTH / 2 - 128, 140, 256, 'center')
    love.graphics.setColor(48/255, 155/255, 130/255, self.gameOverTextAlpha)
    love.graphics.printf('Press "Enter"', VIRTUAL_WIDTH / 2 - 128, 164, 256, 'center')
     -- render foregrounnd black overlay which fill all the screen 
     -- to implement screen trasition animation
     love.graphics.setColor(0, 0, 0, self.transitionAlpha)
     if self.transitionAlpha > 0 then
        love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
     end
end