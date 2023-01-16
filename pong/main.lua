-- library import
push = require "push" 

require "class"

require "Ball"

require "Wall"

require "Paddle"
-- path declare
AMERICAN_FONT_PATH = "fonts/AmericanCaptain.ttf"
-- constant declare
-- exact window size
WINDOW_WIDTH = 1024
WINDOW_HEIGHT = 768
-- virtual window size 
VIRTUAL_WIDTH = 320
VIRTUAL_HEIGHT = 240
-- player moving paddle speed
PADDLE_SPEED = 200
-- ball max speed
BALL_MAX_SPEED = 200
-- define max winning point
WINNING_POINT = 3
-- game state
GAME_STATE_VALUES = {
    START = 'start',
    SERVE = 'serve',
    PLAY =  'play',
    FINISHED = 'finished'
}
-- define game wall setting values
TOP_WALL_SEGMENT = 40
OTHER_WALL_SEGMENT = 5
WALL_THICKNESS = 2
-- define game mode
GAME_MODE_VALUES = {
    ONE_PLAYER = 'one player',
    TWO_PLAYERS = 'two players'
}

-- load initial config
function love.load()
    
    love.graphics.setDefaultFilter('nearest', 'nearest')
    
    love.window.setTitle("Pong")

    math.randomseed(os.time())

    -- font
    retroFont = love.graphics.newFont(AMERICAN_FONT_PATH, 16)
    smallFont = love.graphics.newFont(AMERICAN_FONT_PATH, 12)
    scoreFont = love.graphics.newFont(AMERICAN_FONT_PATH, 26)
    bigFont = love.graphics.newFont(AMERICAN_FONT_PATH, 24)

    -- audio
    sounds = {
        ['paddle_hit'] = love.audio.newSource('sounds/paddle_hit.wav', 'static'),
        ['wall_hit'] = love.audio.newSource('sounds/wall_hit.wav', 'static'),
        ['scores_up'] = love.audio.newSource('sounds/scores_up.wav', 'static'),
    }

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })

    -- player scores variables
    player1Score = 0
    player2Score = 0

    -- init walls
    topWall = Wall(OTHER_WALL_SEGMENT, TOP_WALL_SEGMENT, VIRTUAL_WIDTH - 2 * OTHER_WALL_SEGMENT, WALL_THICKNESS)
    bottomWall = Wall(OTHER_WALL_SEGMENT, VIRTUAL_HEIGHT - OTHER_WALL_SEGMENT - WALL_THICKNESS, VIRTUAL_WIDTH - 2 * OTHER_WALL_SEGMENT, WALL_THICKNESS)
    leftWall = Wall(OTHER_WALL_SEGMENT, TOP_WALL_SEGMENT, WALL_THICKNESS, VIRTUAL_HEIGHT - TOP_WALL_SEGMENT - OTHER_WALL_SEGMENT)
    rightWall = Wall(VIRTUAL_WIDTH - OTHER_WALL_SEGMENT - WALL_THICKNESS, TOP_WALL_SEGMENT, WALL_THICKNESS, VIRTUAL_HEIGHT - TOP_WALL_SEGMENT - OTHER_WALL_SEGMENT)
   
    -- int paddle for each player
    paddleSize = {
        width = 5,
        height = 20
    }

    player1StartPosition = {
        x = 10,
        y = 50
    }

    player2StartPosition = {
        x = VIRTUAL_WIDTH - 10 - paddleSize.width,
        y = VIRTUAL_HEIGHT - 50
    }

    player1 = Paddle(player1StartPosition.x, player1StartPosition.y, paddleSize.width , paddleSize.height)
    player2 = Paddle(player2StartPosition.x, player2StartPosition.y, paddleSize.width , paddleSize.height)

    -- init ball
    ball = Ball((leftWall.x + rightWall.x) / 2 - 2, (bottomWall.y + topWall.y) / 2 - 2, 4, 4)

    -- init scored player
    scoredPlayer = 0

    -- init wining player
    winningPlayer = 0

    -- init game state
    gameState = GAME_STATE_VALUES.START

    -- init game mode state
    isChoosingGameMode = false
    gameMode = GAME_MODE_VALUES.TWO_PLAYERS
end

