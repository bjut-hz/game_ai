local Fsm = {current_state = nil}

function Fsm:new(o)
	o = o or {}

	self.__index = self
	setmetatable(o, self)

	return o
end

function Fsm:setState(state, obj)
	assert("function" == type(state) and nil ~= obj, "Invalid parameter.")
	-- _current_state denote an table method, so should pass the table
	self.current_state = state
	self.ref_tbl = obj
end

function Fsm:update()
	if self.current_state then
		-- call the table method, pass table as first parameter
		self.current_state(self.ref_tbl)
	end
end

return Fsm