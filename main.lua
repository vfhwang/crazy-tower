

-- push is a library that will allow us to draw our game at a virtual
-- resolution, instead of however large our window is; used to provide
-- a more retro aesthetic
--
-- https://github.com/Ulydev/push
-- push = require 'push'

-- the "Class" library we're using will allow us to represent anything in
-- our game as code, rather than keeping track of many disparate variables and
-- methods
--
-- https://github.com/vrld/hump/blob/master/class.lua
Class = require 'class'
gamera = require 'gamera'


require 'StateMachine'


require 'Fish'
require 'Food'
require 'Score'

-- all code related to game state and state machines
require 'StateMachine'
require 'states/BaseState'
require 'states/PlayState'
require 'states/GameOverState'
require 'states/TitleScreenState'


WINDOW_WIDTH = 900
WINDOW_HEIGHT = 600

PLAY_WIDTH = 500
PLAY_HEIGHT = 500

--Runs when the game first starts up, only once; used to initialize the game.
function love.load()


    love.window.setTitle('Fishy')



    love.graphics.setDefaultFilter('nearest', 'nearest')

        -- initialize window with virtual resolution
        -- push:setupScreen(WINDOW_WIDTH, WINDOW_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        --     fullscreen = false,
        --     resizable = false,
        --     vsync = true
        -- })

        love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
            fullscreen = false,
            resizable = false,
            vsync = true
        })


        gStateMachine = StateMachine {
            ['title'] = function() return TitleScreenState() end,
            ['play'] = function() return PlayState() end,
            ['gameover'] = function() return GameOverState() end,

        }


    -- more "retro-looking" font object we can use for any text
    smallFont = love.graphics.newFont('fonts/Avara-BoldItalic.otf', 12)

    -- larger font for drawing the score on the screen
    titleFont = love.graphics.newFont('fonts/Avara-BoldItalic.otf', 100)

    -- set LÖVE2D's active font to the smallFont obect
    love.graphics.setFont(smallFont)

    gStateMachine:change('title')

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


    cam = gamera.new(0,0,PLAY_WIDTH,PLAY_HEIGHT)
    -- cam:setWindow(10,10,90,90)

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

    love.keyboard.keysPressed = {}

end


--[[
    Called after update by LÖVE2D, used to draw anything to the screen, 
    updated or otherwise.
]]
function love.draw()

    -- push:apply('start')

    love.graphics.clear(40/255, 45/255, 52/255, 255/255)

    gStateMachine:render()
    
    -- push:apply('end')


end

