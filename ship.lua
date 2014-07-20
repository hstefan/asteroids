Class = require "hump.class"
Vector = require "hump.vector"
Util = require "util"

Ship = Class {
	init = function(self, pos)
		self.pos = pos
		self.sprite = love.graphics.newImage('data/ship.png')
		self.size = Vector(self.sprite:getWidth(), self.sprite:getHeight())
		self.mass = 0.001
		self.force = Vector(0, 0)
		self.vel = Vector(0, 0)
		self.rvel = 0.0
		self.racc = 0.03
		self.theta = math.pi/2
		self.topSpeed = 400
		self.screenSurface = { w = 800, h = 600 }
		self.thrust = 0
	end,
}

function Ship:calculateForce(dt)
	return (self.thrust * (Vector(0, 1) + 10 * Vector(math.cos(self.theta), math.sin(self.theta))))
end

function Ship:calculateRadialAccel(dt)
	if love.keyboard.isDown('left') then
		return -5
	elseif love.keyboard.isDown('right') then
		return 5
	end
	return 0
end

function Ship:calculateThrustAccel(dt)
	if love.keyboard.isDown('up') then
		return -2
	end
	return 0
end

function Ship:calculateThrust(dt)
	if love.keyboard.isDown('down') then
		return self.thrust * 0.2
	end
	return Util.clamp(self.thrust + self:calculateThrustAccel(dt) * dt, -1, 1)
end

function Ship:drag(dt)
	if love.keyboard.isDown('down') then
		return 0.9
	end
	return 1
end

function Ship:clipToBounds()
	self.pos.x = self.pos.x % self.screenSurface.w
	self.pos.y = self.pos.y % self.screenSurface.h
end

function Ship:update(dt)
	self.racc = self:calculateRadialAccel(dt)
	self.rvel = Util.clamp(self.rvel + self.racc * dt, -3, 3)
	self.theta = self.theta + self.rvel * dt
	
	self.thrust = self:calculateThrust(dt)
	self.force = self:drag(dt) * self:calculateForce(dt)
	self.vel = self:drag(dt) * (self.vel + (self.force * 1/self.mass) * dt)
	self.pos = self.pos + self.vel * dt
	if self.vel:len() > self.topSpeed then
		self.vel = self.topSpeed * self.vel:normalized()
	end

	self:clipToBounds()
end

function Ship:draw()
	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(self.sprite, self.pos.x, self.pos.y,
		self.theta - math.pi/2,
		1, 1, self.size.x/2, self.size.y/2)

	love.graphics.setColor(0, 255, 0)
	love.graphics.line(self.pos.x, self.pos.y,
		self.pos.x + self.vel.x/5,
		self.pos.y + self.vel.y/5)
end

return Ship
