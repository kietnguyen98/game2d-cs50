MainCharacterJumpingState = BaseState:extend()

function MainCharacterJumpingState:init(player)
    self.player = player

    self.animation = Animation({
        frames = {3},
        interval = 1
    })

    -- should set idle as default state when init main character
    self.player.currentAnimation = self.animation
end

function MainCharacterJumpingState:enter()
    self.player.dy = JUMP_VELOCITY
end

function MainCharacterJumpingState:exit()
end

function MainCharacterJumpingState:update(deltaTime)
    self.player.currentAnimation:update(deltaTime)

    -- update character position on jumping  
    self.player.dy = self.player.dy + GRAVITY
    self.player.y = self.player.y + self.player.dy * deltaTime

    -- change player state to falling when on top of jumping state
    if self.player.dy > 0 then
        self.player:changeState("falling")
    end

    -- continue moving when player is still Jumping
    if love.keyboard.isDown("left") then
        self.player:moveLeft(deltaTime)
    elseif love.keyboard.isDown("right") then
        self.player:moveRight(deltaTime)
    end

    if self.player.dy == 0 then
        self.player:changeState("idle")
    end
end

function MainCharacterJumpingState:render()
end
