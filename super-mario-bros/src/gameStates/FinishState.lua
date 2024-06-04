FinishState = BaseState:extend()

function FinishState:init()
end

function FinishState:enter(params)
    self.score = params.score
    self.lives = params.lives
end

function FinishState:update(deltaTime)
    if love.keyboard.wasPressed("enter") or love.keyboard.wasPressed("return") then
        gameStateMachine:change("play")
    end
end

function FinishState:render()
    -- background
    love.graphics.clear(0, 0, 0, 1)

    -- title on screen
    love.graphics.setFont(fontExtraSmall)
    love.graphics.setColor(255, 255, 255, 1)
    love.graphics.printf('Congratulations ! You have finished the game', 0, 16, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Your Final Score is:', 0, 32, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Score:', 64, 48, VIRTUAL_WIDTH, 'left')
    love.graphics.printf(tostring(self.score), -64, 48, VIRTUAL_WIDTH, 'right')
    love.graphics.printf('Bonnus lives:', 64, 64, VIRTUAL_WIDTH, 'left')
    love.graphics.printf(tostring(self.lives) .. " x 1000 = " .. tostring(self.lives * 1000), -64, 64, VIRTUAL_WIDTH,
        'right')
    love.graphics.printf('--------------------------------', 0, 80, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Final Score:', 64, 96, VIRTUAL_WIDTH, 'left')
    love.graphics.printf(tostring(self.score + self.lives * 1000), -64, 96, VIRTUAL_WIDTH, 'right')
    love.graphics.printf('Press Enter to continue...', 0, VIRTUAL_HEIGHT - 16, VIRTUAL_WIDTH, 'center')
    -- reset color
    love.graphics.setColor(255, 255, 255, 255)
end
