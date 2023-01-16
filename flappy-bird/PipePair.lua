PipePair = class()

require "Pipe"

GAP_HEIGHT = 120
PIPE_PAIR_SCROLL_SPEED = 60

function PipePair:init(y)
    self.x = VIRTUAL_WIDTH 
    self.y = y
    self.gap = GAP_HEIGHT * math.random(90,100) / 100
    self.pipes = {
        ["lower"] = Pipe("top", self.y),
        ["upper"] = Pipe("bottom", self.y + PIPE_HEIGHT + self.gap)
    }

    self.remove = false
    self.coin = Coin(self.x + PIPE_WIDTH / 2, self.y + PIPE_HEIGHT + self.gap / 2)
end

function PipePair:update(deltaTime)
    -- check if the pipe pair is off the screen then remove it pipes, else scroll it
    if self.x > -PIPE_WIDTH then
        self.x = self.x - PIPE_PAIR_SCROLL_SPEED * deltaTime
        self.pipes["lower"].x = self.x
        self.pipes["upper"].x = self.x
    else
        self.remove = true
    end
    
    if self.coin ~= nil then
        self.coin:update(deltaTime)
    end
end

function PipePair:render()
    for key, pipe in pairs(self.pipes) do
        pipe:render()
    end

    if self.coin ~= nil then
        self.coin:render()
    end
end