ScoreState = BaseState:extend()

local medalImages = {
    ['bronze'] = love.graphics.newImage('assets/medal-bronze.png'),
    ['silver'] = love.graphics.newImage('assets/medal-silver.png'),
    ['gold'] = love.graphics.newImage('assets/medal-gold.png'),
}

local rewardScore = {
    ['bronze'] = 10,
    ['silver'] = 20,
    ['gold'] = 20,
}

local gameOverImage = love.graphics.newImage('assets/gameover.png')

function ScoreState:init()
    self.score = 0
    self.bird = nil
    self.pipePairsList = {}
end

function ScoreState:enter(params)
    self.score = params.score
    self.bird = params.bird
    self.pipePairsList = params.pipePairsList
    isScrolling = false
end

function ScoreState:update(deltaTime)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gameStateMachine:change('countDown')    
    end
end

function ScoreState:render()
    -- render the bird
    self.bird:render()

    -- render each pipe pair in pipe pairs list
    for key, pipePairs in pairs(self.pipePairsList) do
        pipePairs:render()
    end

    love.graphics.draw(gameOverImage, VIRTUAL_WIDTH / 2 - gameOverImage:getWidth() / 2, 20)

    love.graphics.setFont(fontLarge)
    love.graphics.printf('Your score is: '..tostring(self.score), 0, 70, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(fontSmall)

    if self.score >= rewardScore.gold then
        love.graphics.printf('Congratulation! you have been awarded a gold medal', 100, 100, VIRTUAL_WIDTH - 200, 'center')
        love.graphics.draw(medalImages.gold, VIRTUAL_WIDTH / 2 - medalImages.gold:getWidth() / 2, 160 - medalImages.gold:getHeight() / 2)
    elseif self.score >= rewardScore.silver then
        love.graphics.printf('Congratulation! you have been awarded a silver medal', 100, 100, VIRTUAL_WIDTH - 200, 'center')
        love.graphics.draw(medalImages.silver, VIRTUAL_WIDTH / 2 - medalImages.silver:getWidth() / 2, 160 - medalImages.silver:getHeight() / 2)
    elseif self.score >= rewardScore.bronze then
        love.graphics.printf('Congratulation! you have been awarded a bronze medal', 100, 100, VIRTUAL_WIDTH - 200, 'center')
        love.graphics.draw(medalImages.bronze, VIRTUAL_WIDTH / 2 - medalImages.bronze:getWidth() / 2, 160 - medalImages.bronze:getHeight() / 2)
    end 

    love.graphics.printf('Press "Enter" to play again !', 0, 200, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Press "Q" to make the bird go up', 0, 220, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Press "P" to pause the game', 0, 240, VIRTUAL_WIDTH, 'center')
end