GAME_OBJECT_DEFINITIONS = {
    [GAME_OBJECT_NAME_KEYS.SWITCH] = {
        textureName = TEXTURE_KEYS.SWITCHES,
        quadName = QUADS_KEYS.SWITCHES,
        width = SWITCH_WIDTH,
        height = SWITCH_HEIGHT,
        states = {
            [SWITCH_STATE_VALUES.PRESSED] = {
                quadId = 1
            },
            [SWITCH_STATE_VALUES.UN_PRESSED] = {
                quadId = 2
            }
        },
        currentState = SWITCH_STATE_VALUES.UN_PRESSED,
        isSolid = false,
        collidable = true,
        hitbox = {
            offsetX = 2,
            offsetY = 2,
            width = 12,
            height = 6
        }
    }
}
