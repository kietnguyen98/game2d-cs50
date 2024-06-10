Entity = class()

function Entity:init(def)
    self.x = def.x
    self.y = def.y

    self.offsetX = def.offsetX or 0
    self.offsetY = def.offsetY or 0

    self.width = def.width
    self.height = def.heigt

    self.movingSpeed = def.movingSpeed

    self.direction = def.direction or ENTITY_DIRECTION_VALUES.DOWN
    self.animations = def.animations

    self.health = def.health
    self.isDead = false
end

function Entity:update(deltaTime)
    self.stateMachine:update(deltaTime)
end

function Entity:changeState(state)
    self.stateMachine:change(state)
end

function Entity:changeAnimation(newAnimation)

end

function Entity:collides(target)
    -- using AABB here
    return (self.x + self.width > target.x) and (self.x < target.x + target.width) and
               (self.y + self.height > target.height) and (self.y < target.y + target.height)
end

function Entity:render()
end
