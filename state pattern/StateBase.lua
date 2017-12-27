local State = {}

function State:new(v)
	v = v or {}

	self.__index = self
	setmetatable(v, self)

	return v
end

function State:handle(context)
	print("in State base.")
end

return State