PlayState = BaseState:extend()

GRAVITY = 1000

PIPE_PAIR_SPAWNER_DURATION = 2.5

function PlayState:init()
    -- init the bird object
    self.bird = Bird(VIRTUAL_WIDTH / 2, VIRTUAL_HEIGHT / 2)

    -- init pipe pair table
    self.pipePairsList = {}

    -- init pipe pair spawn timer
    self.pipePairSpawnDuration = 2.5  * math.random(90, 110) / 100
    
    self.pipePairSpawnTimer = self.pipePairSpawnDuration

    -- init score value
    self.score = 0

    -- init pipe lastY
    self.lastY = -PIPE_HEIGHT + math.random(100)

    -- init is pause 
    self.isPause = false

    self.isCountDown = false
    self.countdownCounter = 3
    self.countdownTimer = 0
end

function PlayState:enter()
    isScrolling = true
end

function PlayState:update(deltaTime)
    if not self.isPause and not self.isCountDown then
        -- update spawn timer
        self.pipePairSpawnTimer = self.pipePairSpawnTimer + deltaTime
        
        -- spawn new pipe pairs logic
        if self.pipePairSpawnTimer > self.pipePairSpawnDuration then
            local y = math.max(-PIPE_HEIGHT + 30, math.min(self.lastY + math.random(-30, 30), VIRTUAL_HEIGHT - PIPE_HEIGHT - GAP_HEIGHT - 30))
            self.lastY = y
            table.insert(self.pipePairsList, PipePair(y))
            self.pipePairSpawnTimer = 0
            self.pipePairSpawnDuration = 2.5 * math.random(8 ,12) / 10
        end

        -- update the bird
        self.bird:update(deltaTime)

        -- update every pipe pair in the pipe pair list
        for key, pipePair in pairs(self.pipePairsList) do
            pipePair:update(deltaTime)
            -- check if any pipe in this pipe pair collide with the bird
            for subKey, pipe in pairs(pipePair.pipes) do
                if self.bird:collides(pipe) then
                    -- change game state to score if the bird hit any pipe
                    sounds['explosion']:play()
                    sounds['hurt']:play()
                    gameStateMachine:change('score', 
                    { 
                        score = self.score,
                        bird = self.bird,
                        pipePairsList = self.pipePairsList
                    })                
                end
            end
        
            -- check if the bird collide with the coin between the pipe pair then score a point
            if pipePair.coin and self.bird:collides(pipePair.coin) then
                if not pipePair.coin.scored then
                    self.score = self.score + 1
                    pipePair.coin.scored = true
                    pipePair.coin = nil
                    sounds['score']:play()    
                end
            end
        end

        -- remove pipe pair which a out of game screen
        for key, pipePair in pairs(self.pipePairsList) do
            if pipePair.remove then
                table.remove(self.pipePairsList, key)
            end
        end

        -- change game state to score if the bird fail down to the grown
        if self.bird.y + self.bird.height >= VIRTUAL_HEIGHT - 15 then
            sounds['explosion']:play()
            sounds['hurt']:play()
            gameStateMachine:change('score', 
            { 
                score = self.score,
                bird = self.bird,
                pipePairsList = self.pipePairsList
            })     
        end  
    end

    -- pause game logic
    if love.keyboard.wasPressed('p') then
        if not self.isPause then
            -- change play state to pause state
            if not self.isCountDown then
                self.isPause = true
            end
        elseif not self.isCountDown then
            -- change pause state to countdown state
            self.isPause = false
            self.isCountDown = true
        end

    end
    -- check if the game is pause or countdown then skip background scrolling
    if self.isPause or self.isCountDown then
        if isScrolling then
            isScrolling = false
        end
    end

    if self.isCountDown then
        self.countdownTimer = self.countdownTimer + deltaTime
        if self.countdownTimer > COUNTDOWN_TIME then
            self.countdownCounter = self.countdownCounter - 1
            self.countdownTimer = 0
        end

        if self.countdownCounter == 0 then
            -- resume the game
            self.isCountDown = false
            -- reset countdown values for the next pause game
            self:countdownReset()
        end
    end
end

function PlayState:render()
    -- render each pipe pair in pipe pairs list
    for key, pipePairs in pairs(self.pipePairsList) do
        pipePairs:render()
    end

    -- render the bird
    self.bird:render()

    -- render the score on the top right of the screen
    love.graphics.setFont(fontMedium)
    love.graphics.print('Score: '..tostring(self.score), VIRTUAL_WIDTH - 120, 5)

    -- render pause text
    if self.isPause then
        love.graphics.setFont(fontLarge)
        love.graphics.printf('The game is Paused...', 0, 60, VIRTUAL_WIDTH, 'center')
    
        love.graphics.setFont(fontMedium)
        love.graphics.printf('Press "P" to continue', 0, 160, VIRTUAL_WIDTH, 'center')
    end

    -- render countdown text
    if self.isCountDown then
        love.graphics.setFont(fontMedium)
        love.graphics.printf('continue in: ', 0, 60, VIRTUAL_WIDTH, 'center')
    
        love.graphics.setFont(fontExtraLarge)
        love.graphics.printf(tostring(self.countdownCounter), 0, 100, VIRTUAL_WIDTH, 'center')
    end
end

function PlayState:countdownReset()
    self.countdownCounter = 3
    self.countdownTimer = 0
end