local State = require("stateBase")

local ConcreteState2 = State:new()

function ConcreteState2:handle(context)
	print(context:getHour())
	print("ConcreteState2:handle")
end

return ConcreteState2