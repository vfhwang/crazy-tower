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

function TitleScreenState:render()


    love.graphics.setFont(titleFont)

    love.graphics.translate(WINDOW_WIDTH/2, WINDOW_HEIGHT/2-40)
    -- love.graphics.rotate(titleRotation)
    love.graphics.setColor(47/255,128/255,237/255,255/255)
    love.graphics.printf('Fish', (-WINDOW_WIDTH/2)+4, -20, WINDOW_WIDTH, 'center')

    love.graphics.origin()

    love.graphics.setFont(smallFont)
    love.graphics.printf('Spacebar to start', 0, WINDOW_HEIGHT-60, WINDOW_WIDTH, 'center')


    -- piece:render()
    -- tower:render()
    -- score:render()
end