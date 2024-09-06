-- libraries
push = require "lib/push"
require "lib/class"
require "lib/BaseState"
require "lib/StateMachine"

-- constants
require "src/constants"
-- utility
require "src/util"

-- game states
require "src/game-state/start-state"
require "src/game-state/play-state"

-- class and entities
require "src/class/background"
require "src/class/alien"

gameTextures = {
    -- backgrounds
    ['background-grass-land'] = love.graphics.newImage("asset/background/grass-land.png"),
    ['background-toons'] = love.graphics.newImage("asset/background/toons.png"),
    ['background-halls'] = love.graphics.newImage("asset/background/halls.png"),
    ['background-halloween'] = love.graphics.newImage("asset/background/halloween.png"),
    ['background-easter-eggs'] = love.graphics.newImage("asset/background/easter-eggs.png"),
    -- aliens
    ['aliens'] = love.graphics.newImage("asset/tilesheet/aliens.png"),
    -- obstacle
    ['wood-obstacle'] = love.graphics.newImage("asset/tilesheet/wood.png"),
    ['stone-obstacle'] = love.graphics.newImage("asset/tilesheet/stone.png"),
    ['metal-obstacle'] = love.graphics.newImage("asset/tilesheet/metal.png")
}

gameFrames = {
    -- alien
    ['aliens'] = GenerateQuads(gameTextures['aliens'], 35, 35),
    -- obstacle
    -- wood obstacle
    ['wood-obstacle'] = {love.graphics.newQuad(0, 0, 110, 35, gameTextures['wood-obstacle']:getDimensions()),
                         love.graphics.newQuad(0, 35, 110, 35, gameTextures['wood-obstacle']:getDimensions()),
                         love.graphics.newQuad(320, 180, 35, 110, gameTextures['wood-obstacle']:getDimensions()),
                         love.graphics.newQuad(355, 355, 35, 110, gameTextures['wood-obstacle']:getDimensions())},
    -- stone obstacle
    ['stone-obstacle'] = {love.graphics.newQuad(0, 0, 110, 35, gameTextures['stone-obstacle']:getDimensions()),
                          love.graphics.newQuad(0, 35, 110, 35, gameTextures['stone-obstacle']:getDimensions()),
                          love.graphics.newQuad(320, 180, 35, 110, gameTextures['stone-obstacle']:getDimensions()),
                          love.graphics.newQuad(355, 355, 35, 110, gameTextures['stone-obstacle']:getDimensions())},
    -- metal obstacle
    ['metal-obstacle'] = {love.graphics.newQuad(0, 0, 110, 35, gameTextures['metal-obstacle']:getDimensions()),
                          love.graphics.newQuad(0, 35, 110, 35, gameTextures['metal-obstacle']:getDimensions()),
                          love.graphics.newQuad(320, 180, 35, 110, gameTextures['metal-obstacle']:getDimensions()),
                          love.graphics.newQuad(355, 355, 35, 110, gameTextures['metal-obstacle']:getDimensions())}
}

-- init game font family and size
gameFonts = {
    ['small'] = love.graphics.newFont('font/angry-bird-official.ttf', 8),
    ['medium'] = love.graphics.newFont('font/angry-bird-official.ttf', 16),
    ['large'] = love.graphics.newFont('font/angry-bird-official.ttf', 32),
    ['huge'] = love.graphics.newFont('font/angry-bird-official.ttf', 64)
}
