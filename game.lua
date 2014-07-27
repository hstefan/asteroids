local game = {}

local states = require "states"
states.game = game

Ship = require "ship"
AsteroidsCtrl = require "asteroidsctrl"
Vector = require "hump.vector"

function game:enter()
end

function game:init()
	math.randomseed(os.time())
	self.ship = Ship(Vector(100, 100))
	self.asteroidsCtrl = AsteroidsCtrl()
end

function game:draw()
	self.asteroidsCtrl:draw()
	self.ship:draw()
end

function game:update(dt)
	self.asteroidsCtrl:update(dt)
	self.ship:update(dt)
end

return game
