PlayState = BaseState:extend()

function PlayState:init()
    -- game pause logic value
    self.isPause = false
end

function PlayState:enter(params)
    self.health = params.health
    self.score = params.score
    self.ball = params.ball
    self.ball.dx = math.random(-200, 200)
    self.ball.dy = math.random(-60, -80)
    self.paddle = params.paddle
    self.bricks = params.bricks
    self.level = params.level
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

    -- check victory and change game state
    if self:checkVictory() then
        gameStateMachine:change('victory', {
            level = self.level,
            score = self.score,
            paddle = self.paddle,
            ball = self.ball,
            health = self.health
        })
    end

    -- update the paddle
    self.paddle:update(deltaTime)

    -- update the ball
    self.ball:update(deltaTime)
    
    -- update all the bricks
    for k, brick in pairs(self.bricks) do
        brick:update(deltaTime)
    end
    
    -- check if the ball collides with the paddle
    if self.ball:isCollides(self.paddle) then
        --
        -- refelect the ball
        --
        -- if the ball hit more to the center of the paddle it should be bounce back harder than with more in the y axis
        local ballAbsoluteVelocityOnY = 50 + 40 * self.paddle.width / (2 * (math.abs(self.paddle.x + self.paddle.width / 2 - self.ball.x) + 10))
        self.ball.dy = -ballAbsoluteVelocityOnY

        -- reset the ball position to the top of the paddle
        self.ball.y = self.paddle.y - self.ball.height

        -- tweak angle of bounce based on where it hits the paddle
        --
        local ballAbsoluteTweakVelocityOnX = 50 + (4 * math.abs(self.paddle.x + self.paddle.width / 2 - self.ball.x))
        -- if we hit the paddle on its left side while it is moving left -> tweak the ball to bounce to the left
        if self.ball.x < self.paddle.x + self.paddle.width / 2 and self.paddle.dx < 0 then
            self.ball.dx = -ballAbsoluteTweakVelocityOnX
        end
        -- if we hit the paddle on its right side while it is moving right -> tweal the ball to bounce to the right
        if self.ball.x > self.paddle.x + self.paddle.width / 2 and self.paddle.dx > 0 then
            self.ball.dx = ballAbsoluteTweakVelocityOnX          
        end

        gameSounds['paddle-hit']:play()
    end

    -- check if the ball collides with a brick
    for k, brick in pairs(self.bricks) do
        if brick.inPlay and self.ball:isCollides(brick) then
            brick:hit()
            -- check if the ball collide with the brick on which edge
            -- top, bottom, left, right to bounce the ball back
            --
            -- left edge and the ball is comming from the left to the right
            if self.ball.x + 2 < brick.x and self.ball.dx > 0 then
                self.ball.dx = -self.ball.dx
                self.ball.x = brick.x - self.ball.width
            -- right edge and the ball is comming from the right to the left
            elseif self.ball.x + 6 > brick.x + brick.width and self.ball.dx < 0 then
                self.ball.dx = -self.ball.dx
                self.ball.x = brick.x + brick.width
            -- top edge and there is no collisions in X axis
            elseif self.ball.y < brick.y then
                self.ball.dy = -self.ball.dy
                self.ball.y = brick.y - self.ball.height    
            -- bottom edge and there is no collisions in X axis
            elseif self.ball.y + self.ball.height > brick.y + brick.height then
                self.ball.dy = -self.ball.dy
                self.ball.y = brick.y + brick.height
            end

            -- the ball hit the brick then player score should increase depend on the brick tier and color level
                self.score = self.score + (brick.tier * 100 + brick.color * 25)
        end
    end

    -- update player health if the ball fallout at the bottom of the screen
    if self.ball.y > VIRTUAL_HEIGHT then
        self.health = self.health - 1
        gameSounds['hurt']:play()
        if self.health == 0 then
            gameStateMachine:change('game-over', {
                score = self.score
            })
        else
            gameStateMachine:change('serve', {
                paddle = self.paddle,
                bricks = self.bricks,
                health = self.health,
                score = self.score   
            })
        end
    end
end

function PlayState:render()
    -- render the paddle
    self.paddle:render()

    -- render the ball
    self.ball:render()

    -- render all the brick
    for k, brick in pairs(self.bricks) do
        brick:render()
    end

    -- render all brick particle system
    for k, brick in pairs(self.bricks) do
        brick:renderParticles()
    end

    -- render player health
    renderHealth(self.health)
    renderScore(self.score)

    -- if the game is paused then show the paused text
    if self.isPause then
        -- show game pausing text
        love.graphics.setFont(gameFonts['large'])
        love.graphics.printf("PAUSED", 0, VIRTUAL_HEIGHT / 2 - 20, VIRTUAL_WIDTH, 'center')
    end
end

function PlayState:checkVictory()
    for k, brick in pairs(self.bricks) do
        if brick.inPlay then
            return false
        end
    end

    return true
end