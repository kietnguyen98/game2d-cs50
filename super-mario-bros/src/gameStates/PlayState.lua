PlayState = BaseState:extend()

function PlayState:init()
    -- init map dimesion values
    self.width = MAP_WIDTH
    self.height = MAP_HEIGHT
    -- init character
    self.characterSheet = love.graphics.newImage("assets/mario_and_items.png")
    self.characterQuads = GenerateQuadsCharacter(self.characterSheet)
    self.lifeQuads = GenerateQuadsStar(self.characterSheet)
    self.fireQuads = GenerateQuadsFire(self.characterSheet)
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
            end,
            ['bounce'] = function()
                return MainCharacterBounceState(self.mainCharacter)
            end
        })
    })
    -- get world with tiles map, game objects, enemies
    self.worldLevel = LevelMaker:GenerateWorldLevel(self.width, self.height, self.mainCharacter)
    self.tilesMap = self.worldLevel['tilesMap']
    self.objects = self.worldLevel['objects']
    self.enemies = self.worldLevel['enemies']
    -- setup character
    self.mainCharacter.tilesMap = self.tilesMap
    self.mainCharacter.objects = self.objects
    self.mainCharacter.enemies = self.enemies
    self.mainCharacter:changeState("falling")
    -- init final point
    self.finalPoint = FinalPointEntity({
        sheet = self.characterSheet,
        quads = self.fireQuads,
        x = (self.tilesMap.width - 1) * TILE_WIDTH - (FINAL_POINT_WIDTH - TILE_HEIGHT) / 2,
        y = (SKY_MAX_INDEX - 1) * TILE_HEIGHT - FINAL_POINT_HEIGHT,
        dx = 0,
        dy = 0,
        width = FINAL_POINT_WIDTH,
        height = FINAL_POINT_HEIGHT,
        scaleRatio = FINAL_POINT_SCALE_RATIO,
        stateMachine = StateMachine({
            ['idle'] = function()
                return FinalPointIdleState(self.finalPoint, self.mainCharacter)
            end
        })
    })
    -- setup final point
    self.finalPoint:changeState("idle")
    -- init camera
    self.cameraScrollX = 0
    self.cameraScrollY = 0
    -- init background
    self.BACKGROUND = {
        MOUTAINS_1 = love.graphics.newImage("assets/background_mountains_1.png"),
        MOUTAINS_2 = love.graphics.newImage("assets/background_mountains_2.png"),
        CLOUDS = love.graphics.newImage("assets/background_clouds.png")
    }
    self.backgroundScrollX = 0
    self.backgroundScrollY = 0
end

function PlayState:updateObjects(deltaTime)
    for i = 1, #self.objects do
        self.objects[i]:update(deltaTime)
    end
end

function PlayState:updateEnemies(deltaTime)
    for i = 1, #self.enemies do
        self.enemies[i]:update(deltaTime)
    end
end

function PlayState:update(deltaTime)
    -- update entities
    self.tilesMap:update(deltaTime)
    self.mainCharacter:update(deltaTime)
    self.finalPoint:update(deltaTime)
    self:updateObjects(deltaTime)
    self:updateEnemies(deltaTime)

    -- change game states when player out of lives
    if self.mainCharacter.lives == 0 and not self.mainCharacter.isHurt then
        gameStateMachine:change("start")
    end

    -- check if main player get to final point and change game state
    if self.finalPoint:collides(self.mainCharacter) then
        gameStateMachine:change("finish", {
            score = self.mainCharacter.score,
            lives = self.mainCharacter.lives
        })
    end

    -- update camera
    -- should use math.floor to remove decimal part (if exist) => integer only to prevent
    -- being fractional point in world space
    self.cameraScrollX = math.min((self.width) * TILE_WIDTH - VIRTUAL_WIDTH, math.max(0,
        math.floor(self.mainCharacter.x) - VIRTUAL_WIDTH / 2 + self.mainCharacter.width / 2))
    self.backgroundScrollX = (self.cameraScrollX / 3) % VIRTUAL_WIDTH
end

function PlayState:GenerateEnemies()
    local enemiesSheet = love.graphics.newImage("assets/enemies.png")
    local enemiesQuads = GenerateQuadsEnemies(enemiesSheet)
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

function PlayState:renderObjects()
    for i = 1, #self.objects do
        self.objects[i]:render()
    end
end

function PlayState:renderEnemies()
    for i = 1, #self.enemies do
        self.enemies[i]:render()
    end
end

function PlayState:renderPlayerScore()
    love.graphics.setFont(fontExtraSmall)
    love.graphics.setColor(0, 0, 0, 255)
    love.graphics.printf('Score: ' .. tostring(self.mainCharacter.score), 72 + self.cameraScrollX, 4, VIRTUAL_WIDTH,
        'left')

    -- reset color
    love.graphics.setColor(255, 255, 255, 255)
end

function PlayState:renderPlayerLives()
    love.graphics.setFont(fontExtraSmall)
    love.graphics.setColor(0, 0, 0, 255)
    love.graphics.printf('Lives: ', self.cameraScrollX + 4, 4, VIRTUAL_WIDTH, 'left')
    -- reset color
    love.graphics.setColor(255, 255, 255, 255)

    if self.mainCharacter.lives > 0 then
        for i = 1, self.mainCharacter.lives do
            love.graphics.draw(self.characterSheet, self.lifeQuads[4], 28 + self.cameraScrollX + (i - 1) * 10, 2, 0,
                0.5, 0.5)
        end
    end
end

function PlayState:render()
    self:renderCamera()
    self:renderBackground()
    self.tilesMap:render()
    self.mainCharacter:render()
    self.finalPoint:render()
    self:renderObjects()
    self:renderEnemies()
    self:renderPlayerScore()
    self:renderPlayerLives()
end
