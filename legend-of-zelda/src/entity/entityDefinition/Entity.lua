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

    self.textureName = def.textureName
    self.quadsName = def.quadsName
end

function Entity:update(deltaTime)
    self.stateMachine:update(deltaTime)
end

function Entity:changeState(state)
    self.stateMachine:change(state)
end

function Entity:checkWallCollisions()
    local MAP_BOUNDARIES = {
        ['TOP'] = MAP_OFFSET_TOP,
        ['BOTTOM'] = MAP_HEIGHT * TILE_HEIGHT - TILE_HEIGHT,
        ['LEFT'] = TILE_WIDTH,
        ['RIGHT'] = (MAP_WIDTH - 1) * TILE_WIDTH - TILE_WIDTH
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
    return (self.x + self.width > target.x) and (self.x < target.x + target.width) and
               (self.y + self.height > target.height) and (self.y < target.y + target.height)
end

function Entity:render()
    love.graphics.draw(gameTextures[self.textureName],
        gameQuads[self.quadsName][self.currentAnimation:getCurrentFrame()], math.floor(self.x - self.offsetX),
        math.floor(self.y - self.offsetY))
end
