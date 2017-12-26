local State = require("StateBase")

local ConcreteState1 = State:new()

function ConcreteState1:Handle(context)
	print(context._hour)
	print("ConcreteState1:Handle")
end

return ConcreteState1