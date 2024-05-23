Animation = class()

function Animation:init(def)
    self.frames = def.frames
    self.interval = def.interval
    self.timer = 0
    self.currentFrame = 1
end

function Animation:update(deltaTime)
    -- no need to update if animation only have 1 frame
    if #self.frames > 1 then
        self.timer = self.timer + deltaTime

        if self.timer > self.interval then
            self.timer = self.timer % self.interval

            self.currentFrame = self.currentFrame == #self.frames and 1 or self.currentFrame + 1
        end
    end
end

function Animation:getCurrentFrame()
    return self.frames[self.currentFrame]
end
