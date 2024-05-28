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
end

function MainCharacterFallingState:exit()
end

function MainCharacterFallingState:update(deltaTime)
    self.player.currentAnimation:update(deltaTime)
    self.player.dy = self.player.dy + GRAVITY
    self.player.y = self.player.y + (self.player.dy * deltaTime)

    -- check for any tiles below character with can stop character from falling
    local diffFromPlayerAndTileInWidth = (self.player.width - TILE_WIDTH) / 2
    local tileBottomLeft = self.player.tilesMap:getTileFromPosition(self.player.x + diffFromPlayerAndTileInWidth + 3,
        self.player.y + self.player.height)
    local tileBottomRight = self.player.tilesMap:getTileFromPosition(
        self.player.x + self.player.width - diffFromPlayerAndTileInWidth - 3, self.player.y + self.player.height)

    -- if any tiles beneath player exist and it is solid, stop the player from falling
    if (tileBottomLeft and tileBottomLeft:isCollidable()) or (tileBottomRight and tileBottomRight:isCollidable()) then
        -- stop falling
        self.player.dy = 0

        if tileBottomLeft then
            self.player.y = (tileBottomLeft.y - 1) * TILE_HEIGHT - self.player.height
        else
            self.player.y = (tileBottomRight.y - 1) * TILE_HEIGHT - self.player.height
        end

        -- change state base on user input
        if love.keyboard.isDown("left") or love.keyboard:isDown("right") then
            self.player:changeState("moving")
        else
            self.player:changeState("idle")
        end

        -- else: continue moving when player is still falling 
        -- and keep checking for collision left and right

    elseif self.player.y > (self.player.tilesMap.height + 1) * TILE_HEIGHT then
        gameStateMachine:change("start")
    elseif love.keyboard.isDown("left") then
        self.player:moveLeft(deltaTime)
    elseif love.keyboard.isDown("right") then
        self.player:moveRight(deltaTime)
    end
end

function MainCharacterFallingState:render()
end
