

GameOverState = Class{__includes = BaseState}

titleRotation = -0.1
spinLeft = true


function GameOverState:enter(params)
    self.score = params.score
    self.win = params.win
    print ('game over')
end

function GameOverState:update(dt)
    if love.keyboard.wasPressed('space') then
        gStateMachine:change('play')
    end

end

function GameOverState:render()


    love.graphics.setFont(smallFont)

    love.graphics.setColor(47/255,128/255,237/255,255/255)

    if self.win then
        love.graphics.printf('Winner!', 0, 100 , WINDOW_WIDTH, 'center')

    else
    love.graphics.printf('Game Over', 0, 100 , WINDOW_WIDTH, 'center')
    end

    love.graphics.setFont(titleFont)
    love.graphics.printf('Your fish was ' .. self.score/10 .. ' kg', 0, WINDOW_HEIGHT/2-150, WINDOW_WIDTH, 'center')
    
    love.graphics.setFont(smallFont)

    love.graphics.printf('Spacebar to restart', 0, WINDOW_HEIGHT-60, WINDOW_WIDTH, 'center')


end