GamePlayState = BaseState()

function GamePlayState:init()
    self.player = Player({
        x = VIRTUAL_WIDTH / 2,
        y = VIRTUAL_HEIGHT / 2,
        health = PLAYER_MAX_HEALTH,
        movingSpeed = ENTITY_DEFINITIONS[ENTITY_NAME_KEYS.PLAYER].movingSpeed,
        animations = ENTITY_DEFINITIONS[ENTITY_NAME_KEYS.PLAYER].animations,
        hitbox = ENTITY_DEFINITIONS[ENTITY_NAME_KEYS.PLAYER].hitbox
    })

    self.dungeon = Dungeon(self.player)

    self.player.stateMachine = StateMachine({
        [ENTITY_STATE_KEYS.IDLE] = function()
            return PlayerIdleState(self.player)
        end,
        [ENTITY_STATE_KEYS.MOVING] = function()
            return PlayerMovingState(self.player, self.dungeon)
        end,
        [ENTITY_STATE_KEYS.SWING_SWORD] = function()
            return PlayerSwingSwordState(self.player, self.dungeon)
        end
    })

    self.player:changeState(ENTITY_STATE_KEYS.IDLE)
end

function GamePlayState:enter(params)
end

function GamePlayState:update(deltaTime)
    Timer.update(deltaTime)
    self.dungeon:update(deltaTime)

    -- render hit box if press ` key
    if love.keyboard.wasPressed(KEYBOARD_BUTTON_VALUES.BACK_TICK) then
        -- render player hitbox
        self.player:toggleHitbox()
        -- render entity hitbox
        for i, enemy in pairs(self.dungeon.currentRoom.enemies) do
            enemy:toggleHitbox()
        end
        -- render object hitbox
        for i, object in pairs(self.dungeon.currentRoom.objects) do
            object:toggleHitbox()
        end
    end
end

function GamePlayState:renderPlayerHealth()
    local HEART_INDEX = {
        ['FULL'] = 5,
        ['BLANK'] = 1
    }

    local x = MAP_OFFSET_LEFT
    local y = 12

    for i = 1, PLAYER_MAX_HEALTH do
        love.graphics.draw(gameTextures[TEXTURE_KEYS.HEARTS], gameQuads[QUADS_KEYS.HEARTS][i <= self.player.health and
            HEART_INDEX.FULL or HEART_INDEX.BLANK], x, y, 0, HEART_SCALE_RATIO, HEART_SCALE_RATIO)
        x = x + HEART_WIDTH * HEART_SCALE_RATIO + 2
    end
end

function GamePlayState:render()
    self.dungeon:render()
    self:renderPlayerHealth()
end
