EntityMovingState = BaseState()

function EntityMovingState:init(entity)
    self.entity = entity
    self.animations = {
        [ENTITY_DIRECTION_VALUES.UP] = Animation({
            frames = self.entity.animations[ENTITY_ANIMATION_KEYS.WALK_UP].frames,
            interval = self.entity.animations[ENTITY_ANIMATION_KEYS.WALK_UP].interval,
            isLooping = self.entity.animations[ENTITY_ANIMATION_KEYS.WALK_UP].isLooping
        }),
        [ENTITY_DIRECTION_VALUES.DOWN] = Animation({
            frames = self.entity.animations[ENTITY_ANIMATION_KEYS.WALK_DOWN].frames,
            interval = self.entity.animations[ENTITY_ANIMATION_KEYS.WALK_DOWN].interval,
            isLooping = self.entity.animations[ENTITY_ANIMATION_KEYS.WALK_DOWN].isLooping
        }),
        [ENTITY_DIRECTION_VALUES.LEFT] = Animation({
            frames = self.entity.animations[ENTITY_ANIMATION_KEYS.WALK_LEFT].frames,
            interval = self.entity.animations[ENTITY_ANIMATION_KEYS.WALK_LEFT].interval,
            isLooping = self.entity.animations[ENTITY_ANIMATION_KEYS.WALK_LEFT].isLooping
        }),
        [ENTITY_DIRECTION_VALUES.RIGHT] = Animation({
            frames = self.entity.animations[ENTITY_ANIMATION_KEYS.WALK_RIGHT].frames,
            interval = self.entity.animations[ENTITY_ANIMATION_KEYS.WALK_RIGHT].interval,
            isLooping = self.entity.animations[ENTITY_ANIMATION_KEYS.WALK_RIGHT].isLooping
        })
    }
end

function EntityMovingState:enter(params)
    self.timer = 0
    self.movingDuration = math.random(2, 4)
    self.entity.currentAnimation = self.animations[self.entity.direction]
end

function EntityMovingState:update(deltaTime)
    self.entity.currentAnimation:update(deltaTime)

    self.timer = self.timer + deltaTime
    if self.timer > self.movingDuration then
        local directions = {ENTITY_DIRECTION_VALUES.UP, ENTITY_DIRECTION_VALUES.DOWN, ENTITY_DIRECTION_VALUES.LEFT,
                            ENTITY_DIRECTION_VALUES.RIGHT}

        for k, v in pairs(directions) do
            if v == self.entity.direction then
                table.remove(directions, k)
            end
        end

        self.entity.direction = directions[math.random(#directions)]
        self.entity.currentAnimation = self.animations[self.entity.direction]
        self.timer = 0
        self.movingDuration = math.random(2, 4)
    end

    -- move the entity
    if self.entity.direction == ENTITY_DIRECTION_VALUES.UP then
        self.entity.y = self.entity.y - self.entity.movingSpeed * deltaTime
        if self.entity:checkWallCollisions() then
            -- reset position
            self.entity.y = self.entity.y + self.entity.movingSpeed * deltaTime
            -- reverse direction
            self.entity.direction = ENTITY_DIRECTION_VALUES.DOWN
            -- update new animation
            self.entity.currentAnimation = self.animations[self.entity.direction]
        end
    elseif self.entity.direction == ENTITY_DIRECTION_VALUES.DOWN then
        self.entity.y = self.entity.y + self.entity.movingSpeed * deltaTime
        if self.entity:checkWallCollisions() then
            -- reset position
            self.entity.y = self.entity.y - self.entity.movingSpeed * deltaTime
            -- reverse direction
            self.entity.direction = ENTITY_DIRECTION_VALUES.UP
            -- update new animation
            self.entity.currentAnimation = self.animations[self.entity.direction]
        end
    elseif self.entity.direction == ENTITY_DIRECTION_VALUES.LEFT then
        self.entity.x = self.entity.x - self.entity.movingSpeed * deltaTime
        if self.entity:checkWallCollisions() then
            -- reset position
            self.entity.x = self.entity.x + self.entity.movingSpeed * deltaTime
            -- reverse direction
            self.entity.direction = ENTITY_DIRECTION_VALUES.RIGHT
            -- update new animation
            self.entity.currentAnimation = self.animations[self.entity.direction]
        end
    elseif self.entity.direction == ENTITY_DIRECTION_VALUES.RIGHT then
        self.entity.x = self.entity.x + self.entity.movingSpeed * deltaTime
        if self.entity:checkWallCollisions() then
            -- reset position
            self.entity.x = self.entity.x - self.entity.movingSpeed * deltaTime
            -- reverse direction
            self.entity.direction = ENTITY_DIRECTION_VALUES.LEFT
            -- update new animation
            self.entity.currentAnimation = self.animations[self.entity.direction]
        end
    end
end

function EntityMovingState:render()
end
