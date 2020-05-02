Fish2 = Class{}


function FindNearest(x,y,food)
    local lowest = math.huge -- infinity
    local NearestFood = nil

    for k,v in pairs(food) do

    function distanceFrom(x1,y1,x2,y2) return math.sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2) end
    
    distance = distanceFrom(x,y,v[1],v[2])
    -- print('distance to food bit ' .. k .. ' is ' .. distanceFrom(x,y,v[1],v[2]))

        -- if v and v.Character then
        --     local distance = v:DistanceFromCharacter(position)
            if distance < lowest then
                lowest = distance
                NearestFood = k
            end
        -- end
    end
    return NearestFood
end



-- Setting up the Fish2
function Fish2:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.velocity = 3
    self.dx = 0
    self.dy = 0
    self.maxspeed = 10
    self.nearestFood = nil
end

-- Reset the Fish2 to default
function Fish2:reset()
    self.x = 0
    self.y = VIRTUAL_HEIGHT-self.height

end

-- Once the game starts, make the Fish2 move left and right
function Fish2:update(dt, food)

    food = food
    self.nearestFood =  FindNearest(self.x,self.y,food)

    print('nearest food is ' .. self.nearestFood)
    

    --Bounding off the walls
    if self.x < 0 then
        self.dx = 5
        self.x = 0 + 1
    end
    if self.y < 0 then
        self.dy = 5
        self.y = 0 + 1
    end

    if self.x > PLAY_WIDTH then
        self.dx = -5
        self.x = PLAY_WIDTH - 1
    end
    if self.y > PLAY_HEIGHT then
        self.dy = -5
        self.y = PLAY_HEIGHT - 1
    end


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

        


            
            -- print(FindNearest(position))
            -- change position to the position of the Zombie's upper/lower torso, or head.


    self.y = self.y + self.dy
    self.x = self.x + self.dx


end



-- Draw the Fish2 to the screen
function Fish2:render()
    love.graphics.setColor(179/255,138/255,224/255,255/255)
    love.graphics.circle('fill', self.x, self.y, self.width)
end