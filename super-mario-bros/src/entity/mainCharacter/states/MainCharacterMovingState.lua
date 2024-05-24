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
    else
        -- should check for any tile under character
        -- if there is not any tile -> character fall
        -- player width = 18
        -- tile width = 16
        local diffFromPlayerAndTileInWidth = (self.player.width - TILE_WIDTH) / 2
        local tileBottomLeft = self.player.tilesMap:getTileFromPosition(
            self.player.x + diffFromPlayerAndTileInWidth + 1, self.player.y + self.player.height)
        local tileBottomRight = self.player.tilesMap:getTileFromPosition(
            self.player.x + self.player.width - diffFromPlayerAndTileInWidth - 1, self.player.y + self.player.height)

        if (tileBottomLeft and not tileBottomLeft:isCollidable()) and
            (tileBottomRight and not tileBottomRight:isCollidable()) then
            self.player:changeState("falling")
        elseif love.keyboard.isDown("left") then
            self.player:moveLeft(deltaTime)
        elseif love.keyboard.isDown("right") then
            self.player:moveRight(deltaTime)
        end
    end

    if love.keyboard.wasPressed("space") then
        self.player:changeState("jumping")
    end
end

function MainCharacterMovingState:render()
end
