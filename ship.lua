Class = require "hump.class"
Vector = require "hump.vector"

Ship = Class {
	init = function(self, pos)
		self.pos = pos
		self.acc = Vector(0, 0)
		self.vel = Vector(0, 0)
		self.theta = 0.0
		self.rvel = 4
		self.pvel = 400
		self.sprite = love.graphics.newImage('data/ship.png')
		self.size = Vector(self.sprite:getWidth(), self.sprite:getHeight())
		self.sprtheta = -math.pi / 2
	end,
}

function Ship:update(dt)
	if love.keyboard.isDown('up') then
		self.vel = Vector(math.cos(self.sprtheta + self.theta), math.sin(self.sprtheta + self.theta))
	elseif love.keyboard.isDown('down') then
		self.vel = Vector(math.cos(self.sprtheta + self.theta), math.sin(self.sprtheta + self.theta))
	else
		self.vel = Vector(0, 0)
	end

	if love.keyboard.isDown('left') then
		self.theta = self.theta - self.rvel * dt
	elseif love.keyboard.isDown('right') then
		self.theta = self.theta + self.rvel * dt
	end

	self.theta = self.theta % (2 * math.pi)
	self.pos = self.pos + self.vel * dt * self.pvel
end

function Ship:draw()
	love.graphics.draw(self.sprite, self.pos.x, self.pos.y, self.theta, 1, 1,
		self.size.x/2, self.size.y/2)
end

return Ship
