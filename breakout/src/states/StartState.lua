StartState = BaseState:extend()

-- init needed values
local highlightedOption = 1

function StartState:update()
    if love.keyboard.wasPressed('up') or love.keyboard.wasPressed('down') then
        highlightedOption = highlightedOption == 1 and 2 or 1
        gameSounds['paddle-hit']:play()
    end
end

function StartState:render()
    -- draw tittle text
    love.graphics.setFont(gameFonts["large"])
    love.graphics.printf("BREAKOUT", 0, VIRTUAL_HEIGHT / 3, VIRTUAL_WIDTH, 'center')

    -- draw instructions text
    love.graphics.setFont(gameFonts["medium"])
    if highlightedOption == 1 then
        love.graphics.setColor(103 / 255, 205 / 255, 205 / 255, 205 / 255)
    end
    love.graphics.printf("START", 0, VIRTUAL_HEIGHT / 2 + 50, VIRTUAL_WIDTH, 'center')

    -- reset the color
    love.graphics.setColor(255 / 255, 255 / 255, 255 / 255, 255 / 255)

    if highlightedOption == 2 then
        love.graphics.setColor(103 / 255, 255 / 255, 255 / 255, 255 / 255)
    end
    love.graphics.printf("HIGH SCORE", 0, VIRTUAL_HEIGHT / 2 + 80, VIRTUAL_WIDTH, 'center')

    -- reset the color
    love.graphics.setColor(255 / 255, 255 / 255, 255 / 255, 255 / 255)
end