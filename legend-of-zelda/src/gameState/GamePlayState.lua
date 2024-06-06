GamePlayState = BaseState()

function GamePlayState:init()
    self.dungeon = Dungeon()
end

function GamePlayState:enter(params)
end

function GamePlayState:update(deltaTime)
    self.dungeon:update(deltaTime)
end

function GamePlayState:render()
    self.dungeon:render()
end
