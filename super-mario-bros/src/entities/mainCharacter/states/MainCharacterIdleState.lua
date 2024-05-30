MainCharacterIdleState = BaseState:extend()

function MainCharacterIdleState:init(player)
    self.player = player

    self.animation = Animation({
        frames = {1},
        interval = 1
    })

    -- should set idle as default state when init main character
    self.player.currentAnimation = self.animation
end

function MainCharacterIdleState:enter()
end

function MainCharacterIdleState:exit()
end

function MainCharacterIdleState:update(deltaTime)

    self.player.currentAnimation:update(deltaTime)

    if love.keyboard.isDown("left") or love.keyboard.isDown("right") then
        self.player:changeState("moving")
    elseif love.keyboard.wasPressed("space") then
        self.player:changeState("jumping")
    end

end

function MainCharacterIdleState:render()
end
