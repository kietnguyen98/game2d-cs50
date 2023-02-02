Paddle = class()

INNIT_PADDLE_WIDTH = 64
INNIT_PADDLE_HEIGHT = 16

function Paddle:init()
    -- paddle position
    self.x = VIRTUAL_WIDTH / 2 - INNIT_PADDLE_WIDTH / 2
    self.y = VIRTUAL_HEIGHT - INNIT_PADDLE_HEIGHT - 16 -- must - 16 to place the paddle above the bottom of the screen

    -- start with no velocity
    self.dx = 0

    self.width = INNIT_PADDLE_WIDTH
    self.height = INNIT_PADDLE_HEIGHT

    -- change skin mean change color of the paddle
    self.skin = 1

    -- the variant is which of the four paddle sizes we currently are;
    -- 2 is the starting size, as the smallest is too tough to start with
    self.size = 2
end

function Paddle:update(deltaTime) 
    -- keyboard input
    if love.keyboard.isDown('left') then
    -- user press left key so move the paddle to the left
        self.dx = -PADDLE_SPEED
    elseif love.keyboard.isDown('right') then
        self.dx = PADDLE_SPEED
    else
        -- user release moving buttons => the paddle stop
        self.dx = 0
    end

    if self.dx < 0 then
        self.x = math.max(0, self.x + self.dx * deltaTime)
    end

    if self.dx > 0 then
        self.x = math.min(VIRTUAL_WIDTH - self.width, self.x + self.dx * deltaTime)
    end
end

function Paddle:render()
    love.graphics.draw(gameTextures["main"], gameObjectQuads["paddles"][self.size + 4 * (self.skin - 1)], self.x, self.y)
end
