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

function MainCharacterJumpingState:enter(params)
    self.player.dy = (params and params.jumpVelocity) and params.jumpVelocity or CHARACTER_JUMP_VELOCITY
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

    -- check if player collides with any object above the head then should falling down if object is solid
    for k, object in pairs(self.player.objects) do
        if object:collides(self.player) then
            if object.solid then
                -- set the main player to fall down
                self.player.y = object.y + object.height
                self.player:changeState("falling")
                -- if the object is collidable so we can collide it
                if object.collidable then
                    object:onCollide()
                end
            elseif object.consumable then
                object.onConsume()
                table.remove(self.player.objects, k)
            end
        end
    end
end

function MainCharacterJumpingState:render()
end
