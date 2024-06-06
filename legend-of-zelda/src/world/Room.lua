Room = class()

function Room:init(def)
    self.width = MAP_WIDTH
    self.height = MAP_HEIGHT
    self.offsetTop = MAP_OFFSET_TOP
    self.tiles = {}
    -- init wall and floor for the room
    self:initializeWallAndFloor()
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

function Room:update(deltaTime)
end

function Room:render()
    for x = 1, self.width do
        for y = 1, self.height do
            love.graphics.draw(gameTextures['map-tile-sheet'], gameQuads['map-tile-sheet'][self.tiles[x][y].id],
                (x - 1) * TILE_WIDTH, self.offsetTop + (y - 1) * TILE_HEIGHT)
        end
    end
end
