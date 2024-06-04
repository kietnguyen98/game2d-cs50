StartState = BaseState:extend()

function StartState:init()
    self.BACKGROUND = {
        MOUTAINS_1 = love.graphics.newImage("assets/background_mountains_1.png"),
        MOUTAINS_2 = love.graphics.newImage("assets/background_mountains_2.png"),
        CLOUDS = love.graphics.newImage("assets/background_clouds.png")
    }
    self.backgroundScrollSpeed = 25
    self.backgroundScrollX = 0
    self.backgroundScrollY = 0
end

function StartState:update(deltaTime)
    self.backgroundScrollX = (self.backgroundScrollX + self.backgroundScrollSpeed * deltaTime) % VIRTUAL_WIDTH

    if love.keyboard.wasPressed("enter") or love.keyboard.wasPressed("return") then
        gameStateMachine:change("play")
    end
end

function StartState:render()
    -- background
    love.graphics.draw(self.BACKGROUND.MOUTAINS_1, -self.backgroundScrollX, self.backgroundScrollY, 0,
        VIRTUAL_WIDTH / self.BACKGROUND.MOUTAINS_1:getWidth(), VIRTUAL_HEIGHT / self.BACKGROUND.MOUTAINS_1:getHeight())
    love.graphics.draw(self.BACKGROUND.MOUTAINS_2, -self.backgroundScrollX, self.backgroundScrollY, 0,
        VIRTUAL_WIDTH / self.BACKGROUND.MOUTAINS_2:getWidth(), VIRTUAL_HEIGHT / self.BACKGROUND.MOUTAINS_2:getHeight())
    love.graphics.draw(self.BACKGROUND.CLOUDS, -self.backgroundScrollX, self.backgroundScrollY, 0,
        VIRTUAL_WIDTH / self.BACKGROUND.CLOUDS:getWidth() / 2, VIRTUAL_HEIGHT / self.BACKGROUND.CLOUDS:getHeight() / 4)
    love.graphics.draw(self.BACKGROUND.CLOUDS, VIRTUAL_WIDTH / 2 - self.backgroundScrollX, self.backgroundScrollY, 0,
        VIRTUAL_WIDTH / self.BACKGROUND.CLOUDS:getWidth() / 2, VIRTUAL_HEIGHT / self.BACKGROUND.CLOUDS:getHeight() / 4)

    love.graphics.draw(self.BACKGROUND.MOUTAINS_1, -self.backgroundScrollX + VIRTUAL_WIDTH, self.backgroundScrollY, 0,
        VIRTUAL_WIDTH / self.BACKGROUND.MOUTAINS_1:getWidth(), VIRTUAL_HEIGHT / self.BACKGROUND.MOUTAINS_1:getHeight())
    love.graphics.draw(self.BACKGROUND.MOUTAINS_2, -self.backgroundScrollX + VIRTUAL_WIDTH, self.backgroundScrollY, 0,
        VIRTUAL_WIDTH / self.BACKGROUND.MOUTAINS_2:getWidth(), VIRTUAL_HEIGHT / self.BACKGROUND.MOUTAINS_2:getHeight())
    love.graphics.draw(self.BACKGROUND.CLOUDS, -self.backgroundScrollX + VIRTUAL_WIDTH, self.backgroundScrollY, 0,
        VIRTUAL_WIDTH / self.BACKGROUND.CLOUDS:getWidth() / 2, VIRTUAL_HEIGHT / self.BACKGROUND.CLOUDS:getHeight() / 4)
    love.graphics.draw(self.BACKGROUND.CLOUDS, VIRTUAL_WIDTH / 2 - self.backgroundScrollX + VIRTUAL_WIDTH,
        self.backgroundScrollY, 0, VIRTUAL_WIDTH / self.BACKGROUND.CLOUDS:getWidth() / 2,
        VIRTUAL_HEIGHT / self.BACKGROUND.CLOUDS:getHeight() / 4)

    -- title on screen
    love.graphics.setFont(fontSmall)
    love.graphics.setColor(0, 0, 0, 255)
    love.graphics.printf('Press Enter to play game !', 0, VIRTUAL_HEIGHT / 3 + 2, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.printf('Press Enter to play game !', 0, VIRTUAL_HEIGHT / 3, VIRTUAL_WIDTH, 'center')
    -- reset color
    love.graphics.setColor(255, 255, 255, 255)
end
