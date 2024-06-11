PlayerIdleState = BaseState()

function PlayerIdleState:init(player)
    self.player = player
    self.animations = {
        [ENTITY_DIRECTION_VALUES.UP] = Animation({
            frames = self.player.animations[ENTITY_ANIMATION_KEYS.IDLE_UP].frames,
            isLooping = self.player.animations[ENTITY_ANIMATION_KEYS.IDLE_UP].isLooping
        }),
        [ENTITY_DIRECTION_VALUES.DOWN] = Animation({
            frames = self.player.animations[ENTITY_ANIMATION_KEYS.IDLE_DOWN].frames,
            isLooping = self.player.animations[ENTITY_ANIMATION_KEYS.IDLE_DOWN].isLooping
        }),
        [ENTITY_DIRECTION_VALUES.LEFT] = Animation({
            frames = self.player.animations[ENTITY_ANIMATION_KEYS.IDLE_LEFT].frames,
            isLooping = self.player.animations[ENTITY_ANIMATION_KEYS.IDLE_LEFT].isLooping
        }),
        [ENTITY_DIRECTION_VALUES.RIGHT] = Animation({
            frames = self.player.animations[ENTITY_ANIMATION_KEYS.IDLE_RIGHT].frames,
            isLooping = self.player.animations[ENTITY_ANIMATION_KEYS.IDLE_RIGHT].isLooping
        })
    }
end

function PlayerIdleState:enter(params)
    self.player.textureName = TEXTURE_KEYS.PLAYER_WALK
    self.player.quadsName = QUADS_KEYS.PLAYER_WALK

    self.player.currentAnimation = self.animations[self.player.direction]
end

function PlayerIdleState:update(deltaTime)
    self.player.currentAnimation:update(deltaTime)

    if love.keyboard.isDown(KEYBOARD_BUTTON_VALUES.UP) or love.keyboard.isDown(KEYBOARD_BUTTON_VALUES.DOWN) or
        love.keyboard.isDown(KEYBOARD_BUTTON_VALUES.LEFT) or love.keyboard.isDown(KEYBOARD_BUTTON_VALUES.RIGHT) then
        self.player:changeState(ENTITY_STATE_KEYS.MOVING)
    end

    if love.keyboard.wasPressed(KEYBOARD_BUTTON_VALUES.SPACE) then
        self.player:changeState(ENTITY_STATE_KEYS.SWING_SWORD)
    end
end

function PlayerIdleState:render()
end
