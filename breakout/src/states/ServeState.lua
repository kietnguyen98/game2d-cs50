ServeState = BaseState:extend()

function ServeState:init()
end

function ServeState:enter(params)
    self.paddle = params.paddle
    self.bricks = params.bricks
    self.health = params.health
    self.score = params.score
    
    -- init new ball
    self.ball = Ball()
    -- init new ball skin with random value
    -- so that each new game, there will be a new skin
    self.ball.skin = math.random(1, 7)
end

function ServeState:update(deltaTime)
    -- update the paddle
    self.paddle:update(deltaTime)
    -- set the ball to stick with the paddle
    self.ball.x = self.paddle.x + self.paddle.width / 2 - self.ball.width / 2
    self.ball.y = self.paddle.y - self.ball.height

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        -- change state to play state and pass all needed arguments
        gameStateMachine:change('play', {
            paddle = self.paddle,
            bricks = self.bricks,
            health = self.health,
            score = self.score,
            ball = self.ball,
        })
    end
end

function ServeState:render()
    -- render the paddle
    self.paddle:render()
    
    -- render the ball
    self.ball:render()
    
    -- render bricks map
    for k, brick in pairs(self.bricks) do
        brick:render()
    end

    -- render player health
    renderHealth(self.health)
    renderScore(self.score)

    -- render guide text
    love.graphics.setFont(gameFonts['medium'])
    love.graphics.printf("Press ENTER to play !", 0, VIRTUAL_HEIGHT / 2 - 20, VIRTUAL_WIDTH, 'center')
end