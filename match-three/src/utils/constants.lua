-- define exact virtual height for game screen used by push library
-- virtual dimensions
VIRTUAL_HEIGHT = 288
VIRTUAL_WIDTH = 512

-- window dimesions
WINDOW_HEIGHT = 720
WINDOW_WIDTH = 1280

-- background 
BACKGROUND_SCROLL_SPEED = 80

-- title
TILE_WIDTH = 32 
TILE_HEIGHT = 32

-- text
TextOptionColor = {
    ['NORMAL'] = {48/255, 155/255, 130/255, 1},
    ['HIGHT_LIGHT'] = {99/255, 155/255, 1, 1},
}

-- overlay
OverlayColor = {
    ['BLACK_BLUR'] = {56/255, 56/255, 56/255, 234/255},
    ['GREEN_BLUR'] = {95/255, 205/255, 228/255, 200/255},
    ['WHITE_BLUR'] = {255/255, 255/255, 255/255, 90/255}
}

GlobalColor = {
    ['RED'] = {230/255, 46/255, 20/255, 1},
    ['DARK_RED'] = {190/255, 10/255, 10/255, 0.95},
    ['LIGHT_GRAY'] = {140/255, 140/255, 140/255, 1},
    ['GRAY'] = {89/255, 89/255, 89/255, 1},
    ['DARK_GRAY'] = {64/255, 64/255, 64/255, 1},
    ['LIGHT_BLACK'] = {26/255, 26/255, 26/255, 1}
}

-- bricks particle colors pallete
PARTICLE_COLOR_PALLETES = {
    -- 18 palletes equal to 18 tile color
    [1] = {
        ['r'] = 217,
        ['g'] = 160,
        ['b'] = 102
    },
    [2] = {
        ['r'] = 217,
        ['g'] = 87,
        ['b'] = 99
    },
    [3] = {
        ['r'] = 138,
        ['g'] = 111,
        ['b'] = 48
    },
    [4] = {
        ['r'] = 217,
        ['g'] = 87,
        ['b'] = 99
    },
    [5] = {
        ['r'] = 82,
        ['g'] = 75,
        ['b'] = 36
    },
    [6] = {
        ['r'] = 172,
        ['g'] = 50,
        ['b'] = 50
    },
    [7] = {
        ['r'] = 75,
        ['g'] = 105,
        ['b'] = 47
    },
    [8] = {
        ['r'] = 102,
        ['g'] = 57,
        ['b'] = 49
    },
    [9] = {
        ['r'] = 55,
        ['g'] = 148,
        ['b'] = 110
    },
    [10] = {
        ['r'] = 143,
        ['g'] = 86,
        ['b'] = 59
    },
    [11] = {
        ['r'] = 91,
        ['g'] = 110,
        ['b'] = 225
    },
    [12] = {
        ['r'] = 223,
        ['g'] = 113,
        ['b'] = 38
    },
    [13] = {
        ['r'] = 48,
        ['g'] = 96,
        ['b'] = 130
    },
    [14] = {
        ['r'] = 132,
        ['g'] = 126,
        ['b'] = 135
    },
    [15] = {
        ['r'] = 63,
        ['g'] = 63,
        ['b'] = 116
    },
    [16] = {
        ['r'] = 105,
        ['g'] = 106,
        ['b'] = 106
    },
    [17] = {
        ['r'] = 118,
        ['g'] = 66,
        ['b'] = 138
    },
    [18] = {
        ['r'] = 89,
        ['g'] = 86,
        ['b'] = 82
    },
}