local Stack = {}

function Stack:new(o)
	o = o or {}

	self.__index = self
	setmetatable(o, self)

	return o
end

function Stack:push(v)
	assert(v, "push error: can not push nil")

	table.insert(self, v)
end

function Stack:top()
	return self[#self]
end

function Stack:pop()
	assert(0 ~= #self, "pop error: no element in stack now!")
	table.remove(self)
end

return Stack

-- Stack test

-- local stk = Stack:new()

-- stk:push(1)
-- stk:push(55)

-- print(stk:top())
-- stk:pop()
-- print(stk:top())
-- stk:pop()


