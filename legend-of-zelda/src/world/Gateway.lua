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
    elseif self.direction == GATEWAY_DIRECTION_VALUES.BOTTOM then
        self.x = MAP_OFFSET_LEFT + MAP_WIDTH * TILE_WIDTH / 2 - TILE_WIDTH
        self.y = MAP_OFFSET_TOP + MAP_HEIGHT * TILE_HEIGHT - TILE_HEIGHT
        self.width = 32
        self.height = 32
    elseif self.direction == GATEWAY_DIRECTION_VALUES.LEFT then
        self.x = 0
        self.y = MAP_OFFSET_TOP + MAP_HEIGHT * TILE_HEIGHT / 2 - TILE_HEIGHT
        self.width = 32
        self.height = 32
    elseif self.direction == GATEWAY_DIRECTION_VALUES.RIGHT then
        self.x = MAP_OFFSET_LEFT + MAP_WIDTH * TILE_WIDTH - 16
        self.y = MAP_OFFSET_TOP + MAP_HEIGHT * TILE_HEIGHT / 2 - TILE_HEIGHT
        self.width = 32
        self.height = 32
    end
end

function Gateway:open()
    self.isOpen = true
end

function Gateway:update(deltaTime)
end

function Gateway:render()
    local texture = gameTextures[TEXTURE_KEYS.MAP_TILE]
    local quads = gameQuads[QUADS_KEYS.MAP_TILE]
    if self.direction == GATEWAY_DIRECTION_VALUES.TOP then
        if self.isOpen then
            love.graphics.draw(texture, quads[98], self.x, self.y)
            love.graphics.draw(texture, quads[99], self.x + TILE_WIDTH, self.y)
            love.graphics.draw(texture, quads[117], self.x, self.y + TILE_HEIGHT)
            love.graphics.draw(texture, quads[118], self.x + TILE_WIDTH, self.y + TILE_HEIGHT)
        else
            love.graphics.draw(texture, quads[134], self.x, self.y)
            love.graphics.draw(texture, quads[135], self.x + TILE_WIDTH, self.y)
            love.graphics.draw(texture, quads[153], self.x, self.y + TILE_HEIGHT)
            love.graphics.draw(texture, quads[154], self.x + TILE_WIDTH, self.y + TILE_HEIGHT)
        end
    elseif self.direction == GATEWAY_DIRECTION_VALUES.BOTTOM then
        if self.isOpen then
            love.graphics.draw(texture, quads[141], self.x, self.y)
            love.graphics.draw(texture, quads[142], self.x + TILE_WIDTH, self.y)
            love.graphics.draw(texture, quads[160], self.x, self.y + TILE_HEIGHT)
            love.graphics.draw(texture, quads[161], self.x + TILE_WIDTH, self.y + TILE_HEIGHT)
        else
            love.graphics.draw(texture, quads[216], self.x, self.y)
            love.graphics.draw(texture, quads[217], self.x + TILE_WIDTH, self.y)
            love.graphics.draw(texture, quads[235], self.x, self.y + TILE_HEIGHT)
            love.graphics.draw(texture, quads[236], self.x + TILE_WIDTH, self.y + TILE_HEIGHT)
        end
    elseif self.direction == GATEWAY_DIRECTION_VALUES.LEFT then
        if self.isOpen then
            love.graphics.draw(texture, quads[181], self.x, self.y)
            love.graphics.draw(texture, quads[182], self.x + TILE_WIDTH, self.y)
            love.graphics.draw(texture, quads[200], self.x, self.y + TILE_HEIGHT)
            love.graphics.draw(texture, quads[201], self.x + TILE_WIDTH, self.y + TILE_HEIGHT)
        else
            love.graphics.draw(texture, quads[219], self.x, self.y)
            love.graphics.draw(texture, quads[220], self.x + TILE_WIDTH, self.y)
            love.graphics.draw(texture, quads[238], self.x, self.y + TILE_HEIGHT)
            love.graphics.draw(texture, quads[239], self.x + TILE_WIDTH, self.y + TILE_HEIGHT)
        end
    elseif self.direction == GATEWAY_DIRECTION_VALUES.RIGHT then
        if self.isOpen then
            love.graphics.draw(texture, quads[172], self.x, self.y)
            love.graphics.draw(texture, quads[173], self.x + TILE_WIDTH, self.y)
            love.graphics.draw(texture, quads[191], self.x, self.y + TILE_HEIGHT)
            love.graphics.draw(texture, quads[192], self.x + TILE_WIDTH, self.y + TILE_HEIGHT)
        else
            love.graphics.draw(texture, quads[174], self.x, self.y)
            love.graphics.draw(texture, quads[175], self.x + TILE_WIDTH, self.y)
            love.graphics.draw(texture, quads[193], self.x, self.y + TILE_HEIGHT)
            love.graphics.draw(texture, quads[194], self.x + TILE_WIDTH, self.y + TILE_HEIGHT)
        end
    end
end
