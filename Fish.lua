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
    self.maxspeed = 1.5

end

-- Reset the Fish to default
function Fish:reset()
    self.x = 0
    self.y = VIRTUAL_HEIGHT-self.height

end

-- Once the game starts, make the Fish move left and right
function Fish:update(dt)



    if self.x < 0 then
        self.x = 0 + 1
    end
    if self.y < 0 then
        self.y = 0 + 1
    end

    if self.x > PLAY_WIDTH then
        self.x = PLAY_WIDTH - 1
    end
    if self.y > PLAY_HEIGHT then
        self.y = PLAY_HEIGHT - 1
    end

    if love.keyboard.isDown('w') or love.keyboard.isDown('a') or love.keyboard.isDown('s')  or love.keyboard.isDown('d') then
    if love.keyboard.isDown('a') then
        -- print('left!')
        self.dx = math.max(self.dx - self.velocity * dt,-self.maxspeed)
    end

    if love.keyboard.isDown('d') then
        -- print('right!')
        self.dx = math.min(self.dx + self.velocity * dt,self.maxspeed)

    end

    if love.keyboard.isDown('w') then
            -- print('up!')
        self.dy = math.max(self.dy - self.velocity * dt,-self.maxspeed)
 
    end

    if love.keyboard.isDown('s') then        
        -- print('down!')
        self.dy = math.min(self.dy + self.velocity * dt,self.maxspeed)
    end

    if love.keyboard.wasPressed('space') then
        print('booooooost!')
        self.dx = self.dx * 100 * dt
        self.dy = self.dy * 100 * dt

    end

    else

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
    love.graphics.setColor(255,0,229,255)
    love.graphics.circle('fill', self.x, self.y, self.width)
end