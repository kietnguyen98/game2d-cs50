Entity = class()

function Entity:init(def)
    -- position
    self.x = def.x
    self.y = def.y

    -- size
    self.width = def.width
    self.height = def.height

    -- velocity
    self.dx = def.dx
    self.dy = def.dy

    -- direction 
    self.direction = def.direction

    -- texture sheet
    self.sheet = def.sheet

    -- texture  
    self.quads = def.quads

    -- state
    self.stateMachine = def.stateMachine

    -- reference to tilesMap so we can check fo collisions
    self.tilesMap = def.tilesMap

    -- reference to game objects so we can check fo collisions
    self.objects = def.objects
end

function Entity:changeState(state, params)
    self.stateMachine:change(state, params)
end

function Entity:update(deltaTime)
    self.stateMachine:update(deltaTime)
end

function Entity:collides(targetEntity)
    -- using AABB   
    return (self.x < targetEntity.x + targetEntity.width) and (self.x + self.width > targetEntity.x) and
               (self.y < targetEntity.y + targetEntity.height) and (self.y + self.height > targetEntity.y)
end

function Entity:render()
    love.graphics.draw( -- draw object
    self.sheet, self.quads[self.currentAnimation:getCurrentFrame()], -- position of object on x axis
    math.floor(self.x) + self.width / 2, -- position of object on y axis
    math.floor(self.y) + self.height / 2, -- rotate degree
    0, -- scale on x axis
    self.direction == "left" and -1 or 1, -- scale on y axis
    1, -- origin offset on x axis
    self.width / 2, -- origin offset on y axis
    self.height / 2)
end
