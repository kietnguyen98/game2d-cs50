Dungeon = class()

function Dungeon:init(def)
    self.currentRoom = Room()
    self.nextRoom = nil
end

function Dungeon:update(deltaTime)
    self.currentRoom:update(deltaTime)
end

function Dungeon:render()
    self.currentRoom:render()
end
