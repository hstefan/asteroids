local util = {}

function util.clamp(x, xi, xf)
	if x < xi then
		x = xi
	elseif x > xf then
		x = xf
	end
	return x
end

return util