-- update function, update game state per frame
function love.update(deltaTime)
    -- player move paddle
    -- player 1 move
    if gameMode == GAME_MODE_VALUES.TWO_PLAYERS then
        if love.keyboard.isDown("w") then
            player1.dy = -PADDLE_SPEED
        elseif love.keyboard.isDown("s") then
            player1.dy = PADDLE_SPEED
        else 
            player1.dy = 0
        end    
    end

    -- player 2 move
    if love.keyboard.isDown("up") then
        player2.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown("down") then
        player2.dy = PADDLE_SPEED 
    else
        player2.dy = 0  
    end

    -- logic while the game is playing
    if gameState == GAME_STATE_VALUES.SERVE then
        if scoredPlayer == 1 then
            ball.dx = -math.random(100, 120)
        elseif scoredPlayer == 2 then
            ball.dx = math.random(100, 120)
        end
        ball.dy = math.random(2) == 1 and -math.random(20, 60) or math.random(20, 60)
    elseif gameState == GAME_STATE_VALUES.PLAY then
        ball:update(deltaTime)

        -- check if the ball collide with paddle
        if ball:isCollide(player1) or ball:isCollide(player2)
        then
            sounds.paddle_hit:play()
            if ball:isCollide(player1)
            then
                ball:reverseVelocity(player1)
                ball.x = player1.x + player1.width
            elseif ball:isCollide(player2)
            then
                ball:reverseVelocity(player1)
                ball.x = player2.x - ball.width
            end
        end

        -- update the ball if it collide with the top wall
        if ball:isCollide(topWall) then
            sounds.wall_hit:play()
            ball.y = topWall.y + topWall.height
            ball.dy = -ball.dy
        end

        -- update the ball if it collide with the bottom wall
        if ball:isCollide(bottomWall) then
            sounds.wall_hit:play()
            ball.y = bottomWall.y - ball.height
            ball.dy = -ball.dy
        end

        -- update the score when the ball go out right side and left side
        if ball.x <= leftWall.x or ball.x + ball.width >= rightWall.x + rightWall.width then
            if ball.x <= leftWall.x then
                sounds.scores_up:play()
                scoredPlayer = 2
                player2Score = player2Score + 1
            end
            
            if ball.x + ball.width >= rightWall.x + rightWall.width then
                sounds.scores_up:play()
                scoredPlayer = 1
                player1Score = player1Score + 1
            end

            -- reset ball position
            ball:reset()
            -- reset paddle position
            -- player 1
            player1.x = player1StartPosition.x
            player1.y = player1StartPosition.y
            -- player 2
            player2.x = player2StartPosition.x
            player2.y = player2StartPosition.y
            
            -- update game state
            if player1Score == WINNING_POINT then
                winningPlayer = 1
                gameState = GAME_STATE_VALUES.FINISHED
            elseif player2Score == WINNING_POINT then
                winningPlayer = 2
                gameState = GAME_STATE_VALUES.FINISHED
            else
                gameState = GAME_STATE_VALUES.SERVE
            end
        end

        if gameMode == GAME_MODE_VALUES.ONE_PLAYER then
            player1:selfUpdate(deltaTime)
        else
            player1:update(deltaTime)
        end
        player2:update(deltaTime)
    end
end

