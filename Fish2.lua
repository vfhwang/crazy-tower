Fish2 = Class{}


function FindNearest(x,y,food,width)
    local lowest = math.huge -- infinity
    local NearestFood = nil

    for k,v in pairs(food) do

    function distanceFrom(x1,y1,x2,y2) return math.sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2) end
    
    if v[3] < width then

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
    end
    return NearestFood

end



-- Setting up the Fish2
function Fish2:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.velocity = 2
    self.dx = 0
    self.dy = 0
    self.maxspeed = 5
    self.nearestFood = nil
end

-- Reset the Fish2 to default
function Fish2:reset()
    self.x = 0
    self.y = VIRTUAL_HEIGHT-self.height

end

-- Once the game starts, make the Fish2 move left and right
function Fish2:update(dt, food)


    --find the nearest bit of food
    
if  self.nearestFood == nil then
self.nearestFood =  FindNearest(self.x,self.y,food,width)
end


    -- print('nearest food is ' .. self.nearestFood)

    -- print('my x is ' .. self.x .. 'my y is ' .. self.y)


    if food[self.nearestFood] then

        thispiece = food[self.nearestFood]

        local thispieceX = thispiece[1]
        local thispieceY = thispiece[2]

        -- print('nearest food x is ' .. thispieceX .. 'nearest food y is ' .. thispieceY)


        if thispieceY > self.y then
            -- print('it is below you')
            self.dy = math.min(self.dy + self.velocity * dt,self.maxspeed)
        else
            -- print('it is above you')
            self.dy = self.dy - (self.velocity * self.velocity) * dt
        end

        if thispieceX > self.x then
            -- print('it is right of you')
            self.dx = math.min(self.dx + self.velocity * dt,self.maxspeed)

        else
            -- print('it is left of you')
            self.dx = math.max(self.dx - self.velocity * dt,-self.maxspeed)

        end
    else
        self.nearestFood =  FindNearest(self.x,self.y,food,self.width)
    end

    

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

    
    --movement
    self.y = self.y + self.dy
    self.x = self.x + self.dx


end



-- Draw the Fish2 to the screen
function Fish2:render()
    love.graphics.setColor(179/255,138/255,224/255,255/255)
    love.graphics.circle('fill', self.x, self.y, self.width)
end