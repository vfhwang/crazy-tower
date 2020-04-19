Score = Class{}


-- Setting up the piece
function Score:init(count)
    self.count = count
end

function Score:reset()
    self.count = 0
end

function Score:update()
    self.count = tower.numberOfPieces
end

-- Draw the piece to the screen
function Score:render()

    love.graphics.setFont(scoreFont)

    if self.count > 0 then
    love.graphics.printf(tower.numberOfPieces, 0, 18, VIRTUAL_WIDTH, 'center')
    end

end