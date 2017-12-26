local Context = {_state = nil, _hour = 0}

function Context:new(v)
	v = v or {}

	self.__index = self
	setmetatable(v, self)

	return v
end

function Context:Handle()
	self._state:Handle(self)
end

function Context:SetState(state)
	self._state = state
end

function Context:SetHour(hour)
	self._hour = hour
end

return Context