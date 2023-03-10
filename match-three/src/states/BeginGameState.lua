BeginGameState = BaseState:extend()

function BeginGameState:init()
    -- start transition by a full size overlay with white color
    -- during transition, chage it's opacity from 1 to 0 => make fade in effect
    self.transitionAlpha = 1

    -- init level label with init height
    self.levelLabelY = -64

    self.board = nil
end

function BeginGameState:enter(params)
    -- get the init level of the game
    self.level = params.level
    self.score = params.score and params.score or 0 
    self.highScoresBoard = params.highScoresBoard

    --
    -- the animation in this state will be fade in white screen
    -- and there will be and level text drop down
    -- then change the game state to start
    --

    -- flag which check if the game has just start
    self.isStart = params.isStart
    
    if self.isStart then 
        -- create the board on the screen, align it on the right side
        self.board = Board(VIRTUAL_WIDTH - 272, 16, self.level)
    else
        self.board = params.currentBoard
    end

    -- to make these animations we will use chaining effect
    -- first make the fade in animation

    Timer.tween(1, {
        [self] = {transitionAlpha = 0}
    }):finish(
        -- after that make the level text drop downn animation
        function() 
            -- apply sound effect
            gameSounds['level_up']:play()

            Timer.tween(0.5, {
                [self] = {levelLabelY = (VIRTUAL_HEIGHT - 64) / 2}
            }):finish(
            function()   
                -- hold the text for 1 second and keep animate the text to go down
                Timer.after(1, function()
                -- make the text label to go down
                Timer.tween(0.5, {
                    [self] = {levelLabelY = VIRTUAL_HEIGHT + 64}
                }):finish(function() 
                    -- finish all the needed animation, next we need to change game state to play
                    gameStateMachine:change('play', {
                        level = self.level,
                        board = self.board,
                        score = self.score,
                        highScoresBoard = self.highScoresBoard
                    })
                end)
           end)    
        end) 
    end)

end

function BeginGameState:update(deltaTime)
    Timer.update(deltaTime)
end

function BeginGameState:render()
    -- render the tiles board
    self.board:render()

    -- render white overlay fill over the screen to make fade in animation
    love.graphics.setColor(1, 1, 1, self.transitionAlpha)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)

    -- render level label
    -- draw label background with a black blur rectangle overlay
    love.graphics.setColor(OverlayColor.GREEN_BLUR)
    love.graphics.rectangle('fill', 0, self.levelLabelY, VIRTUAL_WIDTH, 64)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setFont(gameFonts['large'])
    love.graphics.printf('Level '..tostring(self.level), 0, self.levelLabelY + 16, VIRTUAL_WIDTH, 'center')
end