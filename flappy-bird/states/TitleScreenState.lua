TitleScreenState = BaseState:extend()
local gameLogoImage = love.graphics.newImage('assets/logo.png')

function TitleScreenState:update(deltaTime)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gameStateMachine:change('countDown')    
    end
end

function TitleScreenState:render()
    love.graphics.draw(gameLogoImage, VIRTUAL_WIDTH / 2 - gameLogoImage:getWidth() / 2, 50)
    love.graphics.setFont(fontSmall)
    love.graphics.printf('Press "Enter" to play game', 0, 200, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Press "Q" to make the bird go up', 0, 220, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Press "P" to pause the game', 0, 240, VIRTUAL_WIDTH, 'center')
end