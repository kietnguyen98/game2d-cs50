AlienLaunchMarker = class()

function AlienLaunchMarker:init(def)
    self.world = def.world

    -- starting coordinates for launcher used to calculate launch vector
    self.baseX = 90
    self.baseY = VIRTUAL_HEIGHT - 100

    -- shifted coordinates when clicking and dragging launch alien
    self.shiftedX = self.baseX
    self.shiftedY = self.baseY

    -- whether our arrow is showing where we're isAiming
    self.isAiming = false

    -- whether we isLaunched the alien and should stop rendering the preview
    self.isLaunched = false

    -- our alien we will eventually spawn
    self.alien = nil
end

function AlienLaunchMarker:update(deltaTime)
    -- perform everything here as long as we haven't isLaunched yet
    if not self.isLaunched then

        -- grab mouse coordinates
        local x, y = push:toGame(love.mouse.getPosition())

        -- if we click the mouse and haven't isLaunched, show arrow preview
        if love.mouse.wasPressed(1) and not self.isLaunched then
            self.isAiming = true

            -- if we are in aming mode and release the mouse, launch an Alien
        elseif love.mouse.wasReleased(1) and self.isAiming then
            -- we're no longer isAiming
            self.isAiming = false
            -- set the mode to isLaunched
            self.isLaunched = true

            -- spawn new alien in the world, passing in user data of player
            self.alien = Alien({
                world = self.world,
                type = 'circle',
                x = self.shiftedX,
                y = self.shiftedY,
                userData = 'Player'
            })

            -- apply the difference between current X,Y and base X,Y as launch vector impulse
            self.alien.body:setLinearVelocity((self.baseX - self.shiftedX) * 10, (self.baseY - self.shiftedY) * 10)

            -- make the alien pretty bouncy
            self.alien.fixture:setRestitution(0.4)
            -- read more docs about angular damping here: 
            -- https://cyberbotics.com/doc/reference/damping
            self.alien.body:setAngularDamping(1)

            -- if we are in amining mode and still not release the mouse yet, re-render trajectory
        elseif self.isAiming then
            self.shiftedX = math.min(self.baseX + 30, math.max(x, self.baseX - 30))
            self.shiftedY = math.min(self.baseY + 30, math.max(y, self.baseY - 30))
        end
    end
end

function AlienLaunchMarker:render()
    if not self.isLaunched then

        -- render base alien where the mouse hold, non physics based
        love.graphics.draw(gameTextures['aliens'], gameFrames['aliens'][9], self.shiftedX - 17.5, self.shiftedY - 17.5)

        -- render trajectory
        if self.isAiming then
            -- render arrow if we're isAiming, with transparency based on slingshot distance
            local impulseX = (self.baseX - self.shiftedX) * 10
            local impulseY = (self.baseY - self.shiftedY) * 10

            -- draw 18 circles simulating trajectory of estimated impulse
            local trajX, trajY = self.shiftedX, self.shiftedY
            local gravX, gravY = self.world:getGravity()

            for i = 1, 90 do

                -- magenta color that starts off slightly transparent
                love.graphics.setColor(255 / 255, 80 / 255, 255 / 255, ((255 / 24) * i) / 255)

                -- trajectory X and Y for this iteration of the simulation
                trajX = self.shiftedX + i * 1 / 60 * impulseX
                -- http://www.iforce2d.net/b2dtut/projected-trajectory
                -- p(n) = p(0) + n*v + (n^2 + n) * a(gravity) / 2
                trajY = self.shiftedY + i * 1 / 60 * impulseY + 0.5 * (i * i + i) * gravY * 1 / 60 * 1 / 60

                -- render every fifth calculation as a circle
                if i % 5 == 0 then
                    love.graphics.circle('fill', trajX, trajY, 3)
                end
            end
        end

        love.graphics.setColor(1, 1, 1, 1)
    else
        self.alien:render()
    end
end
