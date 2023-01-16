Coin = class()

local COIN_IMAGES = {
    love.graphics.newImage('assets/goldCoin1.png'),
    love.graphics.newImage('assets/goldCoin2.png'),
    love.graphics.newImage('assets/goldCoin3.png'),
    love.graphics.newImage('assets/goldCoin4.png'),
    love.graphics.newImage('assets/goldCoin5.png'),
}
local COIN_CHANGE_STATE_DURATION = 1 / 6

function Coin:init(x, y)
    self.x = x
    self.y = y
    self.width = COIN_IMAGES[1]:getWidth()
    self.height = COIN_IMAGES[1]:getHeight()

    self.imageIndex = 1
    self.image = COIN_IMAGES[self.imageIndex]

    self.timer = 0
    self.scored = false
end

function Coin:update(deltaTime)
    self.timer = self.timer + deltaTime

    if self.timer > COIN_CHANGE_STATE_DURATION then
        if self.imageIndex == 5 then
            self.imageIndex = 1
        else
            self.imageIndex = self.imageIndex + 1
        end

        self.timer = 0
    end

    self.image = COIN_IMAGES[self.imageIndex]

    self.x = self.x - PIPE_PAIR_SCROLL_SPEED * deltaTime
end

function Coin:render()
    love.graphics.draw(self.image, self.x - self.width / 2, self.y - self.height / 2, 0, 1, 1)
end