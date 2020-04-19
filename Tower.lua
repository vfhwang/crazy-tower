Tower = Class{}


-- Setting up the piece
function Tower:init(numberOfPieces,stack)
    self.numberOfPieces = numberOfPieces
    self.stack = stack
end

-- Reset the piece to default
function Tower:reset()
    self.numberOfPieces = 0
    self.stack = {}
end

-- Adding pieces to the tower
function Tower:update()


    piece.x = math.floor(piece.x+0.5)
    if self.numberOfPieces > 0 then



        -- if it hangs over the left
        if piece.x <= towerLeft then 


            print ('HANGING TO THE LEFT')
            --cut it down to size
            piece.width = math.max(0,piece.width - (towerLeft - piece.x))

            --place it at the edge of the tower
            table.insert(self.stack, {towerLeft, piece.y, piece.width})
            
            towerRight = towerLeft + piece.width


        -- if it hangs over the right
        elseif piece.x >= towerLeft then
            print ('HANGING TO THE RIGHT | x: '  .. tostring(piece.x) .. ' Tower left: '  .. tostring(towerLeft))
            --Cut the width down to size
            piece.width = math.max(0,piece.width - (piece.x - towerLeft))

            --Place it where it stopped


            table.insert(self.stack, {piece.x, piece.y, piece.width})

            towerLeft = piece.x

            print ('New Tower left: '  .. tostring(towerLeft))


        -- if it's perfect placement
        else
            print ('PERFECTO')
            table.insert(self.stack, {piece.x, piece.y, piece.width})

        end

    else

    table.insert(self.stack, {piece.x, piece.y, piece.width})

    towerLeft = piece.x
    towerRight = piece.x + piece.width

    end

    sounds['paddle_hit']:play()
    tower.numberOfPieces = tower.numberOfPieces + 1

    piece.speed = piece.speed *1.03
    piece.y = piece.y - piece.height

end

-- Draw the tower to the screen
function Tower:render()
    if  tower.numberOfPieces >= 1 then
        for k, v in pairs(tower.stack) do
            love.graphics.rectangle('fill', v[1], v[2], v[3], piece.height)
        end
    end

end