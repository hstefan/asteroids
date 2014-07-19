Class = require "hump.class"
Vector = require "hump.vector"
Util = require "util"

Ship = Class {
	init = function(self, pos)
		self.pos = pos
		self.sprite = love.graphics.newImage('data/ship.png')
		self.size = Vector(self.sprite:getWidth(), self.sprite:getHeight())
		self.mass = 0.0025
		self.force = Vector(0, 0)
		self.vel = Vector(0, 0)
		self.rvel = 0.0
		self.racc = 0.01
		self.theta = math.pi/2
		self.topSpeed = 300
		self.screenSurface = { w = 800, h = 600 }
	end,
}

function Ship:calculateForce(dt)
	if love.keyboard.isDown('up') then
		return Vector(math.cos(self.theta), math.sin(self.theta))
	elseif love.keyboard.isDown('down') then
		return -Vector(math.cos(self.theta), math.sin(self.theta))
	end
	return Vector(0, 0)
end

function Ship:calculateRadialAccel(dt)
	if love.keyboard.isDown('left') then
		return -5
	elseif love.keyboard.isDown('right') then
		return 5
	end
	return 0
end

function Ship:clipToBounds()
	self.pos.x = self.pos.x % self.screenSurface.w
	self.pos.y = self.pos.y % self.screenSurface.h
end

function Ship:update(dt)
	self.racc = self:calculateRadialAccel(dt)
	self.rvel = Util.clamp(self.rvel + self.racc * dt, -5, 5)
	self.theta = self.theta + self.rvel * dt
	
	self.force = self:calculateForce(dt)
	self.pos = self.pos + self.vel * dt
	self.vel = self.vel + (self.force * 1/self.mass) * dt

	if self.vel:len() > self.topSpeed then
		self.vel = self.topSpeed * self.vel:normalized()
	end

	self:clipToBounds()
end

function Ship:draw()
	love.graphics.draw(self.sprite, self.pos.x, self.pos.y,
		self.theta - math.pi/2,
		1, 1, self.size.x/2, self.size.y/2)
	love.graphics.line(self.pos.x, self.pos.y,
		self.pos.x + self.vel.x/4,
		self.pos.y + self.vel.y/4)
end

return Ship
