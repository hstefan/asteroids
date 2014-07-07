local menu = { }

local states = require "states"
states.menu = menu
local gamestate = require "hump.gamestate"
local fonts = require "fonts"
local shapes = require "shapes"
local game = require "game"

function menu:init()
end

function menu:draw()
end

function menu:keyreleased(key, code)
	if key == 'escape' then
		gamestate.switch(states.game)
	end
end

function menu:update(dt)
end

return menu
