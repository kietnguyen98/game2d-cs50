MainCharacterBounceState = BaseState:extend()

function MainCharacterBounceState:init(player)
    self.player = player

    self.bounceBackAnimation = Animation({
        frames = {8},
        interval = 1
    })

    self.bounceForwardAnimation = Animation({
        frames = {10},
        interval = 1
    })

end

function MainCharacterBounceState:enter(params)
    self.bounceVelocity = CHARACTER_BOUNCE_BACK_VELOCITY
    self.player.isHurt = true
    self.enemyDirection = params.enemyDirection
    self.collidedPart = params.collidedPart
end

function MainCharacterBounceState:exit()
end

function MainCharacterBounceState:update(deltaTime)
    -- update player position base on player's direction and enemy's direction
    if self.player.direction == self.enemyDirection then
        self.player.currentAnimation = self.bounceForwardAnimation
    else
        self.player.currentAnimation = self.bounceBackAnimation
    end

    -- update animation immediatly
    self.player.currentAnimation:update(deltaTime)

    -- update player position base on collided part of enemy
    -- bounce player back   
    if self.collidedPart == "left" then
        -- should bounce player to the left
        self.player.x = self.player.x - self.bounceVelocity * deltaTime

        -- check left collisions
        local topLeftTile = self.player.tilesMap:getTileFromPosition(self.player.x + 1, self.player.y + 1)
        local bottomLeftTile = self.player.tilesMap:getTileFromPosition(self.player.x + 1,
            self.player.y + self.player.height - 1)
        if topLeftTile and bottomLeftTile and (topLeftTile:isCollidable() or topLeftTile:isCollidable()) then
            -- collide with tile, reset position
            self.player.x = topLeftTile.x * topLeftTile.width - 1
            -- reset ishurt
            self.player.isHurt = false
            self.player.isImmortal = true
            -- change state base on input
            if love.keyboard.isDown("left") or love.keyboard.isDown("right") then
                self.player:changeState("moving")
            else
                self.player:changeState("idle")
            end
        elseif #self.player:checkObjectCollisions() > 0 then
            -- check for collision with solid object
            self.player.x = self.player.x + self.bounceVelocity * deltaTime
            -- reset ishurt
            self.player.isHurt = false
            self.player.isImmortal = true
            -- change state base on input
            if love.keyboard.isDown("left") or love.keyboard.isDown("right") then
                self.player:changeState("moving")
            else
                self.player:changeState("idle")
            end
        end
    elseif self.collidedPart == "right" then
        -- should bounce player to the right
        self.player.x = self.player.x + self.bounceVelocity * deltaTime
        -- check right collisions
        local topRightTile = self.player.tilesMap:getTileFromPosition(self.player.x + self.player.width - 1,
            self.player.y + 1)
        local bottomRightTile = self.player.tilesMap:getTileFromPosition(self.player.x + self.player.width - 1,
            self.player.y + self.player.height - 1)
        if topRightTile and bottomRightTile and (topRightTile:isCollidable() or bottomRightTile:isCollidable()) then
            -- collide with tile, reset position
            self.player.x = (topRightTile.x - 1) * topRightTile.width - self.player.width
            -- reset ishurt
            self.player.isHurt = false
            self.player.isImmortal = true
            -- change state base on input
            if love.keyboard.isDown("left") or love.keyboard.isDown("right") then
                self.player:changeState("moving")
            else
                self.player:changeState("idle")
            end
        elseif #self.player:checkObjectCollisions() > 0 then
            -- check for collision with solid object
            self.player.x = self.player.x - self.bounceVelocity * deltaTime
            -- reset ishurt
            self.player.isHurt = false
            self.player.isImmortal = true
            -- change state base on input
            if love.keyboard.isDown("left") or love.keyboard.isDown("right") then
                self.player:changeState("moving")
            else
                self.player:changeState("idle")
            end
        end
    end

    -- update bounce velocity
    self.bounceVelocity = self.bounceVelocity - CHARACTER_BOUNCE_BACK_RESISTANCE_VELOCITY
    if self.bounceVelocity < 0 then
        -- reset ishurt
        self.player.isHurt = false
        self.player.isImmortal = true
        -- check if any tiles beneath player
        local tileBottomLeft = self.player.tilesMap:getTileFromPosition(self.player.x + 1,
            self.player.y + self.player.height)
        local tileBottomRight = self.player.tilesMap:getTileFromPosition(self.player.x + self.player.width - 1,
            self.player.y + self.player.height)
        if (tileBottomLeft and tileBottomRight) and
            (not tileBottomLeft:isCollidable() and not tileBottomRight:isCollidable()) then
            self.player:changeState("falling")
        elseif love.keyboard.isDown("left") or love.keyboard.isDown("right") then
            self.player:changeState("moving")
        else
            self.player:changeState("idle")
        end
    end
end

function MainCharacterBounceState:render()
end
