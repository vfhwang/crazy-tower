

-- push is a library that will allow us to draw our game at a virtual
-- resolution, instead of however large our window is; used to provide
-- a more retro aesthetic
--
-- https://github.com/Ulydev/push
push = require 'push'

-- the "Class" library we're using will allow us to represent anything in
-- our game as code, rather than keeping track of many disparate variables and
-- methods
--
-- https://github.com/vrld/hump/blob/master/class.lua
Class = require 'class'

require 'Piece'

WINDOW_WIDTH = 320
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 108
VIRTUAL_HEIGHT = 243

-- speed at which we will move our paddle; multiplied by dt in update
PADDLE_SPEED = 200

--[[
    Runs when the game first starts up, only once; used to initialize the game.
]]
function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- more "retro-looking" font object we can use for any text
    smallFont = love.graphics.newFont('font.ttf', 8)

    -- larger font for drawing the score on the screen
    scoreFont = love.graphics.newFont('font.ttf', 32)

    -- set LÖVE2D's active font to the smallFont obect
    love.graphics.setFont(smallFont)

    -- initialize window with virtual resolution
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    -- math.randomseed(os.time())



    pieceGoingLeft = true
    pieceWidth = 40
    pieceHeight = 5
    pieceSpeed = 200
    pieceY = VIRTUAL_HEIGHT-pieceHeight
    pieceX = 0

    piecesPlaced = {}
    piecesPlacedNum = 0

    previousPieceX = 0
    previousPieceWidth = pieceWidth


    gameState = 'start'

end

--[[
    Runs every frame, with "dt" passed in, our delta in seconds 
    since the last frame, which LÖVE2D supplies us.
]]
function love.update(dt)

    if gameState =='play' then
        if pieceGoingLeft == true then
        pieceX = pieceX + pieceSpeed * dt
            if pieceX >= VIRTUAL_WIDTH - pieceWidth then
                pieceGoingLeft = false
            end
        else
            pieceX = pieceX - pieceSpeed * dt
            if pieceX <= 0 then
                pieceGoingLeft = true
            end
        end
    end

end

--[[
    Keyboard handling, called by LÖVE2D each frame; 
    passes in the key we pressed so we can access.
]]
function love.keypressed(key)
    -- keys can be accessed by string name
    if key == 'escape' then
        -- function LÖVE gives us to terminate application
        love.event.quit()
    end

    if key == 'return' then
        if  gameState == 'start' then
        gameState = 'play'
        else
        gameState = 'start'

        pieceGoingLeft = true
        pieceWidth = 40
        pieceHeight = 5
        pieceSpeed = 100
        pieceY = VIRTUAL_HEIGHT-pieceHeight
        pieceX = 0
    
        piecesPlaced = {}
        piecesPlacedNum = 0
    
        previousPieceX = 0
        previousPieceWidth = pieceWidth
    
        end
    end

    if key == 'space' then

        -- if we haven't put anything down yet
        if piecesPlacedNum == 0 then

        table.insert(piecesPlaced, {pieceX , pieceY, pieceWidth})

        else

            -- if it hangs over the left
            if pieceX <= previousPieceX then 
            
            pieceWidth = pieceWidth - (previousPieceX - pieceX)

            table.insert(piecesPlaced, {previousPieceX , pieceY, pieceWidth})

            -- previousPieceX = pieceX

            -- piecesPlacedNum = piecesPlacedNum + 1


            -- if it hangs over the right

            elseif pieceX >= previousPieceX then

            pieceWidth = pieceWidth - (pieceX - previousPieceX)

            table.insert(piecesPlaced, {pieceX , pieceY, pieceWidth})


            -- if it's perfect placement

            else

            table.insert(piecesPlaced, {pieceX , pieceY, pieceWidth})

            -- previousPieceX = pieceX

            -- piecesPlacedNum = piecesPlacedNum + 1

            end

        -- piecesPlacedNum = piecesPlacedNum + 1
        -- previousPieceWidth = pieceWidth
        -- previousPieceX = pieceX
        -- pieceY = pieceY - 5

        end

        piecesPlacedNum = piecesPlacedNum + 1

        previousPieceWidth = pieceWidth
        previousPieceX = pieceX

        pieceY = pieceY - 5

        if pieceWidth <= 0 then
            gameState = 'start'

            pieceGoingLeft = true
            pieceWidth = 40
            pieceHeight = 5
            pieceSpeed = 200
            pieceY = VIRTUAL_HEIGHT-pieceHeight
            pieceX = 0
        
            piecesPlaced = {}
            piecesPlacedNum = 0
        
            previousPieceX = 0
            previousPieceWidth = pieceWidth
        
        end
    end


end



--[[
    Called after update by LÖVE2D, used to draw anything to the screen, 
    updated or otherwise.
]]
function love.draw()
    -- begin rendering at virtual resolution
    push:apply('start')

    -- clear the screen with a specific color; in this case, a color similar
    -- to some versions of the original Pong
    love.graphics.clear(40/255, 45/255, 52/255, 255/255)

    -- draw welcome text toward the top of the screen
    love.graphics.setFont(smallFont)
    love.graphics.printf('Crazy Tower', 0, 20, VIRTUAL_WIDTH, 'center')

    -- render first paddle (left side), now using the players' Y variable
    love.graphics.rectangle('fill', pieceX, pieceY, pieceWidth, pieceHeight)

    if  piecesPlacedNum >= 1 then
        for k, v in pairs(piecesPlaced) do
            love.graphics.rectangle('fill', v[1], v[2], v[3], pieceHeight)
        end
    end

    -- draw score on the left and right center of the screen
    -- need to switch font to draw before actually printing
    -- love.graphics.setFont(scoreFont)
    -- love.graphics.print(tostring(piecesPlaced[1]), VIRTUAL_WIDTH / 2 - 50, 
    --     VIRTUAL_HEIGHT / 3)
    -- love.graphics.print(tostring(player2Score), VIRTUAL_WIDTH / 2 + 30,
    --     VIRTUAL_HEIGHT / 3)


   

    -- end rendering at virtual resolution
    push:apply('end')


end



    -- -- player 1 movement
    -- if love.keyboard.isDown('w') then
    --     -- add negative paddle speed to current Y scaled by deltaTime
    --     player1Y = math.max(0, player1Y + -PADDLE_SPEED * dt)
    -- elseif love.keyboard.isDown('s') then
    --     -- add positive paddle speed to current Y scaled by deltaTime
    --     player1Y = math.min(VIRTUAL_HEIGHT - 20, player1Y + PADDLE_SPEED * dt)
    -- end

    -- -- player 2 movement
    -- if love.keyboard.isDown('up') then
    --     -- add negative paddle speed to current Y scaled by deltaTime
    --     player2Y = math.max(0, player2Y + -PADDLE_SPEED * dt)
    -- elseif love.keyboard.isDown('down') then
    --     -- add positive paddle speed to current Y scaled by deltaTime
    --     player2Y = math.min(VIRTUAL_HEIGHT - 20, player2Y + PADDLE_SPEED * dt)
    -- end