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
    -- logic to implement brick level system
    if self.tier > 1 then
        if self.color == 1 then
            -- the brick is now at the lowest color level of its tier
            -- it should be reduce to lower tier and its color must be the highest in the new tier  
            self.tier = self.tier - 1
            self.color = 5
        else
            -- the brick color level is > 1 then just reduce its level color
            self.color = self.color - 1
        end    
    else
        -- the brick tier = 1
        if self.color == 1 then
            -- its tier is the lowest and also its level color
            -- remove it out of the game
            self.tier = 0
            self.inPlay = false
        else
            -- just reduce it level color
            self.color = self.color - 1
        end
    end

    if self.tier == 0 then
        gameSounds['brick-hit-1']:stop()
        gameSounds['brick-hit-1']:play()
    else
        gameSounds['brick-hit-2']:stop()
        gameSounds['brick-hit-2']:play()
    end
end

function Brick:update()
end

function Brick:render()
    if self.inPlay then
        love.graphics.draw(gameTextures['main'], gameObjectQuads['bricks'][((self.color - 1) * 4) + self.tier], self.x, self.y)
    end
end