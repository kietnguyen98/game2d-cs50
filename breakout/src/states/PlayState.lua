PlayState = BaseState:extend()

function PlayState:init()
    -- initialize the Paddle
    self.paddle = Paddle()

    -- initialize the Ball with skin 1
    self.ball = Ball(1)
    -- init ball velocity
    self.ball.dx = math.random(-200, 200)
    self.ball.dy = math.random(50, 60)

    -- game pause logic value
    self.isPause = false
end

function PlayState:update(deltaTime)
    -- game pausing logic
    if self.isPause then
        if love.keyboard.wasPressed('space') then
        -- unpaused
            self.isPause = false
            gameSounds['pause']:play()
        else
            return
        end
    else
        -- pause
        if love.keyboard.wasPressed('space') then
            self.isPause = true
            gameSounds['pause']:play()
            return
        end
    end        

    -- update the paddle
    self.paddle:update(deltaTime)

    -- update the ball
    self.ball:update(deltaTime)
    
    -- check if the ball collides with the paddle
    if self.ball:isCollides(self.paddle) then
        -- refelect the ball
        self.ball.dy = -self.ball.dy
        self.ball.y = self.paddle.y - self.ball.height
        gameSounds['paddle-hit']:play()
    end
end

function PlayState:render()
    -- render the paddle
    self.paddle:render()

    -- render the ball
    self.ball:render()

    -- if the game is paused then show the paused text
    if self.isPause then
        -- show game pausing text
        love.graphics.setFont(gameFonts['large'])
        love.graphics.printf("PAUSED", 0, VIRTUAL_HEIGHT / 2 - 20, VIRTUAL_WIDTH, 'center')
    end
end