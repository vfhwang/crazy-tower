Fish = Class{}


-- Setting up the Fish
function Fish:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.velocity = 3
    self.dx = 0
    self.dy = 0
    self.maxspeed = 10

end

-- Reset the Fish to default
function Fish:reset()
    self.x = 0
    self.y = VIRTUAL_HEIGHT-self.height

end

-- Once the game starts, make the Fish move left and right
function Fish:update(dt)


    --Bounding off the walls
    if self.x - self.width < 0 then
        self.dx = 5
        self.x = self.width + 1
    end
    if self.y - self.width < 0 then
        self.dy = 5
        self.y = self.width + 1
    end

    if self.x + self.width > PLAY_WIDTH then
        self.dx = -5
        self.x = PLAY_WIDTH - self.width - 1
    end
    if self.y + self.width > PLAY_HEIGHT then
        self.dy = -5
        self.y = PLAY_HEIGHT - self.width - 1
    end



    if love.keyboard.isDown('w') or love.keyboard.isDown('a') or love.keyboard.isDown('s')  or love.keyboard.isDown('d') then
    if love.keyboard.isDown('a') then
        -- print('left!')

        -- If we're travelling right
        if self.dx >=0 then

        -- then turn around super fast
        self.dx = self.dx - (self.velocity * self.velocity) * dt

        -- otherwise just accelerate till max speed
        else
        self.dx = math.max(self.dx - self.velocity * dt,-self.maxspeed)
        end
    end

    if love.keyboard.isDown('d') then
        -- print('right!')
        if self.dx <=0 then
        self.dx = self.dx + (self.velocity * self.velocity) * dt
        else
        self.dx = math.min(self.dx + self.velocity * dt,self.maxspeed)
        end
    end

    if love.keyboard.isDown('w') then
            -- print('up!')
        if self.dy >= 0 then
            self.dy = self.dy - (self.velocity * self.velocity) * dt
            else
        self.dy = math.max(self.dy - self.velocity * dt,-self.maxspeed)
            end
    end

    if love.keyboard.isDown('s') then 
        if self.dy <=0 then
            self.dy = self.dy + (self.velocity * self.velocity) * dt
            else       
        -- print('down!')
        self.dy = math.min(self.dy + self.velocity * dt,self.maxspeed)
            end
    end

    if love.keyboard.wasPressed('space') then
        print('booooooost!')
        self.dx = self.dx * 100 * dt
        self.dy = self.dy * 100 * dt

    end

    else

        --Deceleration
        if self.dx > 0 then
            self.dx = self.dx - 1 * dt
        else 
            self.dx = self.dx + 1 * dt
        end

        if self.dy > 0 then
                self.dy = self.dy - 1 * dt
            else 
                self.dy = self.dy + 1 * dt
            end


    end 



        if love.keyboard.isDown('return') then
        self.x = 50
        self.y = 50
 
        end


    self.y = self.y + self.dy
    self.x = self.x + self.dx


end



-- Draw the Fish to the screen
function Fish:render()
    love.graphics.setColor(253/255,139/255,138/255,255/255)
    love.graphics.circle('fill', self.x, self.y, self.width)
end