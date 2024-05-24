--[[

SUPER MARIO BROS GAME DEVELOPMENT

]] --
require 'src/Dependencies'

BACKGROUND = {
    MOUTAINS_1 = love.graphics.newImage("assets/background_mountains_1.png"),
    MOUTAINS_2 = love.graphics.newImage("assets/background_mountains_2.png"),
    CLOUDS = love.graphics.newImage("assets/background_clouds.png")
}

function love.load()
    -- init randomseed for random function
    math.randomseed(os.time())

    -- setup graphics
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- setup window title
    love.window.setTitle('Super Mario Bros')

    -- setup game screen
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizeable = true,
        vsync = true
    })

    -- setup keyboard to keep track of which keys have been pressed in last frame
    love.keyboard.keysPressed = {}

    -- init world
    -- tiles
    tilesMap = LevelMaker:GenerateWorldLevel(MAP_WIDTH, MAP_HEIGHT)

    -- init entities
    local characterSheet = love.graphics.newImage("assets/mario_and_items.png")
    local characterQuads = GenerateQuadsCharacter(characterSheet)

    mainCharacter = MainCharacterEntity({
        sheet = characterSheet,
        quads = characterQuads,
        x = VIRTUAL_WIDTH / 2 - CHARACTER_WIDTH / 2,
        y = (SKY_MAX_INDEX - 1) * TILE_HEIGHT - CHARACTER_HEIGHT,
        dx = 0,
        dy = 0,
        width = CHARACTER_WIDTH,
        height = CHARACTER_HEIGHT,
        stateMachine = StateMachine({
            ['idle'] = function()
                return MainCharacterIdleState(mainCharacter)
            end,
            ['moving'] = function()
                return MainCharacterMovingState(mainCharacter)
            end,
            ['jumping'] = function()
                return MainCharacterJumpingState(mainCharacter)
            end,
            ['falling'] = function()
                return MainCharacterFallingState(mainCharacter)
            end
        }),
        tilesMap = tilesMap
    })

    mainCharacter:changeState("idle")
end

function love.resize(x, y)
end

function love.update(deltaTime)
    -- update entities
    tilesMap:update(deltaTime)
    mainCharacter:update(deltaTime)

    if mainCharacter.x <= 0 then
        mainCharacter.x = 0
    elseif mainCharacter.x >= tilesMap.width * TILE_WIDTH - mainCharacter.width then
        mainCharacter.x = tilesMap.width * TILE_WIDTH - mainCharacter.width
    end

    -- update camera
    -- should use math.floor to remove decimal part (if exist) => integer only to prevent
    -- being fractional point in world space
    cameraScrollX = math.min((MAP_WIDTH) * TILE_WIDTH - VIRTUAL_WIDTH,
        math.max(0, math.floor(mainCharacter.x) - VIRTUAL_WIDTH / 2 + CHARACTER_WIDTH / 2))

    -- reset keys pressed table
    love.keyboard.keysPressed = {}
end

function love.draw()
    push:start()

    -- background
    love.graphics.draw(BACKGROUND.MOUTAINS_1, 0, 0, 0, VIRTUAL_WIDTH / BACKGROUND.MOUTAINS_1:getWidth(),
        VIRTUAL_HEIGHT / BACKGROUND.MOUTAINS_1:getHeight())
    love.graphics.draw(BACKGROUND.MOUTAINS_2, 0, 0, 0, VIRTUAL_WIDTH / BACKGROUND.MOUTAINS_2:getWidth(),
        VIRTUAL_HEIGHT / BACKGROUND.MOUTAINS_2:getHeight())
    love.graphics.draw(BACKGROUND.CLOUDS, 0, 0, 0, VIRTUAL_WIDTH / BACKGROUND.CLOUDS:getWidth() / 2,
        VIRTUAL_HEIGHT / BACKGROUND.CLOUDS:getHeight() / 4)
    love.graphics.draw(BACKGROUND.CLOUDS, VIRTUAL_WIDTH / 2, 0, 0, VIRTUAL_WIDTH / BACKGROUND.CLOUDS:getWidth() / 2,
        VIRTUAL_HEIGHT / BACKGROUND.CLOUDS:getHeight() / 4)

    -- update camera
    love.graphics.translate(-cameraScrollX, 0)

    -- draw tiles map on screen
    tilesMap:render()
    mainCharacter:render()
    push:finish()
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true

    if love.keyboard.keysPressed["escape"] then
        love.event.quit()
    end
end

function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
        return true
    else
        return false
    end
end
