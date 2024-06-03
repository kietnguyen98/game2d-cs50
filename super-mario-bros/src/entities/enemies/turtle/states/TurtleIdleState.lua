TurtleIdleState = BaseState()

function TurtleIdleState:init(turtle, mainCharacter)
    self.turtle = turtle
    self.mainCharacter = mainCharacter
    self.animation = Animation({
        frames = {1},
        interval = 1
    })

    self.turtle.currentAnimation = self.animation
end

function TurtleIdleState:enter(params)
    self.idleTimer = 0
    self.idleDuration = math.random(1, 3)
end

function TurtleIdleState:update(deltaTime)
    self.turtle.currentAnimation:update(deltaTime)
    -- update timer
    self.idleTimer = self.idleTimer + deltaTime

    -- wait for a period then turn in to moving state
    if self.idleTimer > self.idleDuration then
        -- if main player is nearby then should switch state to chasing
        if math.floor(math.abs(self.turtle.x - self.mainCharacter.x) / TILE_WIDTH) <= TURTLE_CHASING_WIDTH_RANGE then
            self.turtle:changeState("chasing")
        end
        -- change state to moving
        -- select a random direction for moving
        self.turtle.direction = math.random(2) == 1 and "left" or "right"
        self.turtle:changeState("moving")
    end
end

function TurtleIdleState:render()
end
