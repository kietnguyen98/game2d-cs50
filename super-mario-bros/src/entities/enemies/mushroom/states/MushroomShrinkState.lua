MushroomShrinkState = BaseState()

function MushroomShrinkState:init(mushroom)
    self.mushroom = mushroom
    self.animation = Animation({
        frames = {3},
        interval = 1
    })
    self.mushroom.currentAnimation = self.animation
end

function MushroomShrinkState:enter(params)
    self.mushroom.height = MUSHROOM_SHRINK_HEIGHT * self.mushroom.scaleRatio
    self.mushroom.y = (SKY_MAX_INDEX - 1) * TILE_HEIGHT - self.mushroom.height
end

function MushroomShrinkState:update(deltaTime)
    self.mushroom.currentAnimation:update()
end

function MushroomShrinkState:render()
end
