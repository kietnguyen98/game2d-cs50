MainCharacterMovingState = BaseState:extend()

function MainCharacterMovingState:init(entity)
    self.player = entity

    self.animation = Animation({
        frames = {5, 6, 7, 6},
        interval = 0.12
    })

    -- should set idle as default state when init main character
    self.player.currentAnimation = self.animation
end

function MainCharacterMovingState:enter()
end

function MainCharacterMovingState:exit()
end

function MainCharacterMovingState:update(deltaTime)
    self.player.currentAnimation:update(deltaTime)

    if not love.keyboard.isDown("left") and not love.keyboard.isDown("right") then
        self.player:changeState("idle")
    elseif love.keyboard.isDown("left") then
        self.player:moveLeft(deltaTime)
    elseif love.keyboard.isDown("right") then
        self.player:moveRight(deltaTime)
    end

    if love.keyboard.wasPressed("space") then
        self.player:changeState("jumping")
    end
end

function MainCharacterMovingState:render()
end
