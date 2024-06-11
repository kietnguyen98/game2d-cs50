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

function PlayerSwingSwordState:initPlayerOffset()
    self.player.offsetX = (PLAYER_SWING_SWORD_WIDTH - PLAYER_WALK_WIDTH) / 2
    self.player.offsetY = (PLAYER_SWING_SWORD_HEIGHT - PLAYER_WALK_HEIGHT) / 2
end

function PlayerSwingSwordState:clearPlayerOffset()
    self.player.offsetX = 0
    self.player.offsetY = 0
end

function PlayerSwingSwordState:enter(params)
    self.player.textureName = TEXTURE_KEYS.PLAYER_SWING_SWORD
    self.player.quadsName = QUADS_KEYS.PLAYER_SWING_SWORD

    self.player.currentAnimation = self.animations[self.player.direction]
    self:initPlayerOffset()
end

function PlayerSwingSwordState:update(deltaTime)
    self.player.currentAnimation:update(deltaTime)

    if love.keyboard.isDown(KEYBOARD_BUTTON_VALUES.SPACE) then
        if self.player.currentAnimation.timePlayed > 0 then
            self.player.currentAnimation:refresh()
        end
    end

    if self.player.currentAnimation.timePlayed > 0 then
        self.player.currentAnimation:refresh()
        self:clearPlayerOffset()
        self.player:changeState(ENTITY_STATE_KEYS.IDLE)
    end
end

function PlayerSwingSwordState:render()
end
