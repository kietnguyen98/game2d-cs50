StartState = BaseState:extend()

-- init needed values
-- game option values
-- 1 = game start
-- 2 = high scores
local highlightedOption = 1

function StartState:init()
    self.health = 3
    self.score = 0
end

function StartState:enter()
    self.highScoresBoard = loadHighScores()
end

function StartState:update()
    if love.keyboard.wasPressed('up') or love.keyboard.wasPressed('down') then
        highlightedOption = highlightedOption == 1 and 2 or 1
        gameSounds['paddle-hit']:play()
    end

    -- change game state when user enter option
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gameSounds['select']:play()
        -- player enter play mode
        if highlightedOption == 1 then
            gameStateMachine:change('serve', {
                paddle = Paddle(),
                bricks = LevelMaker.createMap(1),
                health = self.health,
                score = self.score,
                level = 1,
                highScoresBoard = self.highScoresBoard
            })
        -- player enter high score board mode
        elseif highlightedOption == 2 then
            gameStateMachine:change('high-score', {
                highScoresBoard = self.highScoresBoard
            })
        end
    end
end

function StartState:render()
    -- draw tittle text
    love.graphics.setFont(gameFonts["large"])
    love.graphics.printf("BREAKOUT", 0, VIRTUAL_HEIGHT / 3, VIRTUAL_WIDTH, 'center')

    -- draw instructions text
    love.graphics.setFont(gameFonts["medium"])
    if highlightedOption == 1 then
        love.graphics.setColor(love.math.colorFromBytes(103, 205, 255, 255))
    end
    love.graphics.printf("START", 0, VIRTUAL_HEIGHT / 2 + 50, VIRTUAL_WIDTH, 'center')

    -- reset the color
    love.graphics.setColor(1, 1, 1, 1)

    if highlightedOption == 2 then
        love.graphics.setColor(love.math.colorFromBytes(103, 205, 255, 255))
    end

    love.graphics.printf("HIGH SCORE", 0, VIRTUAL_HEIGHT / 2 + 80, VIRTUAL_WIDTH, 'center')

    -- reset the color
    love.graphics.setColor(1, 1, 1, 1)
end