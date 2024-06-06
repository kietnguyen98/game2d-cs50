GameStartState = BaseState()

function GameStartState:init()
    self.timer = 0
    self.colorTimer = 0
    self.delayDuration = 2
    self.isCountdown = false
end

function GameStartState:enter(params)
end

function GameStartState:update(deltaTime)
    if love.keyboard.wasPressed("enter") or love.keyboard.wasPressed("return") then
        self.isCountdown = true
    end

    if self.isCountdown then
        self.timer = self.timer + deltaTime
        self.colorTimer = self.colorTimer + deltaTime
    end

    if self.colorTimer > 6 * deltaTime then
        self.colorTimer = 0
    end

    if self.timer > self.delayDuration then
        self.timer = 0
        self.colorTimer = 0
        self.isCountdown = false
    end
end

function GameStartState:render()
    love.graphics.draw(gameTextures["background"], 0, 0, 0, VIRTUAL_WIDTH / gameTextures["background"]:getWidth(),
        VIRTUAL_HEIGHT / gameTextures["background"]:getHeight())

    -- welcome text
    love.graphics.setFont(gameFonts["zelda-medium"])
    love.graphics.setColor(gameColorPallete["black"])
    love.graphics.printf("Welcome to", 0, 32, VIRTUAL_WIDTH, "center")
    love.graphics.setColor(gameColorPallete["white"])
    love.graphics.printf("Welcome to", 0, 30, VIRTUAL_WIDTH, "center")
    love.graphics.setFont(gameFonts["zelda-large"])
    love.graphics.setColor(gameColorPallete["black"])
    love.graphics.printf("Legend Of Zelda", 0, 64, VIRTUAL_WIDTH, "center")
    love.graphics.setColor(gameColorPallete["white"])
    love.graphics.printf("Legend Of Zelda", 0, 62, VIRTUAL_WIDTH, "center")

    -- guide text
    love.graphics.setFont(gameFonts["default-large"])
    love.graphics.setColor(gameColorPallete["black"])
    love.graphics.printf("Press Enter to Start !", 0, 160, VIRTUAL_WIDTH, "center")
    if self.isCountdown and self.colorTimer ~= 0 then
        love.graphics.setColor(gameColorPallete["white-transparent"])
    else
        love.graphics.setColor(gameColorPallete["white"])
    end
    love.graphics.printf("Press Enter to Start !", 0, 158, VIRTUAL_WIDTH, "center")

    -- reset color
    love.graphics.setColor(gameColorPallete["default"])
end