-- draw screen per frame
function love.draw()
    -- begin redering at virtual resolution
    push:apply('start')

    
    love.graphics.clear(0.157, 0.176, 0.204, 1)

    if isChoosingGameMode then
        -- render the game mode menu
        love.graphics.setColor(0, 1, 0, 1)
        love.graphics.setFont(retroFont)
        love.graphics.print('Choosing game mode:', 0, VIRTUAL_HEIGHT / 2 - 40, VIRTUAL_WIDTH, 'center')
        love.graphics.print('1 Player (Play with AI): Press key "1"', VIRTUAL_WIDTH / 2 - 100, VIRTUAL_HEIGHT / 2 - 10, VIRTUAL_WIDTH, 'left')
        love.graphics.print('2 PLayers: Press key "2"', VIRTUAL_WIDTH / 2 - 100, VIRTUAL_HEIGHT / 2 + 10, VIRTUAL_WIDTH, 'left')
        love.graphics.print('return to main screen: Press key "0"', VIRTUAL_WIDTH / 2 - 100, VIRTUAL_HEIGHT / 2 + 30, VIRTUAL_WIDTH, 'left')
    else
        -- render welcome text
        if gameState == GAME_STATE_VALUES.START then
            love.graphics.setFont(bigFont)
            love.graphics.print('Hello Pong', 0, VIRTUAL_HEIGHT / 2 - 40, VIRTUAL_WIDTH, 'center')
            love.graphics.setFont(retroFont)
            love.graphics.print('press "Enter" to play !', 0, VIRTUAL_HEIGHT / 2 - 10, VIRTUAL_WIDTH, 'center')
            love.graphics.setColor(0, 1, 0, 1)
            love.graphics.print('current game mode: '..tostring(gameMode), 0, VIRTUAL_HEIGHT / 2 + 20, VIRTUAL_WIDTH, 'center')
            love.graphics.print('press "M" key to enter game mode !', 0, VIRTUAL_HEIGHT / 2 + 35, VIRTUAL_WIDTH, 'center')
        elseif gameState == GAME_STATE_VALUES.PLAY then
            love.graphics.setFont(smallFont)
            love.graphics.print('playing...', 0, 5, VIRTUAL_WIDTH, 'center')
        elseif gameState == GAME_STATE_VALUES.SERVE then
            love.graphics.setFont(smallFont)
            love.graphics.print('Player '..tostring(scoredPlayer)..' just scored ! - press "Enter" to continue', 0, 5, VIRTUAL_WIDTH, 'center')
        elseif gameState == GAME_STATE_VALUES.FINISHED then
            love.graphics.setFont(bigFont)
            love.graphics.print('Player '..tostring(winningPlayer)..' wins the game !', 0, VIRTUAL_HEIGHT / 2 - 40, VIRTUAL_WIDTH, 'center')
            love.graphics.setFont(retroFont)
            love.graphics.print('press "Enter" to restart !', 0, VIRTUAL_HEIGHT / 2 - 10, VIRTUAL_WIDTH, 'center')
        end

        if gameState ~= GAME_STATE_VALUES.START and gameState ~= GAME_STATE_VALUES.FINISHED then
              -- render the scores
            love.graphics.setFont(scoreFont)
            love.graphics.setColor(1, 0, 0, 1)
            love.graphics.print(tostring(player1Score), 40, 10)
            love.graphics.setColor(0, 0, 1, 1)
            love.graphics.print(tostring(player2Score), VIRTUAL_WIDTH - 40, 10)

            love.graphics.setColor(1, 1, 1, 1)

            -- render guide text
            love.graphics.setFont(smallFont)
            love.graphics.print('The first player to score '..tostring(WINNING_POINT)..' points will win !', 0, 20, VIRTUAL_WIDTH, 'center')

            -- render walls
            -- top walls
            topWall:render()
            bottomWall:render()
            leftWall:render()
            rightWall:render()

            -- render first paddle, left side
            player1:render()

            -- render second paddle, right side
            player2:render()

            -- render ball, center
            ball:render()

            -- display fps
            -- displayFPS()
        end
    end
  
    -- end rendering at virtual resolution
    push:apply('end')
end

-- input event
function love.keypressed(key)
    -- general event
    if key == "escape" then
        love.event.quit()
    elseif key == "space" then
        if gameState == GAME_STATE_VALUES.PLAY or GAME_STATE_VALUES.SERVE then
            gameRestart()
        end      
    elseif key == "m" then
        if gameState == GAME_STATE_VALUES.START and not isChoosingGameMode then
            isChoosingGameMode = true
        end
    elseif key == "enter" or key == "return" then
        if gameState == GAME_STATE_VALUES.START or gameState == GAME_STATE_VALUES.SERVE then
            gameState = GAME_STATE_VALUES.PLAY
        elseif gameState == GAME_STATE_VALUES.FINISHED then
            gameRestart()
        elseif gameState ~= GAME_STATE_VALUES.PLAY then
            ball:reset()
            gameState = GAME_STATE_VALUES.START
        end
    end

    -- menu setting event
    if key == "1" then
        gameMode = GAME_MODE_VALUES.ONE_PLAYER
        isChoosingGameMode = false
    elseif key == "2" then
        gameMode = GAME_MODE_VALUES.TWO_PLAYERS
        isChoosingGameMode = false
    elseif key == "0" then
        isChoosingGameMode = false
    end
end

function displayFPS()
    love.graphics.setFont(smallFont)
    love.graphics.setColor(0, 1, 0, 1)
    -- print fps on the top left of the screen
    love.graphics.print("FPS: "..tostring(love.timer.getFPS()), 5, 5)
end

function love.resize(width, height)
    push:resize(width, height)
end

function gameRestart()
    player1Score = 0
    player2Score = 0
    ball:reset()
    gameState = GAME_STATE_VALUES.START
end