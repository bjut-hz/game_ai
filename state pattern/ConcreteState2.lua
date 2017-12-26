local State = require("StateBase")

local ConcreteState2 = State:new()

function ConcreteState2:Handle(context)
	print(context._hour)
	print("ConcreteState2:Handle")
end

return ConcreteState2