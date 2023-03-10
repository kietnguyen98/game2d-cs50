HighScoresState = BaseState:extend()

function HighScoresState:init()
    self.transitionAlpha = 0
    self.guideTextAlpha = 1
    
    Timer.every(0.4, function()
        self.guideTextAlpha = self.guideTextAlpha == 1 and 0 or 1 
    end)
end

function HighScoresState:enter(params)
    self.highScoresBoard = params.highScoresBoard
end

function HighScoresState:update(deltaTime)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gameSounds['select_option']:play()
        Timer.tween(1, {
            [self] = { transitionAlpha = 1}
        }):finish(function() 
            gameStateMachine:change('start')
        end)
    end 

    Timer.update(deltaTime)
end

function HighScoresState:render()
    -- render title
    love.graphics.setFont(gameFonts['medium'])
    drawTextShadow('HIGH SCORE BOARD', 20)
    love.graphics.setColor(TextOptionColor.HIGHT_LIGHT)
    love.graphics.printf("HIGH SCORE BOARD", 0, 20, VIRTUAL_WIDTH, 'center')
  
    -- render the high scores board
    -- high score overlay
    love.graphics.setColor(OverlayColor.BLACK_BLUR)
    love.graphics.rectangle('fill', VIRTUAL_WIDTH / 2 - 110, 40, 220, 215, 8)
    -- high score table
    love.graphics.setColor(1,1,1,1)
    love.graphics.setFont(gameFonts['medium'])
    for i = 1, #self.highScoresBoard do
        love.graphics.print(tostring(i)..". "..self.highScoresBoard[i]['name'].." --- "..self.highScoresBoard[i]['scores'],
            VIRTUAL_WIDTH / 2 - 100,
            30 + i * 20
        )
    end

    -- render guide text
    love.graphics.setFont(gameFonts['medium'])
    -- drawTextShadow('press Enter to return to the menu !', VIRTUAL_HEIGHT - 25)
    love.graphics.setColor(8/255, 155/255, 130/255, self.guideTextAlpha)
    love.graphics.printf("press Enter to return to the menu !", 0, VIRTUAL_HEIGHT - 25, VIRTUAL_WIDTH, 'center')
    -- make an overlay over all the this game state ui for game state transition effect
    love.graphics.setColor(1, 1, 1, self.transitionAlpha)
    love.graphics.rectangle('fill', 0 , 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
end