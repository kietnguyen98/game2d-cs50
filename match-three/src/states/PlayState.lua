PlayState = BaseState:extend()

function PlayState:init()
    -- start state transitionn animation, using fade in animation
    self.transitionAlpha = 1

    -- init highlighted tile position on the board grid
    -- start at x = 0, y = 0, first tile of the board on top-left
    self.highlightedTileX = 0
    self.highlightedTileY = 0
    self.highlightedBorder = HighlightedBorder() 
end

function PlayState:enter(params)
    -- init game level
    self.level = params.level
    -- init game tiles board
    self.board = params.board

end

function PlayState:update(deltaTime)

    -- handle player input to change the current highlighted tile
    if love.keyboard.wasPressed('up') then
       self.highlightedTileY = math.max(0, self.highlightedTileY - 1) -- must >= 0
    elseif love.keyboard.wasPressed('down') then
       self.highlightedTileY = math.min(7, self.highlightedTileY + 1) -- must <= 7
    elseif love.keyboard.wasPressed('left') then 
       self.highlightedTileX = math.max(0, self.highlightedTileX - 1) -- must >= 0
    elseif love.keyboard.wasPressed('right') then 
       self.highlightedTileX = math.min(7, self.highlightedTileX + 1) -- must <= 7
    end

    Timer.update(deltaTime)
    self.highlightedBorder:update(deltaTime)
end

function PlayState:render()
    -- render tiles board
    self.board:render()

    -- render the highlighted tile border
    self.highlightedBorder:render(
        self.board.x + self.highlightedTileX * TILE_WIDTH,
        self.board.y + self.highlightedTileY * TILE_HEIGHT
    )
end