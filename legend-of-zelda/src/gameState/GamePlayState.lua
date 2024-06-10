GamePlayState = BaseState()

function GamePlayState:init()
    self.dungeon = Dungeon()
    self.player = Player({
        x = VIRTUAL_WIDTH / 2,
        y = VIRTUAL_HEIGHT / 2,
        health = 6,
        movingSpeed = ENTITY_DEFINITIONS.PLAYER.movingSpeed,
        animations = ENTITY_DEFINITIONS.PLAYER.animations
    })

    self.player.stateMachine = StateMachine({
        [ENTITY_STATE_KEYS.IDLE] = function()
            return PlayerIdleState(self.player)
        end,
        [ENTITY_STATE_KEYS.MOVING] = function()
            return PlayerMovingState(self.player)
        end,
        [ENTITY_STATE_KEYS.SWING_SWORD] = function()
            return PlayerSwingSwordState(self.player)
        end
    })

    self.player:changeState(ENTITY_STATE_KEYS.IDLE)
end

function GamePlayState:enter(params)
end

function GamePlayState:update(deltaTime)
    self.dungeon:update(deltaTime)
    self.player:update(deltaTime)
end

function GamePlayState:render()
    self.dungeon:render()
    self.player:render()
end
