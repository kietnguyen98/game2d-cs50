MushroomMovingState = BaseState()

function MushroomMovingState:init(mushroom, mainCharacter)
    self.mushroom = mushroom
    self.mainCharacter = mainCharacter
    self.animation = Animation({
        frames = {1, 2},
        interval = 0.25
    })

    self.mushroom.currentAnimation = self.animation
end

function MushroomMovingState:enter(params)
    self.movingTimer = 0
    self.movingDuration = math.random(2, 4)
end

function MushroomMovingState:update(deltaTime)
    self.mushroom.currentAnimation:update(deltaTime)

    -- check if main player are in chasing range of entity and not in immortal state
    -- then turn entity to chasing state
    if (math.floor(math.abs(self.mainCharacter.x - self.mushroom.x) / 16) <= MUSHROOM_CHASING_WIDTH_RANGE) and
        not self.mainCharacter.isImmortal then
        self.mushroom:changeState("chasing")
    end

    if self.mushroom.direction == "left" then
        -- update position first
        self.mushroom.x = self.mushroom.x - MUSHROOM_MOVING_SPEED * deltaTime

        -- check for any solid object or chasm on the left of the entity
        local leftTile = self.mushroom.tilesMap:getTileFromPosition(self.mushroom.x, self.mushroom.y)
        local bottomLeftTile = self.mushroom.tilesMap:getTileFromPosition(self.mushroom.x,
            self.mushroom.y + self.mushroom.height)

        if leftTile and bottomLeftTile and (leftTile:isCollidable() or not bottomLeftTile:isCollidable()) then
            -- reset position
            self.mushroom.x = self.mushroom.x + MUSHROOM_MOVING_SPEED * deltaTime
            -- reset moving timer, switch direction
            self.movingTimer = 0
            self.mushroom.direction = "right"
        elseif self.mushroom.x < 0 then
            -- reset position
            self.mushroom.x = 0
            -- reset moving timer, switch direction
            self.movingTimer = 0
            self.mushroom.direction = "right"
        elseif #self.mushroom:checkObjectCollisions() > 0 then
            -- reset position
            self.mushroom.x = self.mushroom.x + MUSHROOM_MOVING_SPEED * deltaTime
            -- reset moving timer, switch direction
            self.movingTimer = 0
            self.mushroom.direction = "right"
        end
    elseif self.mushroom.direction == "right" then
        -- update position first
        self.mushroom.x = self.mushroom.x + MUSHROOM_MOVING_SPEED * deltaTime

        -- check for any solid object or chasm on the left of the entity
        local rightTile = self.mushroom.tilesMap:getTileFromPosition(self.mushroom.x + self.mushroom.width,
            self.mushroom.y)
        local bottomRightTile = self.mushroom.tilesMap:getTileFromPosition(self.mushroom.x + self.mushroom.width,
            self.mushroom.y + self.mushroom.height)

        if bottomRightTile and rightTile and (rightTile:isCollidable() or not bottomRightTile:isCollidable()) then
            -- reset position
            self.mushroom.x = self.mushroom.x - MUSHROOM_MOVING_SPEED * deltaTime
            -- reset moving timer, switch direction
            self.movingTimer = 0
            self.mushroom.direction = "left"
        elseif self.mushroom.x > (self.mushroom.tilesMap.width - 1) * TILE_WIDTH - self.mushroom.width then
            -- reset position
            self.mushroom.x = (self.mushroom.tilesMap.width - 1) * TILE_WIDTH - self.mushroom.width
            -- reset moving timer, switch direction
            self.movingTimer = 0
            self.mushroom.direction = "left"
        elseif #self.mushroom:checkObjectCollisions() > 0 then
            -- reset position
            self.mushroom.x = self.mushroom.x - MUSHROOM_MOVING_SPEED * deltaTime
            -- reset moving timer, switch direction
            self.movingTimer = 0
            self.mushroom.direction = "left"
        end
    else
        self.mushroom:changeState("idle")
    end
end

function MushroomMovingState:render()
end
