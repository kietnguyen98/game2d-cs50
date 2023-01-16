CountDownState = BaseState:extend()

COUNTDOWN_TIME = 0.75

function CountDownState:init()
    self.counter = 3
    self.timer = 0
end

function CountDownState:enter()
    isScrolling = true    
end

function CountDownState:update(deltaTime)
    -- update timer
    self.timer = self.timer + deltaTime
    if self.timer > COUNTDOWN_TIME then
        self.counter = self.counter - 1
        self.timer = 0
    end

    if self.counter == 0 then
        gameStateMachine:change('play')
    end
end

function CountDownState:render()
    love.graphics.setFont(fontMedium)
    love.graphics.printf('the game will start in: ', 0, 60, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(fontExtraLarge)
    love.graphics.printf(tostring(self.counter), 0, 100, VIRTUAL_WIDTH, 'center')
end