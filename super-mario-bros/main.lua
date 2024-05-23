--[[

SUPER MARIO BROS GAME DEVELOPMENT

]] --
require 'src/Dependencies'

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

    backgroundR = 102 / 255
    backgroundG = 217 / 255
    backgroundB = 255 / 255

    -- setup keyboard to keep track of which keys have been pressed in last frame
    love.keyboard.keysPressed = {}

    -- init world
    -- tiles
    tiles = Tiles()

    -- init entities
    local characterSheet = love.graphics.newImage("assets/mario_and_items.png")
    local characterQuads = GenerateQuadsCharacter(characterSheet)
    mainCharacter = MainCharacterEntity({
        sheet = characterSheet,
        quads = characterQuads,
        x = VIRTUAL_WIDTH / 2 - CHARACTER_WIDTH / 2,
        y = (SKY_MAX_INDEX - 1) * TILE_HEIGHT - CHARACTER_HEIGHT,
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
            end
        }),
        map = tiles
    })

    mainCharacter:changeState("idle")
end

function love.resize(x, y)
end

function love.update(deltaTime)
    -- update entities
    tiles:update(deltaTime)
    mainCharacter:update(deltaTime)

    -- update camera
    -- should use math.floor to remove decimal part (if exist) => integer only to prevent
    -- being fractional point in world space
    cameraScrollX = -math.floor(mainCharacter.x) + VIRTUAL_WIDTH / 2 - CHARACTER_WIDTH / 2

    -- reset keys pressed table
    love.keyboard.keysPressed = {}
end

function love.draw()
    -- call every frame to render every things we need
    push:start()
    -- first clear screen with a random GRB color
    love.graphics.clear(backgroundR, backgroundG, backgroundB, 1)
    love.graphics.translate(cameraScrollX, 0)

    -- draw tiles map on screen
    tiles:render()
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
