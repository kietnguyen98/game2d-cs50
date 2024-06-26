PlayerMovingState = BaseState()

function PlayerMovingState:init(player, dungeon)
    self.player = player
    self.dungeon = dungeon
    self.animations = {
        [ENTITY_DIRECTION_VALUES.UP] = Animation({
            frames = self.player.animations[ENTITY_ANIMATION_KEYS.WALK_UP].frames,
            interval = self.player.animations[ENTITY_ANIMATION_KEYS.WALK_UP].interval,
            isLooping = self.player.animations[ENTITY_ANIMATION_KEYS.WALK_UP].isLooping
        }),
        [ENTITY_DIRECTION_VALUES.DOWN] = Animation({
            frames = self.player.animations[ENTITY_ANIMATION_KEYS.WALK_DOWN].frames,
            interval = self.player.animations[ENTITY_ANIMATION_KEYS.WALK_DOWN].interval,
            isLooping = self.player.animations[ENTITY_ANIMATION_KEYS.WALK_DOWN].isLooping
        }),
        [ENTITY_DIRECTION_VALUES.LEFT] = Animation({
            frames = self.player.animations[ENTITY_ANIMATION_KEYS.WALK_LEFT].frames,
            interval = self.player.animations[ENTITY_ANIMATION_KEYS.WALK_LEFT].interval,
            isLooping = self.player.animations[ENTITY_ANIMATION_KEYS.WALK_LEFT].isLooping
        }),
        [ENTITY_DIRECTION_VALUES.RIGHT] = Animation({
            frames = self.player.animations[ENTITY_ANIMATION_KEYS.WALK_RIGHT].frames,
            interval = self.player.animations[ENTITY_ANIMATION_KEYS.WALK_RIGHT].interval,
            isLooping = self.player.animations[ENTITY_ANIMATION_KEYS.WALK_RIGHT].isLooping
        })
    }
end

function PlayerMovingState:enter(params)
    self.player.textureName = TEXTURE_KEYS.PLAYER_WALK
    self.player.quadsName = QUADS_KEYS.PLAYER_WALK
end

function PlayerMovingState:update(deltaTime)
    self.player.currentAnimation:update(deltaTime)

    if love.keyboard.isDown(KEYBOARD_BUTTON_VALUES.UP) then
        self.player.direction = ENTITY_DIRECTION_VALUES.UP
        self.player.currentAnimation = self.animations[ENTITY_DIRECTION_VALUES.UP]
    elseif love.keyboard.isDown(KEYBOARD_BUTTON_VALUES.DOWN) then
        self.player.direction = ENTITY_DIRECTION_VALUES.DOWN
        self.player.currentAnimation = self.animations[ENTITY_DIRECTION_VALUES.DOWN]
    elseif love.keyboard.isDown(KEYBOARD_BUTTON_VALUES.LEFT) then
        self.player.direction = ENTITY_DIRECTION_VALUES.LEFT
        self.player.currentAnimation = self.animations[ENTITY_DIRECTION_VALUES.LEFT]
    elseif love.keyboard.isDown(KEYBOARD_BUTTON_VALUES.RIGHT) then
        self.player.direction = ENTITY_DIRECTION_VALUES.RIGHT
        self.player.currentAnimation = self.animations[ENTITY_DIRECTION_VALUES.RIGHT]
    else
        self.player:changeState(ENTITY_STATE_KEYS.IDLE)
    end

    -- move player
    if self.player.direction == ENTITY_DIRECTION_VALUES.UP then
        self.player.y = self.player.y - self.player.movingSpeed * deltaTime
        -- check for collide with top gateway or wall
        local topGateway = self.dungeon.currentRoom.gateways[GATEWAY_DIRECTION_VALUES.TOP]
        if self.player:collides(topGateway.hitbox) and topGateway.isOpen then
            Event.dispatch(EVENT_NAME_KEYS.SHIFT_PLAYER_UP)
        elseif self.player:checkWallCollisions() then
            -- reset position
            self.player.y = self.player.y + self.player.movingSpeed * deltaTime
        end
    elseif self.player.direction == ENTITY_DIRECTION_VALUES.DOWN then
        self.player.y = self.player.y + self.player.movingSpeed * deltaTime
        -- check for collide with bottom gateway or wall
        local bottomGateway = self.dungeon.currentRoom.gateways[GATEWAY_DIRECTION_VALUES.BOTTOM]
        if self.player:collides(bottomGateway.hitbox) and bottomGateway.isOpen then
            Event.dispatch(EVENT_NAME_KEYS.SHIFT_PLAYER_DOWN)
        elseif self.player:checkWallCollisions() then
            -- reset position
            self.player.y = self.player.y - self.player.movingSpeed * deltaTime
        end
    elseif self.player.direction == ENTITY_DIRECTION_VALUES.LEFT then
        self.player.x = self.player.x - self.player.movingSpeed * deltaTime
        -- check for collide with left gateway or wall
        local leftGateway = self.dungeon.currentRoom.gateways[GATEWAY_DIRECTION_VALUES.LEFT]
        if self.player:collides(leftGateway.hitbox) and leftGateway.isOpen then
            Event.dispatch(EVENT_NAME_KEYS.SHIFT_PLAYER_LEFT)
        elseif self.player:checkWallCollisions() then
            -- reset position
            self.player.x = self.player.x + self.player.movingSpeed * deltaTime
        end
    elseif self.player.direction == ENTITY_DIRECTION_VALUES.RIGHT then
        self.player.x = self.player.x + self.player.movingSpeed * deltaTime
        -- check for collide with right gateway or wall
        local rightGateway = self.dungeon.currentRoom.gateways[GATEWAY_DIRECTION_VALUES.RIGHT]
        if self.player:collides(rightGateway.hitbox) and rightGateway.isOpen then
            Event.dispatch(EVENT_NAME_KEYS.SHIFT_PLAYER_RIGHT)
        elseif self.player:checkWallCollisions() then
            -- reset position
            self.player.x = self.player.x - self.player.movingSpeed * deltaTime
        end
    end

    if love.keyboard.wasPressed(KEYBOARD_BUTTON_VALUES.SPACE) then
        self.player:changeState(ENTITY_STATE_KEYS.SWING_SWORD)
    end
end

function PlayerMovingState:render()
end
