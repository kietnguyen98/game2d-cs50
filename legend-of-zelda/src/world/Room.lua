Room = class()

function Room:init(player)
    self.player = player
    self.width = MAP_WIDTH
    self.height = MAP_HEIGHT
    self.offsetTop = MAP_OFFSET_TOP
    self.tiles = {}
    -- init wall and floor for the room
    self:initializeWallAndFloor()
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
            x = math.random(2, self.width - 2) * TILE_WIDTH,
            y = math.random(2, self.height - 2) * TILE_HEIGHT,
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

function Room:update(deltaTime)
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
end

function Room:render()
    for x = 1, self.width do
        for y = 1, self.height do
            love.graphics.draw(gameTextures[TEXTURE_KEYS.MAP_TILE], gameQuads[QUADS_KEYS.MAP_TILE][self.tiles[x][y].id],
                (x - 1) * TILE_WIDTH, self.offsetTop + (y - 1) * TILE_HEIGHT)
        end
    end
    -- render enemies
    for k, v in pairs(self.enemies) do
        v:render()
    end
end
