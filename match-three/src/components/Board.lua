Board = class()

function Board:init(x, y)
    -- init board with x, y dimension
    self.x = x    
    self.y = y
    
    -- init matches table to manage all the tile in this board
    self.matches = {}
    self:initializeTiles()
end

function Board:initializeTiles()
    self.tiles = {}

    for tileY = 1, 8 do
        self.tiles[tileY] = {}
        for tileX = 1, 8 do
            
            -- create a new tile at x and y position  with a random color and variety
            table.insert(self.tiles[tileY], tileX, Tile(tileX, tileY, math.random(18), math.random(6)))
        end
    end
end

function Board:render()
    for y = 1, #self.tiles do
        for x = 1, #self.tiles[y] do
            self.tiles[y][x]:render(self.x, self.y)
        end
    end
end