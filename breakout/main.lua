-- import needed libary and dependencies
require "src/Dependencies"

-- define main functions
function love.load()
    -- set up graphics
    love.graphics.setDefaultFilter('nearest', 'nearest')
    -- set up math random seed
    math.randomseed(os.time())
    -- set up window
    love.window.setTitle('Breakout')
    -- set up fonts
    gameFonts = {
        ["tiny"] = love.graphics.newFont('fonts/pressStart.ttf', 7),
        ["small"] = love.graphics.newFont('fonts/pressStart.ttf', 12),
        ["medium"] = love.graphics.newFont('fonts/pressStart.ttf', 16),
        ["large"] = love.graphics.newFont('fonts/pressStart.ttf', 20),
    }
    love.graphics.setFont(gameFonts["small"])
    -- set up all the assets/textures in the game
    gameTextures = {
        ["background"] = love.graphics.newImage('assets/background.png'),
        ["main"] = love.graphics.newImage('assets/breakout.png'),
        ["arrows"] = love.graphics.newImage('assets/arrows.png'),
        ["hearts"] = love.graphics.newImage('assets/hearts.png'),
        ["particle"] = love.graphics.newImage('assets/particle.png'),
    }

    -- Quads we well generate for all of our textures;
    -- Quads allow us to show only part of a texture and not the entire thing
    gameObjectQuads = {
        ["paddles"] = GenerateQuadsPaddles(gameTextures["main"]),
        ["balls"] = GenerateQuadsBall(gameTextures['main']),
        ["bricks"] = GenerateQuadsBricks(gameTextures['main']),
        ["hearts"] = GenerateQuadsHearts(gameTextures['hearts']),
        ["arrows"] = GenerateQuadsArrows(gameTextures['arrows'])
    }

    -- setup window screen, init virtual resolution
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT,{
        vsync = true,
        fullscreen = false,
        resizeable = true,
    })

    -- setup all sounds for the game
    gameSounds = {
        ['paddle-hit'] = love.audio.newSource('sounds/paddle_hit.wav', 'static'),
        ['score'] = love.audio.newSource('sounds/score.wav', 'static'),
        ['wall-hit'] = love.audio.newSource('sounds/wall_hit.wav', 'static'),
        ['confirm'] = love.audio.newSource('sounds/confirm.wav', 'static'),
        ['select'] = love.audio.newSource('sounds/select.wav', 'static'),
        ['no-select'] = love.audio.newSource('sounds/no_select.wav', 'static'),
        ['brick-hit-1'] = love.audio.newSource('sounds/brick_hit_1.wav', 'static'),
        ['brick-hit-2'] = love.audio.newSource('sounds/brick_hit_2.wav', 'static'),
        ['hurt'] = love.audio.newSource('sounds/hurt.wav', 'static'),
        ['victory'] = love.audio.newSource('sounds/victory.wav', 'static'),
        ['recover'] = love.audio.newSource('sounds/recover.wav', 'static'),
        ['high-score'] = love.audio.newSource('sounds/high_score.wav', 'static'),
        ['pause'] = love.audio.newSource('sounds/pause.wav', 'static'),
    
        ['music'] = love.audio.newSource('sounds/background_music.mp3', 'static'),
    }
    -- play background music
    gameSounds['music']:setLooping(true)
    gameSounds['music']:play()
    
    -- init fsm and setup init state
    gameStateMachine = StateMachine({
        ['start'] = function() return StartState() end,
        ['select-paddle'] = function() return SelectPaddleState() end,
        ['serve'] = function() return ServeState() end,
        ['play'] = function() return PlayState() end,
        ['game-over'] = function() return GameOverState() end,
        ['victory'] = function() return VictoryState() end,
        ['enter-high-score'] = function() return EnterHighScoreState() end,
        ['high-score'] = function() return HighScoreState() end
    })

    -- run initial state
    gameStateMachine:change('start')

    -- setup keyboard to keep track of which keys have been pressed in last frame
    love.keyboard.keysPressed = {}
end

function love.update(deltaTime)
    gameStateMachine:update(deltaTime)

    -- reset keys pressed table
    love.keyboard.keysPressed = {}

end

function love.draw()
    -- init push library
    push:apply('start')

    -- init background
    local backgroundWidth = gameTextures['background']:getWidth()
    local backgroundHeight = gameTextures['background']:getHeight()

    love.graphics.draw(gameTextures['background'], 0 , 0, 0, VIRTUAL_WIDTH / (backgroundWidth - 1), VIRTUAL_HEIGHT / (backgroundHeight - 1))

    -- render current state
    gameStateMachine:render()

    -- finish using push
    push:apply('end')
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

function renderHealth(health)
    local healthX = VIRTUAL_WIDTH - 120
    local healthY = 4

    -- render health left
    for i = 1, health do
        love.graphics.draw(gameTextures['hearts'], gameObjectQuads['hearts'][1], healthX, healthY)
        healthX = healthX + 11
    end

    -- render missing health
    for i = 1, 3 - health do 
        love.graphics.draw(gameTextures['hearts'], gameObjectQuads['hearts'][2], healthX, healthY)
        healthX = healthX + 11
    end
end

function renderScore(score)
    local scoreX = VIRTUAL_WIDTH - 80
    local scoreY = 4

    -- render the score
    love.graphics.setFont(gameFonts['tiny'])
    love.graphics.print('score: '..tostring(score), scoreX, scoreY)
end


--[[
    loads highscore from a .lst file, saved in LOVE2D's default save directory in a subfolder
    called 'breakout'.
]]--

function loadHighScores()
    love.filesystem.setIdentity('breakout')

    -- if the file doesnt exist, intialize it with some default scores 
    if not love.filesystem.getInfo('breakout.lst') then
        local scores = '' -- the scores must be string type
        for i = 10, 1, -1 do
            scores = scores..'CTO\n'
            scores = scores..tostring(i * 100)..'\n'
        end

        -- write the scores in file
        love.filesystem.write('breakout.lst', scores)
    end

    --
    -- reading the high score data from file and store it in a table
    --
    -- flag for whether we are reading a name or not
    local isReadingName = true
    local currentName = nil
    local counter = 1
    -- initialize scores table with at least 10 blank entries
    local scores = {}
    
    for i = 1, 10 do
        -- init blank table; each will hold a name and a score
        scores[i] = {
            name = nil,
            score = nil
        }
    end

    -- iterate over each line in the file, filling in name and score in scores table
    for line in love.filesystem.lines('breakout.lst') do
        if isReadingName then
            -- read the first 3 character (maximum name length) from the line
            scores[counter]['name'] = string.sub(line, 1, 3)
            isReadingName = false
        else
            scores[counter]['score'] = tonumber(line)
            -- when we read the score line then we have finished read data of 1 player
            counter = counter + 1
            -- change name flag to true because the next line will be player name
            isReadingName = true 
        end
    end

    return scores
end