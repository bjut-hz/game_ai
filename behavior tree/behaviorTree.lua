require("class")

local Status = {READY = 0, RUNNING = 1, FAILED = 2, SUCCESS = 3}


Action = class()
function Action:ctor(task)
    self.task = task
    self.status = Status.READY
end

function Action.task(ctx)
    print("default task, return success.")
    return Status.SUCCESS
end

function Action:update(ctx)
    if self.status == Status.READY or self.status == Status.RUNNING then
        if self.task then
            self.status = self.task(ctx)
        end
    end
    return self.status
end

Selector = class()
function Selector:ctor(children)
    self.children = children
    self.status = Status.READY
end

function Selector:update(ctx)
    if self.status == Status.READY or self.status == Status.RUNNING then
        for _, v in ipairs(self.children) do
            local res = v:update(ctx)
            -- success or running
            if Status.FAILED ~= res then
                self.status = res
                return res
            end
        end
        self.status = Status.FAILED
    end
end

Sequence = class()
function Sequence:ctor(children)
    self.children = children
    self.status = Status.READY
end

function Sequence:update(ctx)
    if self.status == Status.READY or self.status == Status.RUNNING then
        for _,v in ipairs(self.children) do
            local res = v:update(ctx)
            self.status = res
            if res == Status.FAILED then
                return res
            end
        end

        if self.status ~= Status.RUNNING then
            self.status = Status.SUCCESS
        end
    end
end

-- test
local act1 = Action.new(function(ctx)
    print("act1.task: ")
    return Status.SUCCESS
end)

local act2 = Action.new(function(ctx)
    print("act2.task: ")
    return Status.SUCCESS
end)


local act3 = Action.new(function(ctx)
    print("act3.task: ")
    return Status.FAILED
end)

math.randomseed(os.time()) 
local act4 = Action.new(function(ctx)
    print("act4.task: ")
    local num = math.random(10)
    if num < 5 then
        return Status.SUCCESS
    end
    return Status.RUNNING
end)

local bt = Sequence.new({
    Selector.new({act1, act2, act3}),
    act4,
})

for i=1, 100 do
    bt:update()
end