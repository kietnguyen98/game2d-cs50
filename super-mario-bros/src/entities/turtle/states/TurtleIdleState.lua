TurtleIdleState = BaseState()

function TurtleIdleState:init(turtle, mainPlayer)
    self.turtle = turtle
    self.mainPlayer = mainPlayer
    self.animation = Animation({
        frames = {1},
        interval = 1
    })

    self.turtle.currentAnimation = self.animation
end

function TurtleIdleState:enter(params)
end

function TurtleIdleState:update(deltaTime)
    self.turtle.currentAnimation:update(deltaTime)
end

function TurtleIdleState:render()
end
