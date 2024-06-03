TurtleChasingState = BaseState()

function TurtleChasingState:init(turtle, mainCharacter)
    self.turtle = turtle
    self.mainCharacter = mainCharacter
    self.animation = Animation({
        frames = {3, 4},
        interval = 0.15
    })

    self.turtle.currentAnimation = self.animation
end

function TurtleChasingState:enter(params)
end

function TurtleChasingState:update(deltaTime)
    self.turtle.currentAnimation:update(deltaTime)

    -- check if main player is out of chasing range of entity
    if math.floor(math.abs(self.mainCharacter.x - self.turtle.x) / TILE_WIDTH) > TURTLE_CHASING_WIDTH_RANGE then
        self.turtle:changeState("moving")
    end

    -- force entity to run into main player
    if self.turtle.x < self.mainCharacter.x then
        self.turtle.direction = "right"
        self.turtle.x = self.turtle.x + TURTLE_CHASING_SPEED * deltaTime
        -- check for collision with any solid tile or object
        local rightTile = self.turtle.tilesMap:getTileFromPosition(self.turtle.x + self.turtle.width, self.turtle.y)
        local bottomRightTile = self.turtle.tilesMap:getTileFromPosition(self.turtle.x + self.turtle.width,
            self.turtle.y + self.turtle.height)

        if bottomRightTile and rightTile and (rightTile:isCollidable() or not bottomRightTile:isCollidable()) then
            -- reset position
            self.turtle.x = self.turtle.x - TURTLE_CHASING_SPEED * deltaTime
        elseif #self.turtle:checkObjectCollisions() > 0 then
            -- reset position
            self.turtle.x = self.turtle.x - TURTLE_CHASING_SPEED * deltaTime
        end
        -- if entity run toward player's position
        -- bound entity position to player's position
        if self.turtle.x > self.mainCharacter.x then
            self.turtle.x = self.mainCharacter.x
        end
    elseif self.turtle.x > self.mainCharacter.x then
        self.turtle.direction = "left"
        self.turtle.x = self.turtle.x - TURTLE_CHASING_SPEED * deltaTime
        -- check for collision with any solid tile or object
        local leftTile = self.turtle.tilesMap:getTileFromPosition(self.turtle.x, self.turtle.y)
        local bottomLeftTile = self.turtle.tilesMap:getTileFromPosition(self.turtle.x,
            self.turtle.y + self.turtle.height)

        if bottomLeftTile and leftTile and (leftTile:isCollidable() or not bottomLeftTile:isCollidable()) then
            -- reset position
            self.turtle.x = self.turtle.x + TURTLE_CHASING_SPEED * deltaTime
        elseif #self.turtle:checkObjectCollisions() > 0 then
            -- reset position
            self.turtle.x = self.turtle.x + TURTLE_CHASING_SPEED * deltaTime
        end
        -- if entity run toward player's position
        -- bound entity position to player's position
        if self.turtle.x < self.mainCharacter.x then
            self.turtle.x = self.mainCharacter.x
        end
    end
end

function TurtleChasingState:render()
end
