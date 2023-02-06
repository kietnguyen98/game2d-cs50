Brick = class()

function Brick:init(x, y)
    -- init brick tier value
    self.tier = 1
    self.color = 1

    -- init brick positional values
    self.x = x
    self.y = y
    
    -- init brick dimensional values
    self.width = BRICK_WIDTH
    self.height = BRICK_HEIGHT

    -- this value is use to determine whether this brick should be rendered
    self.inPlay = true
end

function Brick:hit()
    self.inPlay = false
    gameSounds['brick-hit-2']:play()
end

function Brick:update()
end

function Brick:render()
    if self.inPlay then
        love.graphics.draw(gameTextures['main'], gameObjectQuads['bricks'][((self.color - 1) * 4) + self.tier], self.x, self.y)
    end
end