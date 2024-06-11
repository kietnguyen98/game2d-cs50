EntityIdleState = BaseState()

function EntityIdleState:init(entity, waitDuration)
    self.entity = entity
    self.animations = {
        [ENTITY_DIRECTION_VALUES.UP] = Animation({
            frames = self.entity.animations[ENTITY_ANIMATION_KEYS.IDLE_UP].frames,
            isLooping = self.entity.animations[ENTITY_ANIMATION_KEYS.IDLE_UP].isLooping
        }),
        [ENTITY_DIRECTION_VALUES.DOWN] = Animation({
            frames = self.entity.animations[ENTITY_ANIMATION_KEYS.IDLE_DOWN].frames,
            isLooping = self.entity.animations[ENTITY_ANIMATION_KEYS.IDLE_DOWN].isLooping
        }),
        [ENTITY_DIRECTION_VALUES.LEFT] = Animation({
            frames = self.entity.animations[ENTITY_ANIMATION_KEYS.IDLE_LEFT].frames,
            isLooping = self.entity.animations[ENTITY_ANIMATION_KEYS.IDLE_LEFT].isLooping
        }),
        [ENTITY_DIRECTION_VALUES.RIGHT] = Animation({
            frames = self.entity.animations[ENTITY_ANIMATION_KEYS.IDLE_RIGHT].frames,
            isLooping = self.entity.animations[ENTITY_ANIMATION_KEYS.IDLE_RIGHT].isLooping
        })
    }
    self.timer = 0
    self.waitDuration = waitDuration or 0
end

function EntityIdleState:enter(params)
    self.entity.currentAnimation = self.animations[self.entity.direction]
end

function EntityIdleState:update(deltaTime)
    self.entity.currentAnimation:update(deltaTime)

    local directions = {ENTITY_DIRECTION_VALUES.UP, ENTITY_DIRECTION_VALUES.DOWN, ENTITY_DIRECTION_VALUES.LEFT,
                        ENTITY_DIRECTION_VALUES.RIGHT}

    if self.waitDuration > 0 then
        self.timer = self.timer + deltaTime
        if self.timer > self.waitDuration then

            self.entity.direction = directions[math.random(#directions)]
            self.entity:changeState(ENTITY_STATE_KEYS.MOVING)
        end
    else
        self.entity.direction = directions[math.random(#directions)]
        self.entity:changeState(ENTITY_STATE_KEYS.MOVING)
    end
end

function EntityIdleState:render()
end
