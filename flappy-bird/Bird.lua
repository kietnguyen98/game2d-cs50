Bird = class()
local BIRD_BALANCE_IMAGE = love.graphics.newImage('assets/bird-balance.png')
local BIRD_DOWN_IMAGE = love.graphics.newImage('assets/bird-down.png')
local BIRD_UP_IMAGE = love.graphics.newImage('assets/bird-up.png')
local BIRD_BOUNDING_BOX_TOP_LEFT_OFFSET = 2
local BIRD_BOUNDING_BOX_BOTTOM_RIGHT_OFFSET = 4

function Bird:init(x, y)
    self.image = BIRD_BALANCE_IMAGE
    self.orientation = 0
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
    self.x = x - (self.width / 2)
    self.y = y - (self.height / 2)
    self.dy = 0
end

function Bird:render()
    love.graphics.draw(self.image, self.x, self.y, self.orientation)
end

function Bird:update(deltaTime)
    -- v = v0 + g.dt
    -- x = x0 + v.dt + (1/2).g.(dt^2)
    self.dy = self.dy + GRAVITY * deltaTime
    self.y = self.y + self.dy * deltaTime + 1 / 2 * GRAVITY * deltaTime * deltaTime

    if love.keyboard.wasPressed('q') then
        self.dy = -350
        sounds['jump']:play()
    end

    -- update bird state
    if self.dy < 0 then
        self.orientation = -math.pi / 8
        self.image = BIRD_UP_IMAGE
    elseif self.dy > 0 then
        local rotateDegree = math.pi / 2 / 45
        if(self.orientation + rotateDegree > math.pi / 2) then
            self.orientation = math.pi / 2
        else
            self.orientation = self.orientation + rotateDegree
        end
        
        self.image = BIRD_DOWN_IMAGE
    else
        self.orientation = 0
        self.image = BIRD_BALANCE_IMAGE
    end
end

function Bird:collides(object)
    -- apply aabb bounding box collision detection
    if (self.x - BIRD_BOUNDING_BOX_TOP_LEFT_OFFSET) < object.x + object.width 
    and (self.x + BIRD_BOUNDING_BOX_TOP_LEFT_OFFSET) + (self.width - BIRD_BOUNDING_BOX_BOTTOM_RIGHT_OFFSET) > object.x 
    and (self.y - BIRD_BOUNDING_BOX_BOTTOM_RIGHT_OFFSET) < object.y + object.height
    and (self.y + BIRD_BOUNDING_BOX_TOP_LEFT_OFFSET) + (self.height - BIRD_BOUNDING_BOX_BOTTOM_RIGHT_OFFSET) > object.y 
    then
        return true
    else
        return false
    end
end