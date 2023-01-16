Ball = class()

function Ball:init(x, y, width, height)
    -- init position
    self.x = x
    self.y = y 
    
    -- init width, height
    self.width = width
    self.height = height

    -- init velocity
    self.dx = 0
    self.dy = 0
    self:initNewVelocity()
end 

function Ball:reset()
    -- reset position to the center of screen
    self.x = (leftWall.x + rightWall.x) / 2 - 2
    self.y = (bottomWall.y + topWall.y) / 2 - 2
    
    -- reset velocity to a new value
    self:initNewVelocity()
end

function Ball:update(deltaTime)
    self.x = self.x + self.dx * deltaTime
    self.y = self.y + self.dy * deltaTime
end

function Ball:reverseVelocity(paddle)
    if self.dx < BALL_MAX_SPEED then
        self.dx = -self.dx * math.random(100, 120) / 100
    else
        self.dx = -self.dx
    end

    if paddle.dy > 0 then
        -- player move paddle down -> the ball go down -> ball.dy > 0
        self.dy = self.dy * math.random(120, 140) / 100
        self.dy = self.dy > 0 and self.dy or -self.dy
    elseif paddle.dy < 0 then
        -- player move paddle up -> the ball go up -> ball.dy < 0
        self.dy = self.dy * math.random(120, 140) / 100
        self.dy = self.dy < 0 and self.dy or -self.dy
    elseif paddle.dy == 0 then
        self.dy = self.dy * math.random(100, 110) / 100
    end
end


function Ball:isCollide(object)
    if self.x < object.x + object.width and self.x + self.width > object.x and self.y < object.y + object.height and self.y + self.height > object.y  
    then return true
    else return false
    end
end

function Ball:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end

function Ball:initNewVelocity()
    self.dx = math.random(2) == 1 and -math.random(100, 120) or math.random(100, 120)
    self.dy = math.random(2) == 1 and -math.random(20, 60) or math.random(20, 60)
end