VictoryState = BaseState:extend()

--[[
    victory state is just like serve state but it
    between current play state and a higher level play state
]]--

function VictoryState:init()
end

function VictoryState:enter(params)
    self.level = params.level
    self.score = params.score
    self.paddle = params.paddle
    self.health = params.health
    self.ball = params.ball
    self.highScoresBoard = params.highScoresBoard
end

function VictoryState:update(deltaTime)
    -- update the paddle
    self.paddle:update(deltaTime)

    -- update the ball and make it sticked to the paddle
    self.ball.x = self.paddle.x + self.paddle.width / 2 - self.ball.width / 2
    self.ball.y = self.paddle.y - self.ball.height

    -- go to play screen when the player press enter
    if love.keyboard.wasPressed('space') then
        gameStateMachine:change('play', {
            paddle = self.paddle,
            bricks = LevelMaker.createMap(self.level + 1),
            health = self.health,
            score = self.score,
            ball = self.ball,
            level = self.level + 1,
            highScoresBoard = self.highScoresBoard
        })
    end
end

function VictoryState:render()
    -- render the paddle
    self.paddle:render()
    
    -- render the ball
    self.ball:render()

    -- render health
    renderHealth(self.health)
    
    -- render the score
    renderScore(self.score)

    -- render level complete text
    love.graphics.setFont(gameFonts['large'])
    love.graphics.printf("Level "..tostring(self.level).." Complete !", 0, VIRTUAL_HEIGHT / 4, VIRTUAL_WIDTH, 'center')

    -- render instruction text
    love.graphics.setFont(gameFonts['medium'])
    love.graphics.printf('Press BACKSPACE to play !', 0, VIRTUAL_HEIGHT / 2, VIRTUAL_WIDTH, 'center')
end