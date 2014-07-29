Class = require "hump.class"
Vector = require "hump.vector"
Shapes = require "shapes"

local function randomAsteroid()
	local angle = 2 * math.pi * math.random()
	local asteroid = {}
	asteroid.vel = math.random(100, 180) * Vector(math.cos(angle), math.sin(angle))
	asteroid.r = math.random(20, 80)
	local w, h = love.window.getDimensions()

	if angle < math.pi/2 then
		asteroid.pos = Vector(-asteroid.r, -asteroid.r)
	elseif angle < math.pi then
		asteroid.pos = Vector(w + asteroid.r, -asteroid.r)
	elseif angle < 1.5 * math.pi then
		asteroid.pos = Vector(asteroid.r + w, asteroid.r + h)
	else
		asteroid.pos = Vector(asteroid.r, asteroid.r + h)
	end
	return asteroid
end

AsteroidsCtrl = Class {
	init = function(self)
		self.asteroids = {
			randomAsteroid(),
			randomAsteroid(),
			randomAsteroid(),
			randomAsteroid(),
			randomAsteroid(),
			randomAsteroid(),
			randomAsteroid(),
			randomAsteroid(),
			randomAsteroid(),
			randomAsteroid(),
			randomAsteroid(),
		}
	end,
}

function AsteroidsCtrl:update(dt)
	for i, v in ipairs(self.asteroids) do
		v.pos = v.pos + v.vel * dt
	end
end 

function AsteroidsCtrl:draw()
	for i, v in ipairs(self.asteroids) do
		love.graphics.setColor(255, 255, 255)
		love.graphics.circle('line', v.pos.x, v.pos.y, v.r, 40)
	end
end

return AsteroidsCtrl
