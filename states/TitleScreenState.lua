--[[
    TitleScreenState Class
    
    Author: Colton Ogden
    cogden@cs50.harvard.edu

    The TitleScreenState is the starting screen of the game, shown on startup. It should
    display "Press Enter" and also our highest score.
]]

TitleScreenState = Class{__includes = BaseState}

titleRotation = -0.1
spinLeft = true


function TitleScreenState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
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

function TitleScreenState:render()

    love.graphics.clear(40/255, 45/255, 52/255, 255/255)

    love.graphics.setFont(scoreFont)

    love.graphics.translate(VIRTUAL_WIDTH/2, 40)
    love.graphics.rotate(titleRotation)
    
    love.graphics.printf('Crazy Tower', (-VIRTUAL_WIDTH/2)+4, -20, VIRTUAL_WIDTH, 'center')

    love.graphics.origin()

    love.graphics.setFont(smallFont)
    love.graphics.printf('Spacebar to start', 0, VIRTUAL_HEIGHT-60, VIRTUAL_WIDTH, 'center')


    piece:render()
    tower:render()
    -- score:render()
end