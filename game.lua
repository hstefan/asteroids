local game = {}

local states = require "states"
states.game = game

Ship = require "ship"
Vector = require "hump.vector"

function game:enter()
end

function game:init()
	self.ship = Ship(Vector(100, 100))
end

function game:draw()
	self.ship:draw()
end

function game:update(dt)
	self.ship:update(dt)
end

return game
