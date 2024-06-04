CannibalAttackState = BaseState()

function CannibalAttackState:init(cannibal, mainCharacter)
    self.cannibal = cannibal
    self.mainCharacter = mainCharacter
    self.animation = Animation({
        frames = {1, 2},
        interval = 0.2
    })

    self.cannibal.currentAnimation = self.animation
end

function CannibalAttackState:enter(params)
end

function CannibalAttackState:update(deltaTime)
    self.cannibal.currentAnimation:update(deltaTime)

    -- if main player leave entity attack range or main player is immortal
    if (math.floor(math.abs(self.mainCharacter.x - self.cannibal.x) / TILE_WIDTH) > CANNIBAL_ATTACK_WIDTH_RANGE) or
        self.mainCharacter.isImmortal then
        self.cannibal:changeState("idle")
    end
end

function CannibalAttackState:render()
end
