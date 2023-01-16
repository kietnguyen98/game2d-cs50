Pipe = class()

PIPE_HEIGHT = 288
PIPE_WIDTH = 70

local PIPE_IMAGE = love.graphics.newImage('assets/pipe.png')

function Pipe:init(orientation, y)
    self.x = VIRTUAL_WIDTH
    self.y = y
    self.orientation = orientation
    
    self.width = PIPE_IMAGE:getWidth()
    self.height = PIPE_HEIGHT
end

function Pipe:update(deltaTime)
end

function Pipe:render()
    love.graphics.draw(
        PIPE_IMAGE, -- image object
        self.x, -- x
        self.orientation == "top" and self.y + PIPE_HEIGHT or self.y, -- y
        0, -- orientation 
        1, -- scale x
        self.orientation == "top" and -1 or 1 -- scale y
    )
end
