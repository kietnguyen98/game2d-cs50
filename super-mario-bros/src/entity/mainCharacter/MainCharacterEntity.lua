MainCharacterEntity = Entity:extend()

function MainCharacterEntity:init(def)
    self.score = 0
    Entity.init(self, def)
end

function MainCharacterEntity:update(deltaTime)
    Entity.update(self, deltaTime)
end

function MainCharacterEntity:render()
    Entity.render(self)
end

