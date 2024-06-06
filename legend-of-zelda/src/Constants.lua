VIRTUAL_WIDTH = 384
VIRTUAL_HEIGHT = 216

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

TILE_WIDTH = 16
TILE_HEIGHT = 16

-- textures
gameTextures = {
    ['background'] = love.graphics.newImage("assets/images/background-2.png"),
    ['map-tilesheet'] = love.graphics.newImage("assets/images/tilesheet.png")
}

-- fonts
gameFonts = {
    ['default-small'] = love.graphics.newFont("assets/fonts/Default.ttf", 8),
    ['default-medium'] = love.graphics.newFont("assets/fonts/Default.ttf", 16),
    ['default-large'] = love.graphics.newFont("assets/fonts/Default.ttf", 24),
    ['gothic-small'] = love.graphics.newFont("assets/fonts/GothicPixels.ttf", 8),
    ['gothic-medium'] = love.graphics.newFont("assets/fonts/GothicPixels.ttf", 16),
    ['gothic-large'] = love.graphics.newFont("assets/fonts/GothicPixels.ttf", 24),
    ['zelda-small'] = love.graphics.newFont("assets/fonts/Zelda.otf", 24),
    ['zelda-medium'] = love.graphics.newFont("assets/fonts/Zelda.otf", 32),
    ['zelda-large'] = love.graphics.newFont("assets/fonts/Zelda.otf", 40)
}

-- color pallete
gameColorPallete = {
    ["default"] = {255, 255, 255, 255},
    ["white"] = {255 / 255, 255 / 255, 255 / 255, 1},
    ["white-transparent"] = {255 / 255, 255 / 255, 255 / 255, 0.5},
    ["black"] = {0 / 255, 0 / 255, 0 / 255, 1}
}
