TurtleShrinkState = BaseState()

function TurtleShrinkState:init(turtle, mainCharacter)
    self.turtle = turtle
    self.mainCharacter = mainCharacter
    self.animation = Animation({
        frames = {6},
        interval = 1
    })
    self.turtle.currentAnimation = self.animation
end

function TurtleShrinkState:enter(params)
    self.turtle.width = TURTLE_SHRINK_WIDTH * self.turtle.scaleRatio
    self.turtle.height = TURTLE_SHRINK_HEIGHT * self.turtle.scaleRatio
    self.turtle.y = (SKY_MAX_INDEX - 1) * TILE_HEIGHT - self.turtle.height
    self.turtle.consumable = true
end

function TurtleShrinkState:update(deltaTime)
    self.turtle.currentAnimation:update()
end

function TurtleShrinkState:render()
end