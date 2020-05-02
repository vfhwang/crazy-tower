Food = Class{}


-- Setting up the Food
function Food:init(number)

    self.scattered = {}
    self.width = 10
    self.number = number

    for i=1,number do
        x = love.math.random( PLAY_WIDTH )
        y = love.math.random( PLAY_HEIGHT )
        width = love.math.random( self.width )
        table.insert(self.scattered,{x,y,width})

      end


end

-- Reset the Food to default
function Food:reset()

end


function Food:update(dt)

    for k, v in pairs(self.scattered) do

        -- x = v[1]
        -- y = v[2]

        v[1] = v[1] + 10 * dt        


        -- if  math.floor(self.fish.x - (self.fish.width)) <= math.floor(v[1]) and math.floor(self.fish.x + (self.fish.width)) >= math.floor(v[1]) 
        --     and 
        --     math.floor(self.fish.y - (self.fish.width)) <= math.floor(v[2]) and math.floor(self.fish.y + (self.fish.width)) >= math.floor(v[2]) 
        -- then
        --     -- if the fish is smaller than the food
        --     if self.fish.width < v[3] + 1 then

        --     gStateMachine:change('gameover', {
        --     score = self.fish.width, 
        -- })

        --     else
        --     sounds['eat']:play()
        --     print('EAT!' .. k)
        --     self.food:eaten(k)
        --     self.fish.width = self.fish.width + v[3]/2


        --     end
        -- end


    end

end

function Food:eaten(piece)

    self.scattered[piece] = nil
    table.insert(self.scattered,{love.math.random( PLAY_WIDTH ),love.math.random( PLAY_HEIGHT ),love.math.random( self.width )})


end



-- Draw the Food to the screen
function Food:render()
    love.graphics.setColor(255,255,255,255)
        for k, v in pairs(self.scattered) do
        love.graphics.circle('fill', v[1], v[2], v[3])
        end
end