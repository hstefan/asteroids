Class = require "hump.class"
Vector = require "hump.vector"

Ship = Class {
	init = function(self, pos)
		self.pos = pos
		self.sprite = love.graphics.newImage('data/ship.png')
		self.size = Vector(self.sprite:getWidth(), self.sprite:getHeight())
		self.sprtheta = -math.pi / 2
		self.mass = 0.0025
		self.force = Vector(0, 0)
		self.vel = Vector(0, 0)
	end,
}

function Ship:update(dt)
	if love.keyboard.isDown('up') then
		self.force = Vector(0, -1)
	elseif love.keyboard.isDown('down') then
		self.force = Vector(0, 1)
	else
		self.force = -self.force
	end

	self.pos = self.pos + self.vel * dt
	self.vel = self.vel + (self.force * 1/self.mass ) * dt
	print(self.vel)
end

function Ship:draw()
	love.graphics.draw(self.sprite, self.pos.x, self.pos.y, self.theta, 1, 1,
		self.size.x/2, self.size.y/2)
end

return Ship
