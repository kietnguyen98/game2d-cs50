GameObject = class()

function GameObject:init(def)
    self.textureName = def.textureName
    self.quadName = def.quadName

    self.x = def.x
    self.y = def.y

    self.width = def.width
    self.height = def.height

    self.states = def.states
    self.currentState = def.currentState

    self.isSolid = def.isSolid

    self.collidable = def.collidable
    self.onCollide = def.onCollide

    self.hitbox = Hitbox({
        x = self.x + def.hitbox.offsetX,
        y = self.y + def.hitbox.offsetY,
        width = def.hitbox.width,
        height = def.hitbox.height
    })

    self.renderHitbox = false
end

function GameObject:toggleHitbox()
    self.renderHitbox = not self.renderHitbox
end

function GameObject:update(deltaTime)
end

function GameObject:render()
    love.graphics.draw(gameTextures[self.textureName], gameQuads[self.quadName][self.states[self.currentState].quadId],
        self.x, self.y)
    -- render hitbox
    if self.renderHitbox then
        love.graphics.setColor(255 / 255, 0, 0, 255)
        love.graphics.rectangle('line', self.hitbox.x, self.hitbox.y, self.hitbox.width, self.hitbox.height)
        love.graphics.setColor(255, 255, 255, 255)
    end
end
