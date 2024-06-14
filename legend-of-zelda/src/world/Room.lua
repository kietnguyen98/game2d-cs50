Room = class()

function Room:init(player)
    self.player = player
    self.width = MAP_WIDTH
    self.height = MAP_HEIGHT
    self.shiftingX = 0
    self.shiftingY = 0
    self.offsetTop = MAP_OFFSET_TOP
    self.offsetLeft = MAP_OFFSET_LEFT

    -- init tiles include wall and floor for the room
    self.tiles = {}
    self:initializeWallAndFloor()
    -- init all gateways
    self.gateways = {
        [GATEWAY_DIRECTION_VALUES.TOP] = Gateway(GATEWAY_DIRECTION_VALUES.TOP, false, self),
        [GATEWAY_DIRECTION_VALUES.BOTTOM] = Gateway(GATEWAY_DIRECTION_VALUES.BOTTOM, false, self),
        [GATEWAY_DIRECTION_VALUES.LEFT] = Gateway(GATEWAY_DIRECTION_VALUES.LEFT, false, self),
        [GATEWAY_DIRECTION_VALUES.RIGHT] = Gateway(GATEWAY_DIRECTION_VALUES.RIGHT, false, self)
    }
    -- init objects
    self.objects = {}
    self:generateObjects()

    -- init enemies 
    self.enemies = {}
    self:generateEnemies()
end

