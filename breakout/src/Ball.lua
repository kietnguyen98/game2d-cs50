Ball = class()

BALL_INNIT_POSTION = {
    x = VIRTUAL_WIDTH / 2 - 8 / 2,
    y = VIRTUAL_HEIGHT / 2 - 8 / 2
}

function Ball:init(skin)
    -- ball positional values
    self.x = BALL_INNIT_POSTION.x
    self.y = BALL_INNIT_POSTION.y

    -- ball dimensional values
    self.width = 8
    self.height = 8

    -- ball velocity values
    self.dx = 0
    self.dy = 0

    -- ball skin values
    -- table of quads relating to the global block texture using this value
    self.skin = skin
end


function Ball:update(deltaTime)
    -- update ball position by velocity
    self.x = self.x + self.dx * deltaTime
    self.y = self.y + self.dy * deltaTime

    -- update ball bouncing off when it hit the wall
    -- left wall
    if self.x <= 0 then
        self.x = 0
        self.dx = -self.dx
        gameSounds['wall-hit']:play()    
    end

    -- right wall
    if self.x + self.width >= VIRTUAL_WIDTH then
        self.x = VIRTUAL_WIDTH - self.width
        self.dx = -self.dx
        gameSounds['wall-hit']:play()
    end

    -- top wall
    if self.y <= 0 then
        self.y = 0
        self.dy = -self.dy
        gameSounds['wall-hit']:play()
    end
end

function Ball:isCollides(object)
    -- using aabb collisions detection
    if self.x + self.width > object.x and
    self.x < object.x + object.width and
    self.y + self.height > object.y and
    self.y < object.y + object.height then
        return true
    end
end

function Ball:reset()
    self.x = BALL_INNIT_POSTION.x
    self.y = BALL_INNIT_POSTION.y
    self.dx = 0
    self.dy = 0
end

function Ball:render()
    love.graphics.draw(gameTextures['main'], gameObjectQuads['balls'][self.skin], self.x, self.y)
end