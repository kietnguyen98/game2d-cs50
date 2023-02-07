SelectPaddleState = BaseState:extend()

function SelectPaddleState:init()
    self.currentPaddle = Paddle()
    self.paddleSkin = 1
end

function SelectPaddleState:enter(params)
    self.health = params.health
    self.score = params.score
    self.highScoresBoard = params.highScoresBoard
end

function SelectPaddleState:update()
    if love.keyboard.wasPressed('left') then
        if self.paddleSkin == 1 then
            self.paddleSkin = 4
        else
            self.paddleSkin = self.paddleSkin - 1
        end
        gameSounds["no-select"]:play()
        self.currentPaddle.skin = self.paddleSkin
    elseif love.keyboard.wasPressed('right') then
        if self.paddleSkin == 4 then
            self.paddleSkin = 1
        else
            self.paddleSkin = self.paddleSkin + 1
        end
        gameSounds["no-select"]:play()
        self.currentPaddle.skin = self.paddleSkin
    end

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gameSounds["select"]:play()
        gameStateMachine:change('serve', {
            paddle = self.currentPaddle,
            bricks = LevelMaker.createMap(1), -- game start at level 1
            health = self.health,
            score = self.score,
            level = 1, 
            highScoresBoard = self.highScoresBoard
        })
    end
end

function SelectPaddleState:render()
    -- render title text
    love.graphics.setFont(gameFonts['medium'])
    love.graphics.printf("SELECT PADDLE", 0, VIRTUAL_HEIGHT / 4 - 20, VIRTUAL_WIDTH, 'center')
    
    -- render guide text
    love.graphics.setFont(gameFonts['tiny'])
    love.graphics.printf("press LEFT or RIGHT to switch the paddle", 0, VIRTUAL_HEIGHT / 3, VIRTUAL_WIDTH, 'center')
    love.graphics.printf("press ENTER to select the paddle", 0, VIRTUAL_HEIGHT / 3 + 20, VIRTUAL_WIDTH, 'center')

    -- render the left arrow 
    love.graphics.draw(gameTextures["arrows"], gameObjectQuads["arrows"][1], VIRTUAL_WIDTH / 2 - 100, VIRTUAL_HEIGHT - 50)
    
    -- render the right arrow
    love.graphics.draw(gameTextures["arrows"], gameObjectQuads["arrows"][2], VIRTUAL_WIDTH / 2 + 60, VIRTUAL_HEIGHT - 50)

    -- render the paddle to select
    love.graphics.draw(gameTextures["main"], gameObjectQuads["paddles"][2 + 4 * (self.paddleSkin - 1)], VIRTUAL_WIDTH / 2 - 40, VIRTUAL_HEIGHT - 45)
end