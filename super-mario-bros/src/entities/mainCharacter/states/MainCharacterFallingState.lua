MainCharacterFallingState = BaseState:extend()

function MainCharacterFallingState:init(player)
    self.player = player

    self.animation = Animation({
        frames = {3},
        interval = 1
    })

    -- should set idle as default state when init main character
    self.player.currentAnimation = self.animation
end

function MainCharacterFallingState:enter()
    self.player.dy = 0
end

function MainCharacterFallingState:exit()
end

function MainCharacterFallingState:update(deltaTime)
    self.player.currentAnimation:update(deltaTime)
    self.player.dy = self.player.dy + GRAVITY
    self.player.y = self.player.y + (self.player.dy * deltaTime)

    -- check for any tiles below character with can stop character from falling
    local tileBottomLeft = self.player.tilesMap:getTileFromPosition(self.player.x + 1,
        self.player.y + self.player.height)
    local tileBottomRight = self.player.tilesMap:getTileFromPosition(self.player.x + self.player.width - 1,
        self.player.y + self.player.height)

    -- if any tiles beneath player exist and it is solid, stop the player from falling
    if (tileBottomLeft and tileBottomRight) and (tileBottomLeft:isCollidable() or tileBottomRight:isCollidable()) then
        -- stop falling
        self.player.dy = 0

        -- change state base on user input
        if love.keyboard.isDown("left") or love.keyboard:isDown("right") then
            self.player:changeState("moving")
        else
            self.player:changeState("idle")
        end

        -- place player on top to the collides tile
        if tileBottomLeft then
            self.player.y = (tileBottomLeft.y - 1) * TILE_HEIGHT - self.player.height
        elseif tileBottomRight then
            self.player.y = (tileBottomRight.y - 1) * TILE_HEIGHT - self.player.height
        end

        -- else: continue moving when player is still falling 
        -- and keep checking for collision left and right
    elseif love.keyboard.isDown("left") then
        self.player:moveLeft(deltaTime)
    elseif love.keyboard.isDown("right") then
        self.player:moveRight(deltaTime)
    elseif self.player.y > VIRTUAL_HEIGHT then
        -- fallout and die
        gameStateMachine:change("start")
    end

    -- check if collide with any game object and stay on top of that object
    for k, object in pairs(self.player.objects) do
        if object:collides(self.player) then
            if object.solid then
                -- stop falling an put the player just on top the object
                self.player.y = object.y - self.player.height
                -- check user input to change state
                if love.keyboard.isDown("left") or love.keyboard.isDown("right") then
                    self.player:changeState("moving")
                else
                    self.player:changeState("idle")
                end
                -- consume object if object is consumable
            elseif object.consumable then
                table.remove(self.player.objects, k)
            end
        end
    end
end

function MainCharacterFallingState:render()
end
