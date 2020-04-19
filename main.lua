

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

require 'StateMachine'

require 'Piece'
require 'Tower'
require 'Score'

-- all code related to game state and state machines
require 'StateMachine'
require 'states/BaseState'
require 'states/PlayState'
require 'states/ScoreState'
require 'states/TitleScreenState'

WINDOW_WIDTH = 320
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 108
VIRTUAL_HEIGHT = 243


--Runs when the game first starts up, only once; used to initialize the game.
function love.load()


    love.window.setTitle('Crazy Tower')



    love.graphics.setDefaultFilter('nearest', 'nearest')

        -- initialize window with virtual resolution
        push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
            fullscreen = false,
            resizable = false,
            vsync = true
        })

        gStateMachine = StateMachine {
            ['title'] = function() return TitleScreenState() end,
            ['play'] = function() return PlayState() end,
        }

        gStateMachine:change('title')

    -- more "retro-looking" font object we can use for any text
    smallFont = love.graphics.newFont('font.ttf', 12)

    -- larger font for drawing the score on the screen
    scoreFont = love.graphics.newFont('font.ttf', 28)

    -- set LÖVE2D's active font to the smallFont obect
    love.graphics.setFont(smallFont)


    -- love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
    --     fullscreen = false,
    --     resizable = false,
    --     vsync = true
    -- })

    sounds = {
        ['paddle_hit'] = love.audio.newSource('sounds/paddle_hit.wav', 'static'),
        ['score'] = love.audio.newSource('sounds/score.wav', 'static'),
        ['wall_hit'] = love.audio.newSource('sounds/wall_hit.wav', 'static')
    }

    -- math.randomseed(os.time())


    previousPieceX = 0
    previousPieceWidth = pieceWidth

    piece = Piece(40, 5,0, VIRTUAL_HEIGHT-5, 200, true)
    tower = Tower(0,{})
    score = Score(0)

    gameState = 'play'

    -- initialize input table
    love.keyboard.keysPressed = {}


end



function love.keypressed(key)
    -- add to our table of keys pressed this frame
    love.keyboard.keysPressed[key] = true
    
    if key == 'escape' then
        love.event.quit()
    end
end

--[[
    New function used to check our global input table for keys we activated during
    this frame, looked up by their string value.
]]
function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
        return true
    else
        return false
    end
end
--[[
    Runs every frame, with "dt" passed in, our delta in seconds 
    since the last frame, which LÖVE2D supplies us.
]]
function love.update(dt)

    gStateMachine:update(dt)


    if gameState =='play' then

        piece:update(dt)
        score:update()

        if piece.width == 0 then
            gameState = 'gameOver'
        end

    end

    if gameState =='gameOver' then

        piece:reset()
        -- tower:reset()
        -- score:reset()

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

        piece:reset()
        tower:reset()
        score:reset()

        end
    end

    if key == 'space' then
        tower:update()
    end



end



--[[
    Called after update by LÖVE2D, used to draw anything to the screen, 
    updated or otherwise.
]]
function love.draw()

    push:apply('start')

    gStateMachine:render()
    
    -- clear the screen with a specific color


    if gameState =='gameOver' then
        love.graphics.clear(40/255, 45/255, 52/255, 255/255)
        tower:render()
        score:render()

        love.graphics.printf('Game Over', 0, 40, VIRTUAL_WIDTH, 'center')


    end

    push:apply('end')


end

