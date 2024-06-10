Animation = class()

function Animation:init(def)
    self.frames = def.frames
    self.interval = def.interval

    self.isLooping = def.isLooping or true

    self.timer = 0
    self.frameIndex = 1
    self.timePlayed = 0
end

function Animation:refresh()
    self.timer = 0
    self.frameIndex = 1
    self.timePlayed = 0
end

function Animation:update(deltaTime)
    if not self.isLooping and self.timePlayed > 0 then
        return
    end

    -- update timer and frame
    if #self.frames > 1 then
        self.timer = self.timer + deltaTime
        if self.timer > self.interval then
            self.timer = self.timer % self.interval

            self.frameIndex = math.max(1, (self.frameIndex + 1) % (#self.frames + 1))
            print(self.frameIndex)
            if self.frameIndex == 1 then
                self.timePlayed = self.timePlayed + 1
            end
        end
    end
end

function Animation:getCurrentFrame()
    return self.frames[self.frameIndex]
end
