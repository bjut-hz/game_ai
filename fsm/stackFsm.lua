local StackFsm = {}

function StackFsm:new(o)
	o = o or {}

	self.__index = self
	setmetatable(o, self)

	local Stack = require("stack")
	o.stack = Stack:new()

	return o
end

function StackFsm:getCurrentState()
	return self.stack:top()
end

function StackFsm:pushState(state)
	local function stateEql(s1, s2)
		if s1 and s2 then
			return (s1[1] == s2[1]) and (s1[2] == s2[2])
		else
			return false
		end
	end

	if not stateEql(self:getCurrentState(), state) then
		self.stack:push(state)
	else
		error("push state error: same state")
	end
end

function StackFsm:popState()
	return self.stack:pop()
end

function StackFsm:update()
	local current_state = self:getCurrentState()

	if current_state then
		-- call table method
		current_state[1](current_state[2])
	end
end

return StackFsm