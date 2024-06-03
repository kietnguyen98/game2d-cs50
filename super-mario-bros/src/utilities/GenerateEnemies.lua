function GenerateEnemyMushroom(enemies, enemiesTileSheet, quads, tilesMap, objects, mainCharacter, colIndex)
    local mushroom
    mushroom = MushroomEntity({
        sheet = enemiesTileSheet,
        quads = quads,
        x = (colIndex - 1) * TILE_WIDTH,
        y = (SKY_MAX_INDEX - 1) * TILE_HEIGHT - MUSHROOM_HEIGHT * MUSHROOM_SCALE_RATIO,
        width = MUSHROOM_WIDTH * MUSHROOM_SCALE_RATIO,
        height = MUSHROOM_HEIGHT * MUSHROOM_SCALE_RATIO,
        scaleRatio = MUSHROOM_SCALE_RATIO,
        dx = 0,
        dy = 0,
        direction = "left",
        tilesMap = tilesMap,
        objects = objects,
        stateMachine = StateMachine({
            ['idle'] = function()
                return MushroomIdleState(mushroom, mainCharacter)
            end,
            ['moving'] = function()
                return MushroomMovingState(mushroom, mainCharacter)
            end,
            ['chasing'] = function()
                return MushroomChasingState(mushroom, mainCharacter)
            end
        }),
        colidable = false,
        consumable = false
    })
    mushroom:changeState("idle")
    table.insert(enemies, mushroom)
end

function GenerateEnemyTurtle(enemies, enemiesTileSheet, quads, tilesMap, objects, mainCharacter, colIndex)
    local turtle
    turtle = TurtleEntity({
        sheet = enemiesTileSheet,
        quads = quads,
        x = (colIndex - 1) * TILE_WIDTH,
        y = (SKY_MAX_INDEX - 1) * TILE_HEIGHT - TURTLE_DEFAULT_HEIGHT * TURTLE_SCALE_RATIO,
        width = TURTLE_DEFAULT_WIDTH * TURTLE_SCALE_RATIO,
        height = TURTLE_DEFAULT_HEIGHT * TURTLE_SCALE_RATIO,
        scaleRatio = TURTLE_SCALE_RATIO,
        dx = 0,
        dy = 0,
        direction = "left",
        tilesMap = tilesMap,
        objects = objects,
        stateMachine = StateMachine({
            ['idle'] = function()
                return TurtleIdleState(turtle, mainCharacter)
            end,
            ['moving'] = function()
                return TurtleMovingState(turtle, mainCharacter)
            end,
            ['chasing'] = function()
                return TurtleChasingState(turtle, mainCharacter)
            end,
            ['shrink'] = function()
                return TurtleShrinkState(turtle, mainCharacter)
            end
        }),
        collidable = true,
        consumable = false,
        onCollide = function()
            turtle:changeState("shrink")
        end
    })
    turtle:changeState("idle")
    table.insert(enemies, turtle)
end

function GenerateEnemyCannibal(enemies, enemiesTileSheet, quads, mainCharacter, colIndex)
    local cannibal
    cannibal = CannibalEntity({
        sheet = enemiesTileSheet,
        quads = quads,
        x = (colIndex - 1) * TILE_WIDTH + (2 * TILE_WIDTH - CANNIBAL_WIDTH * CANNIBAL_SCALE_RATIO) / 2,
        y = (SKY_MAX_INDEX - 1) * TILE_HEIGHT - 2 * GAME_OBJECT_HEIGHT - CANNIBAL_HEIGHT * CANNIBAL_SCALE_RATIO,
        width = CANNIBAL_WIDTH * CANNIBAL_SCALE_RATIO,
        height = CANNIBAL_HEIGHT * CANNIBAL_SCALE_RATIO,
        scaleRatio = CANNIBAL_SCALE_RATIO,
        dx = 0,
        dy = 0,
        stateMachine = StateMachine({
            ['idle'] = function()
                return CannibalIdleState(cannibal, mainCharacter)
            end,
            ['attack'] = function()
                return CannibalAttackState(cannibal, mainCharacter)
            end
        }),
        collidable = false,
        consumable = false
    })

    cannibal:changeState("idle")
    table.insert(enemies, cannibal)
end
