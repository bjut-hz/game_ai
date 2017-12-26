local ConcreteState1 = require("ConcreteState1")
local ConcreteState2 = require("ConcreteState2")
local Context = require("Context")

local ct1 = ConcreteState1:new()
local ct2 = ConcreteState2:new()

local context = Context:new()

context:SetState(ct1)
context:SetHour(10)
context:Handle()

context:SetState(ct2)
context:SetHour(1000)
context:Handle()