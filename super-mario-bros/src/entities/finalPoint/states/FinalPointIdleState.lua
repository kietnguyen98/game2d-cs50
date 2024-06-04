FinalPointIdleState = BaseState()

function FinalPointIdleState:init(finalPoint, mainCharacter)
    self.finalPoint = finalPoint
    self.mainCharacter = mainCharacter
    self.animation = Animation({
        frames = {1, 2, 3, 4},
        interval = 0.1
    })

    self.finalPoint.currentAnimation = self.animation
end

function FinalPointIdleState:enter(params)
end

function FinalPointIdleState:update(deltaTime)
    self.finalPoint.currentAnimation:update(deltaTime)
end

function FinalPointIdleState:render()
end
