Tower = Class{}


-- Setting up the piece
function Tower:init(numberOfPieces,stack,left,right)
    self.numberOfPieces = numberOfPieces
    self.stack = stack
    r = 255/255
    g = 255/255
    b = 255/255
    a = 255/255
    self.left = left
    self.right = right

end

-- Reset the piece to default
function Tower:reset()
    self.numberOfPieces = 0
    self.stack = {}
end

-- Adding pieces to the tower
function Tower:update(x,y,w)


    table.insert(self.stack, {x, y, w,{r,g,b,a}})
    self.numberOfPieces = self.numberOfPieces + 1

    r = r - 5/255
    g = g - 5/255
    b = b - 5/255


end

-- Draw the tower to the screen
function Tower:render()
    if  self.numberOfPieces >= 1 then
        for k, v in pairs(self.stack) do

            love.graphics.setColor(v[4])
            love.graphics.rectangle('fill', v[1], v[2], v[3], 5)
        end
    end

end