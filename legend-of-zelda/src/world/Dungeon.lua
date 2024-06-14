Dungeon = class()

function Dungeon:init(player)
    self.player = player
    self.currentRoom = Room(self.player)
    self.nextRoom = nil
    self.cameraX = 0
    self.cameraY = 0
    -- register on player enter an open gateway event
    -- perform shifting player to the next room if the player go to pass the open door
    Event.on(EVENT_NAME_KEYS.SHIFT_PLAYER_UP, function()
        return self:shiftPlayerToNextRoom(0, -VIRTUAL_HEIGHT)
    end)
    Event.on(EVENT_NAME_KEYS.SHIFT_PLAYER_DOWN, function()
        return self:shiftPlayerToNextRoom(0, VIRTUAL_HEIGHT)
    end)
    Event.on(EVENT_NAME_KEYS.SHIFT_PLAYER_LEFT, function()
        return self:shiftPlayerToNextRoom(-VIRTUAL_WIDTH, 0)
    end)
    Event.on(EVENT_NAME_KEYS.SHIFT_PLAYER_RIGHT, function()
        return self:shiftPlayerToNextRoom(VIRTUAL_WIDTH, 0)
    end)
    self.isShiftingPlayer = false
end

function Dungeon:update(deltaTime)
    if not self.isShiftingPlayer then
        self.currentRoom:update(deltaTime)
    else
        self.player.currentAnimation:update(deltaTime)
    end
end

function Dungeon:shiftPlayerToNextRoom(shiftingX, shiftingY)
    self.isShiftingPlayer = true
    self.nextRoom = Room(self.player)
    self.nextRoom.shiftingX = shiftingX
    self.nextRoom.shiftingY = shiftingY
    for i, gateway in pairs(self.nextRoom.gateways) do
        gateway:open()
    end
    local playerShiftingX = self.player.x
    local playerShiftingY = self.player.y
    local playerX = self.player.x
    local playerY = self.player.y

    if shiftingX > 0 then
        playerShiftingX = self.player.x + 4 * TILE_WIDTH +
                              (math.abs(self.player.hitbox.x - self.player.x) + self.player.hitbox.width)
        playerX = MAP_OFFSET_LEFT + TILE_WIDTH - math.abs(self.player.hitbox.x - self.player.x)
    elseif shiftingX < 0 then
        playerShiftingX = self.player.x - 4 * TILE_WIDTH -
                              (math.abs(self.player.hitbox.x - self.player.x) + self.player.hitbox.width)
        playerX = MAP_OFFSET_LEFT + MAP_WIDTH * TILE_WIDTH - TILE_WIDTH -
                      (math.abs(self.player.hitbox.x - self.player.x) + self.player.hitbox.width)
    elseif shiftingY > 0 then
        playerShiftingY = self.player.y + (2 * TILE_HEIGHT + MAP_OFFSET_TOP + TILE_HEIGHT) + self.player.hitbox.height
        playerY = MAP_OFFSET_TOP + TILE_HEIGHT - math.abs(self.player.hitbox.y - self.player.y)
    elseif shiftingY < 0 then
        playerShiftingY = self.player.y - (2 * TILE_HEIGHT + MAP_OFFSET_TOP + TILE_HEIGHT) - self.player.hitbox.height
        playerY = MAP_OFFSET_TOP + MAP_HEIGHT * TILE_HEIGHT - TILE_HEIGHT -
                      (math.abs(self.player.hitbox.y - self.player.y) + self.player.hitbox.height)
    end

    Timer.tween(1, {
        [self] = {
            cameraX = shiftingX,
            cameraY = shiftingY
        },
        [self.player] = {
            x = playerShiftingX,
            y = playerShiftingY
        }
    }):finish(function()
        self.cameraX = 0
        self.cameraY = 0
        self.isShiftingPlayer = false

        self.currentRoom = self.nextRoom
        self.nextRoom = nil

        self.currentRoom.shiftingX = 0
        self.currentRoom.shiftingY = 0

        -- shift player immediately
        if shiftingX > 0 then
            -- shift player from right gateway to the left gateway
            self.player.x = playerX
        elseif shiftingX < 0 then
            -- shift player from left gateway to the right gateway
            self.player.x = playerX
        elseif shiftingY > 0 then
            -- shift player from bottom gateway to the top gateway
            self.player.y = playerY
        elseif shiftingY < 0 then
            -- shifting player from top gateway to the bottom gateway
            self.player.y = playerY
        end

        for i, gateway in pairs(self.currentRoom.gateways) do
            gateway:close()
        end
    end)
end

function Dungeon:render()
    if self.isShiftingPlayer then
        love.graphics.translate(-math.floor(self.cameraX), -math.floor(self.cameraY))
    end

    self.currentRoom:render()

    if self.nextRoom then
        self.nextRoom:render()
    end
end
