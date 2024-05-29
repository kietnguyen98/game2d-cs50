PlayState = BaseState:extend()

function PlayState:init()
    self.width = MAP_WIDTH
    self.height = MAP_HEIGHT
    self.worldLevel = LevelMaker:GenerateWorldLevel(self.width, self.height)
    self.tilesMap = self.worldLevel['tilesMap']
    self.gameObjects = self.worldLevel['objects']
    self.characterSheet = love.graphics.newImage("assets/mario_and_items.png")
    self.characterQuads = GenerateQuadsCharacter(self.characterSheet)
    self.mainCharacter = MainCharacterEntity({
        sheet = self.characterSheet,
        quads = self.characterQuads,
        x = 0,
        y = 2 * TILE_HEIGHT,
        dx = 0,
        dy = 0,
        width = CHARACTER_WIDTH,
        height = CHARACTER_HEIGHT,
        stateMachine = StateMachine({
            ['idle'] = function()
                return MainCharacterIdleState(self.mainCharacter)
            end,
            ['moving'] = function()
                return MainCharacterMovingState(self.mainCharacter)
            end,
            ['jumping'] = function()
                return MainCharacterJumpingState(self.mainCharacter)
            end,
            ['falling'] = function()
                return MainCharacterFallingState(self.mainCharacter)
            end
        }),
        tilesMap = self.tilesMap,
        gameObjects = self.gameObjects
    })
    self.mainCharacter:changeState("falling")
    self.cameraScrollX = 0
    self.cameraScrollY = 0
    self.BACKGROUND = {
        MOUTAINS_1 = love.graphics.newImage("assets/background_mountains_1.png"),
        MOUTAINS_2 = love.graphics.newImage("assets/background_mountains_2.png"),
        CLOUDS = love.graphics.newImage("assets/background_clouds.png")
    }
    self.backgroundScrollX = 0
    self.backgroundScrollY = 0
end

function PlayState:update(deltaTime)
    -- update entities
    self.tilesMap:update(deltaTime)
    self.mainCharacter:update(deltaTime)

    -- update camera
    -- should use math.floor to remove decimal part (if exist) => integer only to prevent
    -- being fractional point in world space
    self.cameraScrollX = math.min((self.width) * TILE_WIDTH - VIRTUAL_WIDTH, math.max(0,
        math.floor(self.mainCharacter.x) - VIRTUAL_WIDTH / 2 + self.mainCharacter.width / 2))
    self.backgroundScrollX = (self.cameraScrollX / 3) % VIRTUAL_WIDTH
end

function PlayState:renderCamera()
    love.graphics.translate(-math.floor(self.cameraScrollX), -math.floor(self.cameraScrollY))
end

function PlayState:renderBackground()
    for i = 0, math.floor(self.width * TILE_WIDTH / VIRTUAL_WIDTH) - 1 do
        love.graphics.draw(self.BACKGROUND.MOUTAINS_1, self.backgroundScrollX + i * VIRTUAL_WIDTH,
            self.backgroundScrollY, 0, VIRTUAL_WIDTH / self.BACKGROUND.MOUTAINS_1:getWidth(),
            VIRTUAL_HEIGHT / self.BACKGROUND.MOUTAINS_1:getHeight())
        love.graphics.draw(self.BACKGROUND.MOUTAINS_2, self.backgroundScrollX + i * VIRTUAL_WIDTH,
            self.backgroundScrollY, 0, VIRTUAL_WIDTH / self.BACKGROUND.MOUTAINS_2:getWidth(),
            VIRTUAL_HEIGHT / self.BACKGROUND.MOUTAINS_2:getHeight())
        love.graphics.draw(self.BACKGROUND.CLOUDS, self.backgroundScrollX + i * VIRTUAL_WIDTH, self.backgroundScrollY,
            0, VIRTUAL_WIDTH / self.BACKGROUND.CLOUDS:getWidth() / 2,
            VIRTUAL_HEIGHT / self.BACKGROUND.CLOUDS:getHeight() / 4)
        love.graphics.draw(self.BACKGROUND.CLOUDS, VIRTUAL_WIDTH / 2 + self.backgroundScrollX + i * VIRTUAL_WIDTH,
            self.backgroundScrollY, 0, VIRTUAL_WIDTH / self.BACKGROUND.CLOUDS:getWidth() / 2,
            VIRTUAL_HEIGHT / self.BACKGROUND.CLOUDS:getHeight() / 4)
    end
end

function PlayState:renderGameObjects()
    for i = 1, #self.gameObjects do
        self.gameObjects[i]:render()
    end
end

function PlayState:render()
    self:renderCamera()
    self:renderBackground()
    self.tilesMap:render()
    self.mainCharacter:render()
    self:renderGameObjects()
end
