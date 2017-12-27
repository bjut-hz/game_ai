-- we can use another table to implement the privacy mechanisms

local Context = {_state = nil, _hour = 0}

function Context:new(v)
	v = v or {}

	self.__index = self
	setmetatable(v, self)

	return v
end

function Context:handle()
	self._state:handle(self)
end

function Context:setState(state)
	-- use __newindex meta method and create a _state variable
	self._state = state
end

function Context:setHour(hour)
	-- use __newindex meta method and create a _hour variable
	self._hour = hour
end

function Context:getHour()
	return self._hour
end

return Context