ENTITY_DEFINITIONS = {
    [ENTITY_NAME_KEYS.PLAYER] = {
        movingSpeed = PLAYER_MOVING_SPEED,
        animations = {
            [ENTITY_ANIMATION_KEYS.WALK_LEFT] = {
                frames = {14, 15, 16, 13},
                interval = 0.155,
                isLooping = true
            },
            [ENTITY_ANIMATION_KEYS.WALK_RIGHT] = {
                frames = {6, 7, 8, 5},
                interval = 0.15,
                isLooping = true
            },
            [ENTITY_ANIMATION_KEYS.WALK_DOWN] = {
                frames = {2, 3, 4, 1},
                interval = 0.15,
                isLooping = true
            },
            [ENTITY_ANIMATION_KEYS.WALK_UP] = {
                frames = {10, 11, 12, 9},
                interval = 0.15,
                isLooping = true
            },
            [ENTITY_ANIMATION_KEYS.IDLE_LEFT] = {
                frames = {13},
                isLooping = false
            },
            [ENTITY_ANIMATION_KEYS.IDLE_RIGHT] = {
                frames = {5},
                isLooping = false
            },
            [ENTITY_ANIMATION_KEYS.IDLE_DOWN] = {
                frames = {1},
                isLooping = false
            },
            [ENTITY_ANIMATION_KEYS.IDLE_UP] = {
                frames = {9},
                isLooping = false
            },
            [ENTITY_ANIMATION_KEYS.SWING_SWORD_LEFT] = {
                frames = {13, 14, 15, 16},
                interval = 0.05,
                isLooping = false
            },
            [ENTITY_ANIMATION_KEYS.SWING_SWORD_RIGHT] = {
                frames = {9, 10, 11, 12},
                interval = 0.05,
                isLooping = false
            },
            [ENTITY_ANIMATION_KEYS.SWING_SWORD_DOWN] = {
                frames = {1, 2, 3, 4},
                interval = 0.05,
                isLooping = false
            },
            [ENTITY_ANIMATION_KEYS.SWING_SWORD_UP] = {
                frames = {5, 6, 7, 8},
                interval = 0.05,
                isLooping = false
            }
        }
    },
    -- monster
    [ENTITY_NAME_KEYS.SKELETON] = {
        movingSpeed = SKELETON_SPEED,
        animations = {
            [ENTITY_ANIMATION_KEYS.WALK_LEFT] = {
                frames = {22, 23, 24, 23},
                interval = 0.2,
                isLooping = true
            },
            [ENTITY_ANIMATION_KEYS.WALK_RIGHT] = {
                frames = {34, 35, 36, 35},
                interval = 0.2,
                isLooping = true
            },
            [ENTITY_ANIMATION_KEYS.WALK_DOWN] = {
                frames = {10, 11, 12, 11},
                interval = 0.2,
                isLooping = true
            },
            [ENTITY_ANIMATION_KEYS.WALK_UP] = {
                frames = {46, 47, 48, 47},
                interval = 0.2,
                isLooping = true
            },
            [ENTITY_ANIMATION_KEYS.IDLE_LEFT] = {
                frames = {23},
                isLooping = false
            },
            [ENTITY_ANIMATION_KEYS.IDLE_RIGHT] = {
                frames = {35},
                isLooping = false
            },
            [ENTITY_ANIMATION_KEYS.IDLE_DOWN] = {
                frames = {11},
                isLooping = false
            },
            [ENTITY_ANIMATION_KEYS.IDLE_UP] = {
                frames = {47},
                isLooping = false
            }
        }
    },
    [ENTITY_NAME_KEYS.SLIME] = {
        movingSpeed = SLIME_SPEED,
        animations = {}
    },
    [ENTITY_NAME_KEYS.BAT] = {
        movingSpeed = BAT_SPEED,
        animations = {}
    },
    [ENTITY_NAME_KEYS.GHOST] = {
        movingSpeed = GHOST_SPEED,
        animations = {}
    },
    [ENTITY_NAME_KEYS.SPIDER] = {
        movingSpeed = SPIDER_SPEED,
        animations = {}
    }
}
