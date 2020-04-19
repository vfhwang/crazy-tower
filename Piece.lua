Piece = Class{}


-- Setting up the piece
function Piece:init(width, height,x, y, speed, goingLeft)
    self.width = width
    self.height = height
    self.x = x
    self.y = y
    self.speed = speed
    self.goingLeft = goingLeft
end

-- Reset the piece to default
function Piece:reset()
    self.width = 40
    self.height = 5
    self.x = 0
    self.y = VIRTUAL_HEIGHT-self.height
    self.speed = 200
    self.goingLeft = true
end

-- Once the game starts, make the piece move left and right
function Piece:update(dt)
    if self.goingLeft == true then
        self.x = self.x + self.speed * dt
            if self.x >= VIRTUAL_WIDTH - self.width then
                self.goingLeft = false
            end
        else
            self.x =  self.x - self.speed * dt
            if self.x <= 0 then
                self.goingLeft = true
            end
        end
end

-- Draw the piece to the screen
function Piece:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end