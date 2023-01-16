Paddle = class()

function Paddle:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    
    self.dy = 0
end

function Paddle:update(deltaTime)
    if self.dy < TOP_WALL_SEGMENT + WALL_THICKNESS + OTHER_WALL_SEGMENT then
        -- paddle going up
        self.y = math.max(TOP_WALL_SEGMENT + WALL_THICKNESS + OTHER_WALL_SEGMENT, self.y + self.dy * deltaTime)
    else
        -- paddle going down
        self.y = math.min(VIRTUAL_HEIGHT - WALL_THICKNESS - 2 * OTHER_WALL_SEGMENT - self.height, self.y + self.dy * deltaTime)
    end
end

-- the ai
function euclideDistance(firstPoint, secondPoint)
    return math.sqrt(math.pow(firstPoint.x - secondPoint.x, 2) + math.pow(firstPoint.y - secondPoint.y, 2))
end

function Paddle:selfUpdate(deltaTime)
    -- calculate next move
    ballPos = {
        x = ball.x,
        y = ball.y + ball.width / 2
    }

    paddleUpPos = {
        x = self.x + self.width,
        y = self.y + self.height / 2 - PADDLE_SPEED * deltaTime
    }
    
    paddleDownPos = {
        x = self.x + self.width,
        y = self.y + self.height / 2 + PADDLE_SPEED * deltaTime
    }

    if euclideDistance(paddleUpPos, ballPos) > euclideDistance(paddleDownPos, ballPos) then
        -- the paddle should go down
        self.dy = PADDLE_SPEED
    elseif euclideDistance(paddleUpPos, ballPos) < euclideDistance(paddleDownPos, ballPos) then  
        -- the paddle should go up
        self.dy = -PADDLE_SPEED
    else
        -- the paddle should stay at current position
        self.dy = 0
    end
    self:update(deltaTime)
end

function Paddle:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end