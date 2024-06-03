MushroomChasingState = BaseState()

function MushroomChasingState:init(mushroom, mainCharacter)
    self.mushroom = mushroom
    self.mainCharacter = mainCharacter
    self.animation = Animation({
        frames = {1, 2},
        interval = 0.15
    })

    self.mushroom.currentAnimation = self.animation
end

function MushroomChasingState:enter(params)
end

function MushroomChasingState:update(deltaTime)
    self.mushroom.currentAnimation:update(deltaTime)

    -- check if main player is out of chasing range of entity
    if math.floor(math.abs(self.mainCharacter.x - self.mushroom.x) / TILE_WIDTH) > MUSHROOM_CHASING_WIDTH_RANGE then
        self.mushroom:changeState("moving")
    end

    -- force entity to run into main player
    if self.mushroom.x < self.mainCharacter.x then
        self.mushroom.direction = "right"
        self.mushroom.x = self.mushroom.x + MUSHROOM_CHASING_SPEED * deltaTime
        -- check for collision with any solid tile or object
        local rightTile = self.mushroom.tilesMap:getTileFromPosition(self.mushroom.x + self.mushroom.width,
            self.mushroom.y)
        local bottomRightTile = self.mushroom.tilesMap:getTileFromPosition(self.mushroom.x + self.mushroom.width,
            self.mushroom.y + self.mushroom.height)

        if bottomRightTile and rightTile and (rightTile:isCollidable() or not bottomRightTile:isCollidable()) then
            -- reset position
            self.mushroom.x = self.mushroom.x - MUSHROOM_CHASING_SPEED * deltaTime
        elseif #self.mushroom:checkObjectCollisions() > 0 then
            -- reset position
            self.mushroom.x = self.mushroom.x - MUSHROOM_CHASING_SPEED * deltaTime
        end
        -- if entity run toward player's position
        -- bound entity position to player's position
        if self.mushroom.x > self.mainCharacter.x then
            self.mushroom.x = self.mainCharacter.x
        end
    elseif self.mushroom.x > self.mainCharacter.x then
        self.mushroom.direction = "left"
        self.mushroom.x = self.mushroom.x - MUSHROOM_CHASING_SPEED * deltaTime
        -- check for collision with any solid tile or object
        local leftTile = self.mushroom.tilesMap:getTileFromPosition(self.mushroom.x, self.mushroom.y)
        local bottomLeftTile = self.mushroom.tilesMap:getTileFromPosition(self.mushroom.x,
            self.mushroom.y + self.mushroom.height)

        if bottomLeftTile and leftTile and (leftTile:isCollidable() or not bottomLeftTile:isCollidable()) then
            -- reset position
            self.mushroom.x = self.mushroom.x + MUSHROOM_CHASING_SPEED * deltaTime
        elseif #self.mushroom:checkObjectCollisions() > 0 then
            -- reset position
            self.mushroom.x = self.mushroom.x + MUSHROOM_CHASING_SPEED * deltaTime
        end
        -- if entity run toward player's position
        -- bound entity position to player's position
        if self.mushroom.x < self.mainCharacter.x then
            self.mushroom.x = self.mainCharacter.x
        end
    end
end

function MushroomChasingState:render()
end
