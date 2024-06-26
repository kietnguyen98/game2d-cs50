PlayerSwingSwordState = BaseState()

function PlayerSwingSwordState:init(player, dungeon)
    self.player = player
    self.dungeon = dungeon
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
    self.swordHitbox = {
        [ENTITY_DIRECTION_VALUES.UP] = Hitbox({
            x = self.player.x,
            y = self.player.y + 5,
            width = 16,
            height = 3
        }),
        [ENTITY_DIRECTION_VALUES.DOWN] = Hitbox({
            x = self.player.x,
            y = self.player.y + PLAYER_SWING_SWORD_HEIGHT - 9,
            width = 14,
            height = 8
        }),
        [ENTITY_DIRECTION_VALUES.LEFT] = Hitbox({
            x = self.player.x - 8,
            y = self.player.y + 9,
            width = 8,
            height = 18
        }),
        [ENTITY_DIRECTION_VALUES.RIGHT] = Hitbox({
            x = self.player.x + PLAYER_WALK_WIDTH - 3,
            y = self.player.y + 10,
            width = 8,
            height = 17
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

    -- check for sword collide with any enemy
    for i, enemy in pairs(self.dungeon.currentRoom.enemies) do
        if not enemy.isDead and enemy:collides(self.swordHitbox[self.player.direction]) then
            enemy.isDead = true
        end
    end
end

function PlayerSwingSwordState:render()
    -- render Hitbox for debugging only
    if self.player.renderHitbox then
        local swordHitbox = self.swordHitbox[self.player.direction]
        love.graphics.setColor(255 / 255, 0, 0, 255)
        love.graphics.rectangle('line', swordHitbox.x, swordHitbox.y, swordHitbox.width, swordHitbox.height)
        love.graphics.setColor(255, 255, 255, 255)
    end
end
