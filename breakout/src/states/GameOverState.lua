GameOverState = BaseState:extend()

function GameOverState:init()
end

function GameOverState:enter(params)
    self.score = params.score
end

function GameOverState:update(deltaTime)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gameStateMachine:change('start')
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
    love.graphics.printf("Press Enter to return to Menu Screen !", 0, VIRTUAL_HEIGHT / 2 + 40, VIRTUAL_WIDTH, 'center')
end