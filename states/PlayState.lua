--[[
    PlayState Class
    Author: Colton Ogden
    cogden@cs50.harvard.edu

    The PlayState class is the bulk of the game, where the player actually controls the bird and
    avoids pipes. When the player collides with a pipe, we should go to the GameOver state, where
    we then go back to the main menu.
]]

PlayState = Class{__includes = BaseState}


sea = love.graphics.newImage( 'images/water.jpeg' )


function PlayState:init()

    self.speed = 100
    self.fish = Fish(100,100,4)
    self.score = 0
    self.dotToCollect = {false,null}
    self.gravity = 200
    self.camX = 0
    self.camY = 0
    self.food = Food(40)

end


function PlayState:update(dt)
    
    self.fish:update(dt)

    cam:setPosition(self.fish.x + (VIRTUAL_WIDTH/2), self.fish.y + (VIRTUAL_HEIGHT/2))


    self.camX = self.fish.x - (VIRTUAL_WIDTH/2)
    self.camY = self.fish.y - (VIRTUAL_HEIGHT/2)

    for k, v in pairs(self.food.scattered) do
        -- if math.floor(v[1]) == math.floor(self.fish.x) and math.floor(v[2]) == math.floor(self.fish.y) then
        --     print('EAT!' .. k)
        -- end

        if  math.floor(self.fish.x - (self.fish.width/2)) <= math.floor(v[1]) and math.floor(self.fish.x + (self.fish.width/2)) >= math.floor(v[1]) 
            and 
            math.floor(self.fish.y - (self.fish.width/2)) <= math.floor(v[2]) and math.floor(self.fish.y + (self.fish.width/2)) >= math.floor(v[2]) 
        then
            -- if the fish is smaller than the food
            if self.fish.width <= v[3] then
                gStateMachine:change('gameover')
            else
            print('EAT!' .. k)
            self.food:eaten(k)
            self.fish.width = self.fish.width + 1
            end
        end
    end

    -- print('fish x = ' .. self.fish.x)
    -- print('fish y = ' .. self.fish.y)

end

function PlayState:render()

    love.graphics.translate(-math.floor(self.camX),-math.floor(self.camY))
    -- print('camera = ' .. cam:getvisible()s)
    love.graphics.draw(sea, -200, -200, 0, 10, 10)
    self.food:render()
    self.fish:render()
    -- cam:draw(function(l,t,w,h)

    --   end)

-- print(cam:getVisible())

end