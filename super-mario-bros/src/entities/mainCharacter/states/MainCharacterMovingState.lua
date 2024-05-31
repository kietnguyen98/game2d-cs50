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
        local tileBottomLeft = self.player.tilesMap:getTileFromPosition(self.player.x + 1,
            self.player.y + self.player.height)
        local tileBottomRight = self.player.tilesMap:getTileFromPosition(self.player.x + self.player.width - 1,
            self.player.y + self.player.height)

        -- should check for player is collide with any game object
        -- shift player down then check and then reset player position
        -- player is just above of the object/tiles then if we dont shift player down 1px 
        -- we just cant use AABB to check for collision
        self.player.y = self.player.y + 1
        local collideObjects = self.player:checkObjectCollisions()
        self.player.y = self.player.y - 1

        if #collideObjects == 0 and (tileBottomLeft and not tileBottomLeft:isCollidable()) and
            (tileBottomRight and not tileBottomRight:isCollidable()) then
            -- if there is no solid object and no tiles beneath main player 
            -- the player should fall down
            self.player:changeState("falling")
            -- if there is a solid object or a tile beneath main player
            -- should keep player moving state and check for what direction player will move 
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
