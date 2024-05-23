MainCharacter = class()

function MainCharacter:init() 
    self.sheet = love.graphics.newImage("assets/mario_and_items.png")
    self.quads = GenerateQuadsCharacter(self.sheet)
    self.x = VIRTUAL_WIDTH / 2 - CHARACTER_WIDTH / 2
    self.y = (SKY_MAX_INDEX - 1) * TILE_HEIGHT - CHARACTER_HEIGHT
    self.deltaY = 0
    self.animation = {
        ["idle"] = Animation({
            frames = {1},
            interval = 1
        }),
        ["moving"] = Animation({
            frames = {5, 6, 7, 6},
            interval = 0.12
        }),
        ["jumping"] = Animation({
            frames = {3},
            interval = 1
        })
    }
    self.currentAnimation = self.animation.idle
    self.direction = "right"
end

function MainCharacter:update(deltaTime)
    -- update character on jumping  
    self.deltaY = self.deltaY + GRAVITY_FORCE 
    self.y = self.y + self.deltaY * deltaTime

    if self.y > (SKY_MAX_INDEX - 1) * TILE_HEIGHT - CHARACTER_HEIGHT then
        self.y = (SKY_MAX_INDEX - 1) * TILE_HEIGHT - CHARACTER_HEIGHT
        self.deltaY = 0
    end

    -- update character animation
    self.currentAnimation:update(deltaTime)
    -- update camera scroll, character direction, animation base on user input
    if love.keyboard.isDown("left") then
        self:moveLeft(deltaTime)
    elseif love.keyboard.isDown("right") then
        self:moveRight(deltaTime)
    else 
        if self.deltaY == 0 then
            self.currentAnimation = self.animation.idle
        end
    end
end

function MainCharacter:moveLeft(deltaTime)
    self.x = self.x - CHARACTER_SPEED * deltaTime
    self.direction = "left"
    if self.deltaY == 0 then
        self.currentAnimation = self.animation.moving
    end
end

function MainCharacter:moveRight(deltaTime)
    self.x = self.x + CHARACTER_SPEED * deltaTime
    self.direction = "right"
    if self.deltaY == 0 then
        self.currentAnimation = self.animation.moving
    end
end

function MainCharacter:jump()
    self.deltaY = JUMP_VELOCITY
    self.currentAnimation = self.animation.jumping
end

function MainCharacter:fall()
end

function MainCharacter:render()
    -- draw character on screen
    -- should use math.floor to remove decimal part (if exist) => integer only to prevent
    -- being fractional point in world space
    love.graphics.draw(
        -- draw object
        self.sheet, 
        self.quads[self.currentAnimation:getCurrentFrame()], 
        -- position of object on x axis
        math.floor(self.x) + CHARACTER_WIDTH / 2, 
        -- position of object on y axis
        math.floor(self.y) + CHARACTER_HEIGHT / 2, 
        -- rotate degree
        0, 
        -- scale on x axis
        self.direction == "left" and -1 or 1, 
        -- scale on y axis
        1, 
        -- origin offset on x axis
        CHARACTER_WIDTH / 2, 
        -- origin offset on y axis
        CHARACTER_HEIGHT / 2
    )
end
