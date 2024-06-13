Entity = class()

function Entity:init(def)
    self.x = def.x
    self.y = def.y

    self.offsetX = def.offsetX or 0
    self.offsetY = def.offsetY or 0

    self.width = def.width
    self.height = def.height

    self.movingSpeed = def.movingSpeed

    self.direction = def.direction or ENTITY_DIRECTION_VALUES.DOWN
    self.animations = def.animations

    self.health = def.health
    self.isDead = false

    self.textureName = def.textureName
    self.quadsName = def.quadsName

    self.hitboxOffsetX = def.hitbox and def.hitbox.offsetX or 0
    self.hitboxOffsetY = def.hitbox and def.hitbox.offsetY or 0
    self.hitboxWidth = def.hitbox and def.hitbox.width or self.width
    self.hitboxHeight = def.hitbox and def.hitbox.height or self.height
    self.hitbox = Hitbox({
        x = self.x + self.hitboxOffsetX,
        y = self.y + self.hitboxOffsetY,
        width = self.hitboxWidth,
        height = self.hitboxHeight
    })
    self.renderHitbox = false
end

function Entity:update(deltaTime)
    if not self.isDead then
        self.stateMachine:update(deltaTime)
        -- update hitbox position to bound to entity
        self.hitbox.x = self.x + self.hitboxOffsetX
        self.hitbox.y = self.y + self.hitboxOffsetY
    end
end

function Entity:changeState(state)
    self.stateMachine:change(state)
end

function Entity:toggleHitbox()
    self.renderHitbox = not self.renderHitbox
end

function Entity:checkWallCollisions()
    local MAP_BOUNDARIES = {
        ['TOP'] = MAP_OFFSET_TOP,
        ['BOTTOM'] = MAP_HEIGHT * TILE_HEIGHT - TILE_HEIGHT,
        ['LEFT'] = MAP_OFFSET_LEFT + TILE_WIDTH,
        ['RIGHT'] = MAP_OFFSET_LEFT + (MAP_WIDTH - 1) * TILE_WIDTH - TILE_WIDTH
    }

    if self.direction == ENTITY_DIRECTION_VALUES.UP then
        if self.y < MAP_BOUNDARIES.TOP then
            return true
        end
    elseif self.direction == ENTITY_DIRECTION_VALUES.DOWN then
        if self.y > MAP_BOUNDARIES.BOTTOM then
            return true
        end
    elseif self.direction == ENTITY_DIRECTION_VALUES.LEFT then
        if self.x < MAP_BOUNDARIES.LEFT then
            return true
        end
    elseif self.direction == ENTITY_DIRECTION_VALUES.RIGHT then
        if self.x > MAP_BOUNDARIES.RIGHT then
            return true
        end
    end

    return false
end

function Entity:collides(target)
    -- using AABB here
    return (not self.isDead) and (self.hitbox.x + self.hitbox.width > target.x) and
               (self.hitbox.x < target.x + target.width) and (self.hitbox.y + self.hitbox.height > target.y) and
               (self.hitbox.y < target.y + target.height)
end

function Entity:render()
    if not self.isDead then
        love.graphics.draw(gameTextures[self.textureName],
            gameQuads[self.quadsName][self.currentAnimation:getCurrentFrame()], math.floor(self.x - self.offsetX),
            math.floor(self.y - self.offsetY))
        -- render hitbox
        if self.renderHitbox then
            love.graphics.setColor(255 / 255, 0, 0, 255)
            love.graphics.rectangle('line', self.hitbox.x, self.hitbox.y, self.hitbox.width, self.hitbox.height)
            love.graphics.setColor(255, 255, 255, 255)
        end
    end
end
