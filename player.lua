local love = require("love")
local anim8 = require("anim8.anim8")

Player = {
    currentAction = "walk",
    currentDirection = "left",
    currentFrame = 1,
    frameDuration = 0.1,
    actions = {
        walk = {
            img = "assets/Base Character - Premium/basic/walk.png",
            directions = {
                left = {
                    {32, 32, 16, 16},
                    {112, 32, 16, 16},
                    {192, 32, 16, 16},
                    {272, 32, 16, 16},
                    {352, 32, 16, 16},
                    {432, 32, 16, 16},
                    {512, 32, 16, 16},
                    {592, 32, 16, 16}
                },
                right = {
                    {32, 112, 16, 16},
                    {112, 112, 16, 16},
                    {192, 112, 16, 16},
                    {272, 112, 16, 16},
                    {352, 112, 16, 16},
                    {432, 112, 16, 16},
                    {512, 112, 16, 16},
                    {592, 112, 16, 16}
                }
            }
        }
    }
}

-- Base class method new

function Player:init()
    for i, action in pairs(self.actions) do
        Img = love.graphics.newImage(action.img)
        for j, direction in pairs(action.directions) do
            Directions = {}
            Directions[j] = {}
            for k, frame in pairs(direction) do
                local x, y, w, h = unpack(frame)
                local quad = love.graphics.newQuad(x, y, w, h, Img)
                table.insert(Directions[j], quad)
            end
        end
    end
end


function Player:update(dt)
    self.frameTimer = (self.frameTimer or 0) + dt
    local frameDuration = self.frameDuration

    if self.frameTimer >= frameDuration then
        self.frameTimer = self.frameTimer - frameDuration
        self.currentFrame = self.currentFrame + 1
        local size = 0
        for _ in pairs(self.actions[self.currentAction].directions[self.currentDirection]) do size = size + 1 end
        if self.currentFrame > tonumber(size) then
            self.currentFrame = 1
        end
    end
end

function Player:draw()
    love.graphics.draw(love.graphics.newImage(self.actions[self.currentAction].img), Directions[self.currentDirection][self.currentFrame], 100, 100)
end

Player:init()

return Player