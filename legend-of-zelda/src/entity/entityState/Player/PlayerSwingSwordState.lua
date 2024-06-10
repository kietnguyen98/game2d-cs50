PlayerSwingSwordState = BaseState()

function PlayerSwingSwordState:init(player)
    self.player = player
    self.animations = {
        [ENTITY_DIRECTION_VALUES.UP] = Animation({
            frames = self.player.animations[ENTITY_ANIMATION_KEYS.SWING_SWORD_UP].frames,
            interval = self.player.animations[ENTITY_ANIMATION_KEYS.SWING_SWORD_UP].interval,
            isLooping = self.player.animations[ENTITY_ANIMATION_KEYS.SWING_SWORD_UP].isLooping
        }),
        [ENTITY_DIRECTION_VALUES.DOWN] = Animation({
            frames = self.player.animations[ENTITY_ANIMATION_KEYS.SWING_SWORD_DOWN].frames,
            interval = self.player.animations[ENTITY_ANIMATION_KEYS.SWING_SWORD_DOWN].interval,
            isLooping = self.player.animations[ENTITY_ANIMATION_KEYS.SWING_SWORD_DOWN].isLooping
        }),
        [ENTITY_DIRECTION_VALUES.LEFT] = Animation({
            frames = self.player.animations[ENTITY_ANIMATION_KEYS.SWING_SWORD_LEFT].frames,
            interval = self.player.animations[ENTITY_ANIMATION_KEYS.SWING_SWORD_LEFT].interval,
            isLooping = self.player.animations[ENTITY_ANIMATION_KEYS.SWING_SWORD_LEFT].isLooping
        }),
        [ENTITY_DIRECTION_VALUES.RIGHT] = Animation({
            frames = self.player.animations[ENTITY_ANIMATION_KEYS.SWING_SWORD_RIGHT].frames,
            interval = self.player.animations[ENTITY_ANIMATION_KEYS.SWING_SWORD_RIGHT].interval,
            isLooping = self.player.animations[ENTITY_ANIMATION_KEYS.SWING_SWORD_RIGHT].isLooping
        })
    }
end

function PlayerSwingSwordState:enter(params)
    self.player.textureName = PLAYER_TEXTURE_KEYS.SWING_SWORD
    self.player.quadsName = PLAYER_QUADS_KEYS.SWING_SWORD

    self.player.currentAnimation = self.animations[self.player.direction]
end

function PlayerSwingSwordState:update(deltaTime)
    self.player.currentAnimation:update(deltaTime)

    if self.player.currentAnimation.timePlayed > 0 then
        self.player.currentAnimation.timePlayed = 0
        print("change to idle")
        self.player:changeState(ENTITY_STATE_KEYS.IDLE)
    end

    if love.keyboard.wasPressed(KEYBOARD_BUTTON_VALUES.SPACE) then
        self.player:changeState(ENTITY_STATE_KEYS.SWING_SWORD)
    end
end

function PlayerSwingSwordState:render()
end
