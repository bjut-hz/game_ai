local MOUSE_THREAT_RADIUS = 120
local Ant = {cursor_distance = 0, home_distance = 0, leaf_distance = 0}

function Ant:new(o)
	o = o or {}

	self.__index = self
	setmetatable(o, self)

	local Fsm = require("stackFsm")
	o.brain = Fsm:new()
	-- in find leaf state default
	o.brain:pushState({o.findLeaf, o})

	return o
end

function Ant:runAway()
	print("Ant in RunAway state.")

	if self.cursor_distance > MOUSE_THREAT_RADIUS then
		self.brain:popState()
	end
end

function Ant:findLeaf()
	print("Ant in FindLeaf state.")

	if self.leaf_distance <= 10 then
		self.brain:popState()
		self.brain:pushState({self.goHome, self})
	end

	if self.cursor_distance <= MOUSE_THREAT_RADIUS then
		self.brain:pushState({self.runAway, self})
	end
end

function Ant:goHome()
	print("Ant in GoHome state.")

	if self.home_distance <= 10 then
		self.brain:popState()
		self.brain:pushState({self.findLeaf, self})
	end

	if self.cursor_distance <= MOUSE_THREAT_RADIUS then
		self.brain:pushState({self.runAway, self})
	end
end

function Ant:update()
	self.brain:update()
end



-- Ant test:
local ant_test = Ant:new()

-- now in findLeaf state
ant_test.leaf_distance = 100
ant_test.cursor_distance = 50

ant_test:update()

-- now in runAway state
ant_test.cursor_distance = 150
ant_test:update()

-- now back to findLeaf state
ant_test.leaf_distance = 5
ant_test:update()

-- now in goHome state.
ant_test.home_distance = 12
ant_test.cursor_distance = 100
ant_test:update()

-- now in runAway state.
ant_test.cursor_distance = 150
ant_test:update()

-- now back to goHome state.
ant_test:update()