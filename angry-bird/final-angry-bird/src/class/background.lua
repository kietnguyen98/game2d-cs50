Background = class()

BACKGROUND_TYPE = {'grass-land', 'toons', 'halls', 'halloween', 'easter-eggs'}

function Background:init()
    self.type = BACKGROUND_TYPE[math.random(#BACKGROUND_TYPE)]
    self.texture = gameTextures['background-' .. self.type]
    self.scaleX = VIRTUAL_WIDTH / self.texture:getWidth();
    self.scaleY = VIRTUAL_HEIGHT / self.texture:getHeight();
end

function Background:update(deltaTime)
end

function Background:render()
    love.graphics.draw(self.texture, 0, 0, 0, self.scaleX, self.scaleY)
end
