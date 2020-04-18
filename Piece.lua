Piece = Class{}


function Piece:init(width, height,x, y, speed, goingLeft)
    self.width = width
    self.height = height
    self.x = x
    self.y = y
    self.speed = speed
    self.goingLeft = goingLeft
end


function Piece:reset()
    self.width = 40
    self.height = 5
    self.x = 0
    self.y = VIRTUAL_HEIGHT-self.height
    self.speed = 200
    self.goingLeft = true
end

function Piece:update(dt)

end


function Piece:render()


end