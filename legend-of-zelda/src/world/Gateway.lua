Gateway = class()

function Gateway:init(direction, isOpen, room)
    self.direction = direction
    self.isOpen = isOpen
    self.room = room

    if self.direction == GATEWAY_DIRECTION_VALUES.TOP then
        self.x = MAP_OFFSET_LEFT + MAP_WIDTH * TILE_WIDTH / 2 - TILE_WIDTH
        self.y = MAP_OFFSET_TOP - TILE_HEIGHT
        self.width = 32
        self.height = 32
        self.hitbox = Hitbox({
            x = self.x + 14,
            y = self.y + 28,
            width = 4,
            height = 4
        })
    elseif self.direction == GATEWAY_DIRECTION_VALUES.BOTTOM then
        self.x = MAP_OFFSET_LEFT + MAP_WIDTH * TILE_WIDTH / 2 - TILE_WIDTH
        self.y = MAP_OFFSET_TOP + MAP_HEIGHT * TILE_HEIGHT - TILE_HEIGHT
        self.width = 32
        self.height = 32
        self.hitbox = Hitbox({
            x = self.x + 14,
            y = self.y,
            width = 4,
            height = 4
        })
    elseif self.direction == GATEWAY_DIRECTION_VALUES.LEFT then
        self.x = 0
        self.y = MAP_OFFSET_TOP + MAP_HEIGHT * TILE_HEIGHT / 2 - TILE_HEIGHT
        self.width = 32
        self.height = 32
        self.hitbox = Hitbox({
            x = self.x + 28,
            y = self.y + 14,
            width = 4,
            height = 4
        })
    elseif self.direction == GATEWAY_DIRECTION_VALUES.RIGHT then
        self.x = MAP_OFFSET_LEFT + MAP_WIDTH * TILE_WIDTH - 16
        self.y = MAP_OFFSET_TOP + MAP_HEIGHT * TILE_HEIGHT / 2 - TILE_HEIGHT
        self.width = 32
        self.height = 32
        self.hitbox = Hitbox({
            x = self.x,
            y = self.y + 14,
            width = 4,
            height = 4
        })
    end
end

function Gateway:open()
    self.isOpen = true
end

function Gateway:close()
    self.isOpen = false
end

function Gateway:update(deltaTime)
end

function Gateway:render(shiftingX, shiftingY)
    local texture = gameTextures[TEXTURE_KEYS.MAP_TILE]
    local quads = gameQuads[QUADS_KEYS.MAP_TILE]
    local tileIds = TILE_ID.GATEWAY[self.direction][self.isOpen and 'OPEN' or 'CLOSE']
    love.graphics.draw(texture, quads[tileIds['TOP_LEFT']], self.x + shiftingX or 0, self.y + shiftingY or 0)
    love.graphics.draw(texture, quads[tileIds['TOP_RIGHT']], self.x + TILE_WIDTH + shiftingX or 0,
        self.y + shiftingY or 0)
    love.graphics.draw(texture, quads[tileIds['BOTTOM_LEFT']], self.x + shiftingX or 0,
        self.y + TILE_HEIGHT + shiftingY or 0)
    love.graphics.draw(texture, quads[tileIds['BOTTOM_RIGHT']], self.x + TILE_WIDTH + shiftingX or 0,
        self.y + TILE_HEIGHT + shiftingY or 0)
end
