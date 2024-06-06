-- screen dimensions
VIRTUAL_WIDTH = 384
VIRTUAL_HEIGHT = 216

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

-- map dimensions
TILE_WIDTH = 16
TILE_HEIGHT = 16

MAP_WIDTH = VIRTUAL_WIDTH / TILE_WIDTH
MAP_HEIGHT = math.floor(VIRTUAL_HEIGHT / TILE_HEIGHT) - 1

MAP_OFFSET_TOP = VIRTUAL_HEIGHT - MAP_HEIGHT * TILE_HEIGHT

-- textures
gameTextures = {
    ['background'] = love.graphics.newImage("assets/images/background-2.png"),
    ['map-tile-sheet'] = love.graphics.newImage("assets/images/tilesheet.png")
}

-- quads
gameQuads = {
    ['map-tile-sheet'] = generateGameQuads(gameTextures['map-tile-sheet'], TILE_WIDTH, TILE_HEIGHT)
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

-- tile id
TILE_ID = {
    ['BLANK'] = 19,
    ['WALL'] = {
        ['TOP_LEFT_CONNER'] = 4,
        ['TOP_RIGHT_CONNER'] = 5,
        ['BOTTOM_LEFT_CONNER'] = 23,
        ['BOTTOM_RIGHT_CONNER'] = 24,
        ['TOP'] = {58, 59, 60},
        ['RIGHT'] = {78, 97, 116},
        ['BOTTOM'] = {79, 80, 81},
        ['LEFT'] = {77, 96, 115}
    },
    ['FLOOR'] = {7, 8, 9, 10, 11, 12, 13, 26, 27, 28, 29, 30, 31, 32, 45, 46, 47, 48, 49, 50, 51, 64, 65, 66, 67, 68,
                 69, 70, 88, 89, 107, 108}
}