function Room:initializeWallAndFloor()
    for x = 1, self.width do
        table.insert(self.tiles, {})

        for y = 1, self.height do
            local tileId
            if x == 1 and y == 1 then
                -- 4 conner first
                tileId = TILE_ID.WALL.TOP_LEFT_CONNER
            elseif x == 1 and y == self.height then
                tileId = TILE_ID.WALL.BOTTOM_LEFT_CONNER
            elseif x == self.width and y == 1 then
                tileId = TILE_ID.WALL.TOP_RIGHT_CONNER
            elseif x == self.width and y == self.height then
                tileId = TILE_ID.WALL.BOTTOM_RIGHT_CONNER
                -- then 4 wall
            elseif x == 1 then
                tileId = TILE_ID.WALL.LEFT[math.random(#TILE_ID.WALL.LEFT)]
            elseif x == self.width then
                tileId = TILE_ID.WALL.RIGHT[math.random(#TILE_ID.WALL.RIGHT)]
            elseif y == 1 then
                tileId = TILE_ID.WALL.TOP[math.random(#TILE_ID.WALL.TOP)]
            elseif y == self.height then
                tileId = TILE_ID.WALL.BOTTOM[math.random(#TILE_ID.WALL.BOTTOM)]
            else
                -- finally, the floor
                tileId = TILE_ID.FLOOR[math.random(#TILE_ID.FLOOR)]
            end

            table.insert(self.tiles[x], {
                id = tileId
            })
        end
    end
end

function Room:generateEnemies()
    local ENEMY_KEYS = {ENTITY_NAME_KEYS.SKELETON, ENTITY_NAME_KEYS.BAT, ENTITY_NAME_KEYS.GHOST, ENTITY_NAME_KEYS.SLIME,
                        ENTITY_NAME_KEYS.SPIDER}

    -- generate 20 enemies per room
    for i = 1, 20 do
        local key = ENEMY_KEYS[math.random(1, #ENEMY_KEYS)]
        local newEnemy = Entity({
            x = math.random(MAP_OFFSET_LEFT + TILE_WIDTH, MAP_OFFSET_LEFT + MAP_WIDTH * TILE_WIDTH - 2 * TILE_WIDTH),
            y = math.random(MAP_OFFSET_TOP + TILE_HEIGHT, MAP_OFFSET_TOP + MAP_HEIGHT * TILE_HEIGHT - 2 * TILE_HEIGHT),
            width = ENTITY_WIDTH,
            height = ENTITY_HEIGHT,
            movingSpeed = ENTITY_DEFINITIONS[key].movingSpeed,
            animations = ENTITY_DEFINITIONS[key].animations,
            hitbox = ENTITY_DEFINITIONS[key].hitbox,
            textureName = TEXTURE_KEYS.ENTITIES,
            quadsName = QUADS_KEYS.ENTITIES
        })
        newEnemy.stateMachine = StateMachine({
            [ENTITY_STATE_KEYS.IDLE] = function()
                return EntityIdleState(newEnemy, math.random(0, 1))
            end,
            [ENTITY_STATE_KEYS.MOVING] = function()
                return EntityMovingState(newEnemy)
            end
        })

        newEnemy:changeState(ENTITY_STATE_KEYS.IDLE)
        table.insert(self.enemies, newEnemy)
    end
end

function Room:generateObjects()
    -- switch
    local switch = GameObject({
        x = math.random(MAP_OFFSET_LEFT + TILE_WIDTH,
            MAP_OFFSET_LEFT + MAP_WIDTH * TILE_WIDTH - TILE_WIDTH - SWITCH_WIDTH),
        y = math.random(MAP_OFFSET_TOP + TILE_HEIGHT,
            MAP_OFFSET_TOP + MAP_HEIGHT * TILE_HEIGHT - TILE_HEIGHT - SWITCH_HEIGHT),
        width = GAME_OBJECT_DEFINITIONS[GAME_OBJECT_NAME_KEYS.SWITCH].width,
        height = GAME_OBJECT_DEFINITIONS[GAME_OBJECT_NAME_KEYS.SWITCH].height,
        hitbox = GAME_OBJECT_DEFINITIONS[GAME_OBJECT_NAME_KEYS.SWITCH].hitbox,
        textureName = GAME_OBJECT_DEFINITIONS[GAME_OBJECT_NAME_KEYS.SWITCH].textureName,
        quadName = GAME_OBJECT_DEFINITIONS[GAME_OBJECT_NAME_KEYS.SWITCH].quadName,
        states = GAME_OBJECT_DEFINITIONS[GAME_OBJECT_NAME_KEYS.SWITCH].states,
        currentState = GAME_OBJECT_DEFINITIONS[GAME_OBJECT_NAME_KEYS.SWITCH].currentState,
        isSolid = GAME_OBJECT_DEFINITIONS[GAME_OBJECT_NAME_KEYS.SWITCH].isSolid,
        collidable = GAME_OBJECT_DEFINITIONS[GAME_OBJECT_NAME_KEYS.SWITCH].collidable

    })

    switch.onCollide = function()
        if love.keyboard.wasPressed(KEYBOARD_BUTTON_VALUES.SPACE) then
            -- self refer to switch object
            switch.currentState = SWITCH_STATE_VALUES.PRESSED
            for k, gateway in pairs(self.gateways) do
                gateway:open()
            end
        end
    end

    table.insert(self.objects, switch)
end

function Room:update(deltaTime)
    -- update player 
    self.player:update(deltaTime)

    -- update gateways
    for k, gateway in pairs(self.gateways) do
        gateway:update(deltaTime)
    end

    -- update enemies
    for k, enemy in pairs(self.enemies) do
        enemy:update(deltaTime)

        -- check for enemy collide with player
        if enemy:collides(self.player.hitbox) then
            if not self.player.isImmortal then
                self.player.health = self.player.health - 1
                self.player:goImmortal(PLAYER_MAX_IMMORTAL_DURATION)
            end
        end
    end

    -- update objects 
    for i, object in pairs(self.objects) do
        object:update(deltaTime)
        -- check if the player collide with object
        if self.player:collides(object.hitbox) then
            if object.collidable then
                object:onCollide()
            end
        end
    end
end

function Room:render()
    -- render room wall, floor
    for x = 1, self.width do
        for y = 1, self.height do
            love.graphics.draw(gameTextures[TEXTURE_KEYS.MAP_TILE], gameQuads[QUADS_KEYS.MAP_TILE][self.tiles[x][y].id],
                (x - 1) * TILE_WIDTH + self.offsetLeft + self.shiftingX,
                (y - 1) * TILE_HEIGHT + self.offsetTop + self.shiftingY)
        end
    end

    -- render objects 
    for i, object in pairs(self.objects) do
        object:render(self.shiftingX, self.shiftingY)
    end

    -- render gateways
    for k, gateway in pairs(self.gateways) do
        gateway:render(self.shiftingX, self.shiftingY)
    end

    -- render enemies
    for i, enemy in pairs(self.enemies) do
        enemy:render(self.shiftingX, self.shiftingY)
    end

    -- render player
    self.player:render()
end
