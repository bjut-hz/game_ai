local Ant = {cursor_distance = 0, home_distance = 0, leaf_distance = 0}

function Ant:new(o)
	o = o or {}

	self.__index = self
	setmetatable(o, self)

	local Fsm = require("fsm")
	o.brain = Fsm:new()
	-- in find leaf state default
	o.brain:setState(o.findLeaf, o)

	return o
end

function Ant:runAway()
	print("Ant in RunAway state.")

	if self.cursor_distance > 120 then
		self.brain:setState(self.findLeaf, self)
	end
end

function Ant:findLeaf()
	print("Ant in FindLeaf state.")

	if self.cursor_distance <= 120 then
		self.brain:setState(self.runAway, self)
	elseif self.leaf_distance <= 10 then
		self.brain:setState(self.goHome, self)
	end
end

function Ant:goHome()
	print("Ant in GoHome state.")

	if self.home_distance <= 10 then
		self.brain:setState(self.findLeaf, self)
	end
end

function Ant:update()
	self.brain:update()
end

-- Ant test:
local ant_test = Ant:new()

-- in FindLeaf state.
ant_test:update()

-- now in RunAway state.

ant_test.cursor_distance = 130  -- set FindLeaf state.
ant_test:update()

-- now in FindLeaf state.

ant_test.home_distance = 2 -- set GoHome state.
ant_test:update()

-- now in GoHome State.

ant_test:update()