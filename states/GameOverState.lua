

GameOverState = Class{__includes = BaseState}

titleRotation = -0.1
spinLeft = true


function GameOverState:enter(params)
    self.score = params.score
    self.tower = params.tower


    self.piece = {}
    table.insert(self.piece, params.piece)  
    

    print ('game over')
end

function GameOverState:update(dt)
    if love.keyboard.wasPressed('space') then
        gStateMachine:change('play')
    end

    if spinLeft then
        titleRotation = titleRotation + 0.01
        if titleRotation >= 0.1 then
            spinLeft = false
        end
    else
        titleRotation = titleRotation - 0.01
        if titleRotation <= -0.1 then
        spinLeft = true
        end
    end

end

function GameOverState:render()


    love.graphics.setFont(scoreFont)


    love.graphics.printf('Game Over', 0, VIRTUAL_HEIGHT/2, VIRTUAL_WIDTH, 'center')


    love.graphics.setFont(smallFont)
    love.graphics.printf(self.score, 0, 18, VIRTUAL_WIDTH, 'center')

    for k, v in pairs(self.tower) do

        love.graphics.setColor(v[4])
        love.graphics.rectangle('fill', v[1], v[2], v[3], 5)
    end


    for k, v in pairs(self.piece) do

        love.graphics.setColor(255/255,0,0,255/255)
        love.graphics.rectangle('fill', v[1], v[2], v[3], 5)
    end

    -- piece:render()
    -- self.tower:render()
    -- score:render()


end