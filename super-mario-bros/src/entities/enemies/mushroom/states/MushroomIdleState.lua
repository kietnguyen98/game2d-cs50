MushroomIdleState = BaseState()

function MushroomIdleState:init(mushroom, mainCharacter)
    self.mushroom = mushroom
    self.mainCharacter = mainCharacter
    self.animation = Animation({
        frames = {1},
        interval = 1
    })

    self.mushroom.currentAnimation = self.animation
end

function MushroomIdleState:enter(params)
    self.idleTimer = 0
    self.idleDuration = math.random(1, 2)
end

function MushroomIdleState:update(deltaTime)
    self.mushroom.currentAnimation:update(deltaTime)
    -- update timer
    self.idleTimer = self.idleTimer + deltaTime

    -- wait for period then switch to moving state
    if self.idleTimer > self.idleDuration then
        -- check if main player is out of chasing range of entity
        if math.floor(math.abs(self.mainCharacter.x - self.mushroom.x) / TILE_WIDTH) < MUSHROOM_CHASING_WIDTH_RANGE then
            self.mushroom:changeState("chasing")
        end
        -- change state to moving
        -- select a random direction for moving
        self.mushroom.direction = math.random(2) == 1 and "left" or "right"
        self.mushroom:changeState("moving")
    end
end

function MushroomIdleState:render()
end
