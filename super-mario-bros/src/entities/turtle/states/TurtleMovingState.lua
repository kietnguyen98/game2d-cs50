TurtleMovingState = BaseState()

function TurtleMovingState:init(turtle, mainPlayer, tilesMap)
    self.turtle = turtle
    self.tilesMap = tilesMap
    self.mainPlayer = mainPlayer
    self.animation = Animation({
        frames = {1, 2},
        interval = 0.15
    })

    self.movingDuration = math.random(3, 5)
    self.movingTimer = 0

    self.turtle.currentAnimation = self.animation
end

function TurtleMovingState:enter(params)
end

function TurtleMovingState:update(deltaTime)
    self.turtle.currentAnimation:update(deltaTime)

    -- update moving timer
    self.movingTimer = self.movingTimer + deltaTime
    if self.movingTimer > self.movingDuration then
        -- change entity moving direction
        self.turtle.direction = self.turtle.direction == "left" and "right" or "left"
        self.movingTimer = 0
    end

    if self.turtle.direction == "left" then
        -- update position first
        self.turtle.x = self.turtle.x - TURTLE_SPEED * deltaTime

        -- check for any solid object or chasm on the left of the entity
        local leftTile = self.turtle.tilesMap:getTileFromPosition(self.turtle.x, self.turtle.y)
        local bottomLeftTile = self.turtle.tilesMap:getTileFromPosition(self.turtle.x,
            self.turtle.y + self.turtle.height)

        if leftTile and bottomLeftTile and (leftTile:isCollidable() or not bottomLeftTile:isCollidable()) then
            -- reset position
            self.turtle.x = self.turtle.x + TURTLE_SPEED * deltaTime
            -- reset moving timer, switch direction
            self.movingTimer = 0
            self.turtle.direction = "right"
        elseif self.turtle.x < 0 then
            -- reset position
            self.turtle.x = 0
            -- reset moving timer, switch direction
            self.movingTimer = 0
            self.turtle.direction = "right"
        else
            -- check for collisions with any solid object
            local collidedObjects = self.turtle:checkObjectCollisions()
            if #collidedObjects > 0 then
                -- reset position
                self.turtle.x = self.turtle.x + TURTLE_SPEED * deltaTime
                -- reset moving timer, switch direction
                self.movingTimer = 0
                self.turtle.direction = "right"
            end
        end
    elseif self.turtle.direction == "right" then
        -- update position first
        self.turtle.x = self.turtle.x + TURTLE_SPEED * deltaTime

        -- check for any solid object or chasm on the left of the entity
        local rightTile = self.turtle.tilesMap:getTileFromPosition(self.turtle.x + self.turtle.width, self.turtle.y)
        local bottomRightTile = self.turtle.tilesMap:getTileFromPosition(self.turtle.x + self.turtle.width,
            self.turtle.y + self.turtle.height)

        if bottomRightTile and rightTile and (rightTile:isCollidable() or not bottomRightTile:isCollidable()) then
            -- reset position
            self.turtle.x = self.turtle.x - TURTLE_SPEED * deltaTime
            -- reset moving timer, switch direction
            self.movingTimer = 0
            self.turtle.direction = "left"
        elseif self.turtle.x > (self.tilesMap.width - 1) * TILE_WIDTH - self.turtle.width then
            -- reset position
            self.turtle.x = (self.tilesMap.width - 1) * TILE_WIDTH - self.turtle.width
            -- reset moving timer, switch direction
            self.movingTimer = 0
            self.turtle.direction = "left"
        else
            -- check for collisions with any solid object
            local collidedObjects = self.turtle:checkObjectCollisions()
            if #collidedObjects > 0 then
                -- reset position
                self.turtle.x = self.turtle.x - TURTLE_SPEED * deltaTime
                -- reset moving timer, switch direction
                self.movingTimer = 0
                self.turtle.direction = "left"
            end
        end
    else
        self.turtle:changeState("idle")
    end
end

function TurtleMovingState:render()
end
