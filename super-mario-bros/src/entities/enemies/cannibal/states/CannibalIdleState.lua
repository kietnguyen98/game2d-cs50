CannibalIdleState = BaseState()

function CannibalIdleState:init(cannibal, mainCharacter)
    self.cannibal = cannibal
    self.mainCharacter = mainCharacter
    self.animation = Animation({
        frames = {2},
        interval = 1
    })

    self.cannibal.currentAnimation = self.animation
end

function CannibalIdleState:enter(params)
end

function CannibalIdleState:update(deltaTime)
    self.cannibal.currentAnimation:update(deltaTime)

    -- if main player enter entity attack range and not in immortal state
    if (math.floor(math.abs(self.mainCharacter.x - self.cannibal.x) / TILE_WIDTH) <= CANNIBAL_ATTACK_WIDTH_RANGE) and
        not self.mainCharacter.isImmortal then
        self.cannibal:changeState("attack")
    end
end

function CannibalIdleState:render()
end
