Dungeon = class()

function Dungeon:init(player)
    self.player = player
    self.currentRoom = Room(self.player)
    self.nextRoom = nil
end

function Dungeon:update(deltaTime)
    self.currentRoom:update(deltaTime)
end

function Dungeon:render()
    self.currentRoom:render()
end
