MainCharacterEntity = Entity:extend()

function MainCharacterEntity:init(def)
    self.score = 0
    Entity.init(self, def)
end

function MainCharacterEntity:update(deltaTime)
    Entity.update(self, deltaTime)

    -- constraint main character to not go out of the mapHeight
    if self.x >= self.tilesMap.width * TILE_WIDTH - self.width then
        self.x = self.tilesMap.width * TILE_WIDTH - self.width
    elseif self.x <= 0 then
        self.x = 0
    end

    if #self.enemies > 0 then
        self:checkEnemyCollisions()
    end
end

function MainCharacterEntity:render()
    Entity.render(self)
end

function MainCharacterEntity:moveLeft(deltaTime)
    self.x = self.x - CHARACTER_SPEED * deltaTime
    self.direction = "left"
    self:checkLeftCollisions(deltaTime)
end

function MainCharacterEntity:moveRight(deltaTime)
    self.x = self.x + CHARACTER_SPEED * deltaTime
    self.direction = "right"
    self:checkRightCollisions(deltaTime)
end

function MainCharacterEntity:checkLeftCollisions(deltaTime)
    local topLeftTile = self.tilesMap:getTileFromPosition(self.x + 1, self.y + 1)
    local bottomLeftTile = self.tilesMap:getTileFromPosition(self.x + 1, self.y + self.height - 1)

    if (topLeftTile and bottomLeftTile) and (topLeftTile:isCollidable() or bottomLeftTile:isCollidable()) then
        -- collide
        -- should reset player position to the most right side of the collide tile
        self.x = topLeftTile.x * topLeftTile.width - 1
    else
        -- should check for collide with any solid object
        -- if exist collision then the player cannot move left
        local collideObjects = self:checkObjectCollisions()
        if #collideObjects > 0 then
            -- reset player position to the last position before move
            -- stop player from moving left
            self.x = self.x + CHARACTER_SPEED * deltaTime
        end
    end
end

function MainCharacterEntity:checkRightCollisions(deltaTime)
    local topRightTile = self.tilesMap:getTileFromPosition(self.x + self.width - 1, self.y + 1)
    local bottomRightTile = self.tilesMap:getTileFromPosition(self.x + self.width - 1, self.y + self.height - 1)

    if (topRightTile and bottomRightTile) and (topRightTile:isCollidable() or bottomRightTile:isCollidable()) then
        -- collide
        -- should reset player position to the most right side of the collide object
        self.x = (topRightTile.x - 1) * topRightTile.width - self.width
    else
        -- should check for collide with any solid object
        -- if exist collision then the player cannot move right
        local collideObjects = self:checkObjectCollisions()
        if #collideObjects > 0 then
            -- reset player position to the last position before move
            -- stop player from moving right
            self.x = self.x - CHARACTER_SPEED * deltaTime
        end
    end
end

function MainCharacterEntity:checkObjectCollisions()
    local collidedObjects = {}

    for k, object in pairs(self.objects) do
        if object:collides(self) then
            if object.solid then
                table.insert(collidedObjects, object)
            elseif object.consumable then
                object:onConsume()
                table.remove(self.objects, k)
            end
        end
    end

    return collidedObjects
end

function MainCharacterEntity:checkEnemyCollisions()
    for k, enemy in pairs(self.enemies) do
        if enemy:collides(self) then
            -- check if main character has collide on top of the enemy
            if enemy.collidable and (self.y + self.height > enemy.y) and (self.y + self.height < enemy.y + enemy.height) and
                (self.x + self.width / 2 > enemy.x) and (self.x + self.width / 2 < enemy.x + enemy.width) then
                -- check if main player is in falling state
                if self.dy > 0 then
                    -- check if enemy is consumable or not  
                    if enemy.consumable then
                        table.remove(self.enemies, k)
                    else
                        -- should switch main player to jumping state   
                        self:changeState("jumping", {
                            jumpVelocity = CHARACTER_BOUNCE_VELOCITY
                        })
                        -- change enemy state
                        enemy:onCollide()
                    end
                end
            else
                -- collide but not on the top
                if enemy.consumable then
                    enemy:onConsume()
                    table.remove(self.enemies, k)
                end
            end
        end
    end
end
