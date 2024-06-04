MainCharacterEntity = Entity:extend()

MAXIMUM_IMMORTAL_DURATION = 2

function MainCharacterEntity:init(def)
    self.score = 0
    self.isHurt = false
    self.isImmortal = false
    self.immortalTimmer = 0
    self.colorTimer = 0.1
    self.color = CHARACTER_RGB_COLOR_SHEET['default']
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

    -- change player's color base on state
    if self.isHurt and self.colorTimer > 0 then
        self.color = CHARACTER_RGB_COLOR_SHEET['red']
        self.colorTimer = self.colorTimer - deltaTime
    elseif self.isImmortal and self.colorTimer > 0 then
        self.color = CHARACTER_RGB_COLOR_SHEET['transparent']
        self.colorTimer = self.colorTimer - deltaTime
    else
        self.colorTimer = 0.1
        self.color = CHARACTER_RGB_COLOR_SHEET['default']
    end

    -- if player is immortal then update immortal timer
    if self.isImmortal then
        if self.immortalTimmer < MAXIMUM_IMMORTAL_DURATION then
            self.immortalTimmer = self.immortalTimmer + deltaTime
        else
            self.immortalTimmer = 0
            self.isImmortal = false
        end
    end
end

function MainCharacterEntity:render()

    if not self.isImmortal then
        love.graphics.draw( -- draw object
        self.sheet, self.quads[self.currentAnimation:getCurrentFrame()], -- position of object on x axis
        math.floor(self.x) + self.width / 2, -- position of object on y axis
        math.floor(self.y) + self.height / 2, -- rotate degree
        0, -- scale on x axis
        self.direction == "left" and -1 or 1, -- scale on y axis
        1, -- origin offset on x axis
        self.width / 2, -- origin offset on y axis
        self.height / 2)
    end

    -- if player collide with enemy and get hurt then draw main character with red color
    love.graphics.setColor(self.color)
    love.graphics.draw( -- draw object
    self.sheet, self.quads[self.currentAnimation:getCurrentFrame()], -- position of object on x axis
    math.floor(self.x) + self.width / 2, -- position of object on y axis
    math.floor(self.y) + self.height / 2, -- rotate degree
    0, -- scale on x axis
    self.direction == "left" and -1 or 1, -- scale on y axis
    1, -- origin offset on x axis
    self.width / 2, -- origin offset on y axis
    self.height / 2)

    -- reset color
    love.graphics.setColor(CHARACTER_RGB_COLOR_SHEET['default'])
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
        if #self:checkObjectCollisions() > 0 then
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
        if #self:checkObjectCollisions() > 0 then
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
    if self.isImmortal then
        return
    end
    for k, enemy in pairs(self.enemies) do
        if enemy:collides(self) then
            -- check if main character has collide on top of the enemy
            local isCollideOnTop =
                (self.y + self.height > enemy.y) and (self.y + self.height < enemy.y + enemy.height) and
                    (self.x + self.width / 2 > enemy.x) and (self.x + self.width / 2 < enemy.x + enemy.width)
            -- check if main player is in falling state
            if self.dy > 0 and enemy.collidable and isCollideOnTop then
                -- check if enemy is consumable or not  
                if enemy.consumable then
                    table.remove(self.enemies, k)
                else
                    -- reset player position
                    -- should put player on top of the enemy
                    self.y = enemy.y - self.height
                    -- should switch main player to jumping state   
                    self:changeState("jumping", {
                        jumpVelocity = CHARACTER_BOUNCE_UP_VELOCITY
                    })
                    -- change enemy state
                    enemy:onCollide()
                end
                -- collide but not on the top
            elseif enemy.consumable then
                enemy:onConsume()
                table.remove(self.enemies, k)
            else
                if not self.isHurt then
                    self.dy = 0
                    -- cant consume enemy or collide with enemy but not on top
                    -- player get hurt and bounce
                    self:changeState("bounce", {
                        enemyDirection = enemy.direction,
                        collidedPart = (self.x + self.width / 2) < (enemy.x + enemy.width / 2) and "left" or "right"
                    })
                    -- the enemy change direction
                    enemy.direction = enemy.direction == "left" and "right" and "left"
                end
            end
        end
    end
end
