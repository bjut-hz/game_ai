local State = require("stateBase")

local ConcreteState1 = State:new()

function ConcreteState1:handle(context)
	print(context:getHour())
	print("ConcreteState1:handle")
end

return ConcreteState1