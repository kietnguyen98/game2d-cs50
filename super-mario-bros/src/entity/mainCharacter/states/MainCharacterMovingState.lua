MainCharacterMovingState = BaseState:extend()

function MainCharacterMovingState:init(player)
    self.player = player

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

function MainCharacterMovingState:moveLeft(player, deltaTime)
    player.x = player.x - CHARACTER_SPEED * deltaTime
    player.direction = "left"
end

function MainCharacterMovingState:moveRight(player, deltaTime)
    player.x = player.x + CHARACTER_SPEED * deltaTime
    player.direction = "right"
end

function MainCharacterMovingState:update(deltaTime)
    self.player.currentAnimation:update(deltaTime)

    if not love.keyboard.isDown("left") and not love.keyboard.isDown("right") then
        self.player:changeState("idle")
    elseif love.keyboard.isDown("left") then
        self:moveLeft(self.player, deltaTime)
    elseif love.keyboard.isDown("right") then
        self:moveRight(self.player, deltaTime)
    end

    if love.keyboard.wasPressed("space") then
        self.player:changeState("jumping")
    end
end

function MainCharacterMovingState:render()
end
