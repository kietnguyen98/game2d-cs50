-- size of the actual window 
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

-- size we are trying to emulate with push
VIRTUAL_WIDTH = 256
VIRTUAL_HEIGHT = 144


-- world
MAP_WIDTH = 40
MAP_HEIGHT = 20
SKY_MAX_INDEX = 8
PILAR_HEIGHT = 2

-- should be a value that JUMP_VELOCITY % GRAVITY_FORCE !== 0 
GRAVITY_FORCE = 9

-- tile's ID
GROUND_INDEX = 1
GROUND_TOPPER_INDEX = 2
SKY_INDEX = 3
BRICK_INDEX = 4

-- tile's size
TILE_WIDTH = 16
TILE_HEIGHT = 16

-- camera
cameraScroll = 0;

-- character
CHARACTER_WIDTH = 18
CHARACTER_HEIGHT = 18
CHARACTER_SPEED = 50
JUMP_VELOCITY = -250