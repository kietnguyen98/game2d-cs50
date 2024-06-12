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
        },
        hitbox = {
            offsetX = 1,
            offsetY = 7,
            width = 13,
            height = 18
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
        },
        hitbox = {
            offsetX = 3,
            offsetY = 1,
            width = 10,
            height = 15
        }
    },
    [ENTITY_NAME_KEYS.SLIME] = {
        movingSpeed = SLIME_SPEED,
        animations = {
            [ENTITY_ANIMATION_KEYS.WALK_LEFT] = {
                frames = {61, 62, 63, 62},
                interval = 0.2,
                isLooping = true
            },
            [ENTITY_ANIMATION_KEYS.WALK_RIGHT] = {
                frames = {73, 74, 75, 74},
                interval = 0.2,
                isLooping = true
            },
            [ENTITY_ANIMATION_KEYS.WALK_DOWN] = {
                frames = {49, 50, 51, 50},
                interval = 0.2,
                isLooping = true
            },
            [ENTITY_ANIMATION_KEYS.WALK_UP] = {
                frames = {86, 87, 86, 87},
                interval = 0.2,
                isLooping = true
            },
            [ENTITY_ANIMATION_KEYS.IDLE_LEFT] = {
                frames = {62},
                isLooping = false
            },
            [ENTITY_ANIMATION_KEYS.IDLE_RIGHT] = {
                frames = {74},
                isLooping = false
            },
            [ENTITY_ANIMATION_KEYS.IDLE_DOWN] = {
                frames = {50},
                isLooping = false
            },
            [ENTITY_ANIMATION_KEYS.IDLE_UP] = {
                frames = {86},
                isLooping = false
            }
        },
        hitbox = {
            offsetX = 0,
            offsetY = 5,
            width = 16,
            height = 10
        }
    },
    [ENTITY_NAME_KEYS.BAT] = {
        movingSpeed = BAT_SPEED,
        animations = {
            [ENTITY_ANIMATION_KEYS.WALK_LEFT] = {
                frames = {64, 65, 66, 65},
                interval = 0.2,
                isLooping = true
            },
            [ENTITY_ANIMATION_KEYS.WALK_RIGHT] = {
                frames = {76, 77, 78, 77},
                interval = 0.2,
                isLooping = true
            },
            [ENTITY_ANIMATION_KEYS.WALK_DOWN] = {
                frames = {52, 53, 54, 53},
                interval = 0.2,
                isLooping = true
            },
            [ENTITY_ANIMATION_KEYS.WALK_UP] = {
                frames = {88, 89, 90, 89},
                interval = 0.2,
                isLooping = true
            },
            [ENTITY_ANIMATION_KEYS.IDLE_LEFT] = {
                frames = {64, 65, 66, 65},
                interval = 0.2,
                isLooping = true
            },
            [ENTITY_ANIMATION_KEYS.IDLE_RIGHT] = {
                frames = {76, 77, 78, 77},
                interval = 0.2,
                isLooping = true
            },
            [ENTITY_ANIMATION_KEYS.IDLE_DOWN] = {
                frames = {52, 53, 54, 53},
                interval = 0.2,
                isLooping = true
            },
            [ENTITY_ANIMATION_KEYS.IDLE_UP] = {
                frames = {88, 89, 90, 89},
                interval = 0.2,
                isLooping = true
            }
        },
        hitbox = {
            offsetX = 2,
            offsetY = 2,
            width = 12,
            height = 8
        }
    },
    [ENTITY_NAME_KEYS.GHOST] = {
        movingSpeed = GHOST_SPEED,
        animations = {
            [ENTITY_ANIMATION_KEYS.WALK_LEFT] = {
                frames = {67, 68, 69, 68},
                interval = 0.2,
                isLooping = true
            },
            [ENTITY_ANIMATION_KEYS.WALK_RIGHT] = {
                frames = {79, 80, 81, 80},
                interval = 0.2,
                isLooping = true
            },
            [ENTITY_ANIMATION_KEYS.WALK_DOWN] = {
                frames = {55, 56, 57, 56},
                interval = 0.2,
                isLooping = true
            },
            [ENTITY_ANIMATION_KEYS.WALK_UP] = {
                frames = {91, 92, 93, 92},
                interval = 0.2,
                isLooping = true
            },
            [ENTITY_ANIMATION_KEYS.IDLE_LEFT] = {
                frames = {68},
                isLooping = false
            },
            [ENTITY_ANIMATION_KEYS.IDLE_RIGHT] = {
                frames = {80},
                isLooping = false
            },
            [ENTITY_ANIMATION_KEYS.IDLE_DOWN] = {
                frames = {56},
                isLooping = false
            },
            [ENTITY_ANIMATION_KEYS.IDLE_UP] = {
                frames = {92},
                isLooping = false
            }
        },
        hitbox = {
            offsetX = 2,
            offsetY = 0,
            width = 12,
            height = 13
        }
    },
    [ENTITY_NAME_KEYS.SPIDER] = {
        movingSpeed = SPIDER_SPEED,
        animations = {
            [ENTITY_ANIMATION_KEYS.WALK_LEFT] = {
                frames = {70, 71, 72, 71},
                interval = 0.2,
                isLooping = true
            },
            [ENTITY_ANIMATION_KEYS.WALK_RIGHT] = {
                frames = {82, 83, 84, 83},
                interval = 0.2,
                isLooping = true
            },
            [ENTITY_ANIMATION_KEYS.WALK_DOWN] = {
                frames = {58, 59, 60, 59},
                interval = 0.2,
                isLooping = true
            },
            [ENTITY_ANIMATION_KEYS.WALK_UP] = {
                frames = {94, 95, 96, 95},
                interval = 0.2,
                isLooping = true
            },
            [ENTITY_ANIMATION_KEYS.IDLE_LEFT] = {
                frames = {71},
                isLooping = false
            },
            [ENTITY_ANIMATION_KEYS.IDLE_RIGHT] = {
                frames = {83},
                isLooping = false
            },
            [ENTITY_ANIMATION_KEYS.IDLE_DOWN] = {
                frames = {59},
                isLooping = false
            },
            [ENTITY_ANIMATION_KEYS.IDLE_UP] = {
                frames = {95},
                isLooping = false
            }
        },
        hitbox = {
            offsetX = 3,
            offsetY = 8,
            width = 10,
            height = 6
        }
    }
}
