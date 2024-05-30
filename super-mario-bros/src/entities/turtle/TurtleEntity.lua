TurtleEntity = Entity:extend()

function TurtleEntity:init(def)
    Entity.init(self, def)
    self.scaleRatio = def.scaleRatio
    self.height = self.height * self.scaleRatio
    self.width = self.width * self.scaleRatio
end

function TurtleEntity:update(deltaTime)
    Entity.update(self, deltaTime)
end

function TurtleEntity:render()
    love.graphics.draw( -- draw object
    self.sheet, self.quads[self.currentAnimation:getCurrentFrame()], -- position of object on x axis
    math.floor(self.x) + self.width / 2, -- position of object on y axis
    math.floor(self.y) + self.height / 2, -- rotate degree
    0, -- scale on x axis
    (self.direction == "right" and -1 or 1) * self.scaleRatio, -- scale on y axis
    self.scaleRatio, -- origin offset on x axis
    self.width / self.scaleRatio / 2, -- origin offset on y axis
    self.height / self.scaleRatio / 2)
end

function TurtleEntity:checkObjectCollisions()
    local collidedObjects = {}

    for k, object in pairs(self.objects) do
        if object:collides(self) then
            if object.solid then
                table.insert(collidedObjects, object)
            end
        end
    end

    return collidedObjects
end
