local ConcreteState1 = require("concreteState1")
local ConcreteState2 = require("concreteState2")
local Context = require("context")

local ct1 = ConcreteState1:new()
local ct2 = ConcreteState2:new()

local context = Context:new()

context:setState(ct1)
context:setHour(10)
context:handle()

context:setState(ct2)
context:setHour(1000)
context:handle()

print(Context:getHour())