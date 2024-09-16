GamePlayState = BaseState:extend()

function GamePlayState:init(def)
    self.level = Level()
    self.levelTranslateX = 0
end

function GamePlayState:enter(params)
end

function GamePlayState:update(deltaTime)
    -- update camera
    if love.keyboard.isDown('left') then
        self.levelTranslateX = self.levelTranslateX + MAP_SCROLL_X_SPEED * deltaTime

        if self.levelTranslateX > VIRTUAL_WIDTH then
            self.levelTranslateX = VIRTUAL_WIDTH
        else

            -- only update background if we were able to scroll the level
            self.level.background:update(deltaTime)
        end
    elseif love.keyboard.isDown('right') then
        self.levelTranslateX = self.levelTranslateX - MAP_SCROLL_X_SPEED * deltaTime

        if self.levelTranslateX < -VIRTUAL_WIDTH then
            self.levelTranslateX = -VIRTUAL_WIDTH
        else

            -- only update background if we were able to scroll the level
            self.level.background:update(deltaTime)
        end
    end

    self.level:update(deltaTime)
end

function GamePlayState:render(deltaTime)
    -- render background separate from level rendering
    self.level.background:render()

    love.graphics.translate(math.floor(self.levelTranslateX), 0)
    self.level:render()
end
