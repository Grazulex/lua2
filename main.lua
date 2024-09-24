local love = require("love")
local Player = require "player"

local player = Player

function love.load()

end

function love.update(dt)
    player:update(dt)
end

function love.draw()
    player:draw()
end