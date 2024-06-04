-- size of the actual window 
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

-- size we are trying to emulate with push
VIRTUAL_WIDTH = 256
VIRTUAL_HEIGHT = 144

-- world
MAP_WIDTH = 16 * 7
MAP_HEIGHT = 9
SKY_MAX_INDEX = 8
TOP_BRICK_Y_POSITION = 4
PILAR_HEIGHT = 1

-- should be a value that CHARACTER_JUMP_VELOCITY % GRAVITY !== 0 
GRAVITY = 9

-- tile's ID
GROUND_INDEX = 1
GROUND_TOPPER_INDEX = 2
BRICK_INDEX = 3
BRICK_QUESTION_INDEX = {
    [0] = 4,
    [1] = 5,
    [2] = 6
}
COIN_INDEX = 7
BUSH_INDEX = 8
PLUMP_INDEX = 9
BLANK_INDEX = 99

COLLIDABLE_TILE_INDEX = {GROUND_INDEX, GROUND_TOPPER_INDEX, BRICK_INDEX, BRICK_QUESTION_INDEX}

-- tile's size
TILE_WIDTH = 16
TILE_HEIGHT = 16

-- game object's size
GAME_OBJECT_WIDTH = 16
GAME_OBJECT_HEIGHT = 16

-- camera
cameraScroll = 0;

-- main character attributes
CHARACTER_WIDTH = 16
CHARACTER_HEIGHT = 18
CHARACTER_SPEED = 60
CHARACTER_JUMP_VELOCITY = -220
CHARACTER_BOUNCE_BACK_VELOCITY = 80
CHARACTER_BOUNCE_BACK_RESISTANCE_VELOCITY = 3
CHARACTER_BOUNCE_UP_VELOCITY = CHARACTER_JUMP_VELOCITY * 2 / 3
CHARACTER_RGB_COLOR_SHEET = {
    ['default'] = {255, 255, 255, 255},
    ['red'] = {255 / 255, 51 / 255, 51 / 255, 0.5},
    ['transparent'] = {255 / 255, 255 / 255, 255 / 255, 0.5}
}

-- enemies attributes
-- mushroom
MUSHROOM_WIDTH = 18
MUSHROOM_HEIGHT = 16
MUSHROOM_SHRINK_HEIGHT = 8
MUSHROOM_SCALE_RATIO = 3 / 4
MUSHROOM_MOVING_SPEED = 6
MUSHROOM_CHASING_SPEED = 10
MUSHROOM_CHASING_WIDTH_RANGE = 5

-- turtle 
TURTLE_DEFAULT_WIDTH = 18
TURTLE_DEFAULT_HEIGHT = 24
TURTLE_SHRINK_WIDTH = 18
TURTLE_SHRINK_HEIGHT = 16
TURTLE_SCALE_RATIO = 2 / 3
TURTLE_MOVING_SPEED = 12
TURTLE_CHASING_SPEED = 16
TURTLE_CHASING_WIDTH_RANGE = 4

-- cannibal
CANNIBAL_WIDTH = 18
CANNIBAL_HEIGHT = 24
CANNIBAL_SCALE_RATIO = 3 / 4
CANNIBAL_ATTACK_WIDTH_RANGE = 3
