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

-- entity texture keys
TEXTURE_KEYS = {
    ['BACKGROUND'] = 'background',
    ['MAP_TILE'] = 'map-tile-sheet',
    ['PLAYER_WALK'] = 'player-walk-sheet',
    ['PLAYER_SWING_SWORD'] = 'player-swing-sword-sheet',
    ['ENTITIES'] = 'entities-sheet'
}
-- entity quads keys
QUADS_KEYS = {
    ['MAP_TILE'] = 'map-tile',
    ['PLAYER_WALK'] = 'player-walk',
    ['PLAYER_SWING_SWORD'] = 'player-swing-sword',
    ['ENTITIES'] = 'entities'
}
-- keyboard button values
KEYBOARD_BUTTON_VALUES = {
    ['ESC'] = 'esc',
    ['ENTER'] = 'enter',
    ['RETURN'] = 'return',
    ['UP'] = 'up',
    ['DOWN'] = 'down',
    ['LEFT'] = 'left',
    ['RIGHT'] = 'right',
    ['SPACE'] = 'space'
}

-- entity name keys
ENTITY_NAME_KEYS = {
    ['PLAYER'] = 'player',
    ['SKELETON'] = 'skeleton',
    ['SLIME'] = 'slime',
    ['BAT'] = 'bat',
    ['GHOST'] = 'ghost',
    ['SPIDER'] = 'spider'
}

-- entity state keys
ENTITY_STATE_KEYS = {
    ['IDLE'] = "idle",
    ['MOVING'] = "moving",
    ['SWING_SWORD'] = "swing-sword"
}
-- entity animation keys
ENTITY_ANIMATION_KEYS = {
    ['IDLE_DOWN'] = "idle_down",
    ['IDLE_LEFT'] = "idle_left",
    ['IDLE_RIGHT'] = "idle_right",
    ['IDLE_UP'] = "idle_up",
    ['WALK_DOWN'] = "walk_down",
    ['WALK_LEFT'] = "walk_left",
    ['WALK_RIGHT'] = "walk_right",
    ['WALK_UP'] = "walk_up",
    ['SWING_SWORD_DOWN'] = "swing_sword_down",
    ['SWING_SWORD_LEFT'] = "swing_sword_left",
    ['SWING_SWORD_RIGHT'] = "swing_sword_right",
    ['SWING_SWORD_UP'] = "swing_sword_up"
}

-- entity directions
ENTITY_DIRECTION_VALUES = {
    ['UP'] = "up",
    ['DOWN'] = "down",
    ['LEFT'] = "left",
    ['RIGHT'] = "right"
}

-- character attributes
PLAYER_WALK_WIDTH = 16
PLAYER_WALK_HEIGHT = 32
PLAYER_SWING_SWORD_WIDTH = 32
PLAYER_SWING_SWORD_HEIGHT = 32
PLAYER_MOVING_SPEED = 40

-- entity attributes
ENTITY_WIDTH = 16
ENTITY_HEIGHT = 16
SKELETON_SPEED = 15
SLIME_SPEED = 8
BAT_SPEED = 12
GHOST_SPEED = 14
SPIDER_SPEED = 10

-- textures
gameTextures = {
    [TEXTURE_KEYS.BACKGROUND] = love.graphics.newImage("assets/images/background-2.png"),
    [TEXTURE_KEYS.MAP_TILE] = love.graphics.newImage("assets/images/tilesheet.png"),
    [TEXTURE_KEYS.PLAYER_WALK] = love.graphics.newImage("assets/images/character-walk.png"),
    [TEXTURE_KEYS.PLAYER_SWING_SWORD] = love.graphics.newImage("assets/images/character-swing-sword.png"),
    [TEXTURE_KEYS.ENTITIES] = love.graphics.newImage("assets/images/entities.png")
}

-- quads
gameQuads = {
    [QUADS_KEYS.MAP_TILE] = generateGameQuads(gameTextures['map-tile-sheet'], TILE_WIDTH, TILE_HEIGHT),
    [QUADS_KEYS.PLAYER_WALK] = generateGameQuads(gameTextures['player-walk-sheet'], PLAYER_WALK_WIDTH,
        PLAYER_WALK_HEIGHT),
    [QUADS_KEYS.PLAYER_SWING_SWORD] = generateGameQuads(gameTextures['player-swing-sword-sheet'],
        PLAYER_SWING_SWORD_WIDTH, PLAYER_SWING_SWORD_HEIGHT),
    [QUADS_KEYS.ENTITIES] = generateGameQuads(gameTextures['entities-sheet'], ENTITY_WIDTH, ENTITY_HEIGHT)
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
