-- save all the defined class, and subclass can get element from this
local _class={}
function class(super)
	local class_type = {}
	class_type.ctor = false
	class_type.super = super
	class_type.new = function(...)
				local obj = {}
				do
					local create
					create = function(c,...)
						if c.super then
							create(c.super,...)
						end
						if c.ctor then
							c.ctor(obj,...)
						end
					end

					create(class_type,...)
				end
				setmetatable(obj,{ __index= _class[class_type] })
				return obj
			end

	-- vtbl save all the element of class_type
	local vtbl = {}
	_class[class_type] = vtbl

	setmetatable(class_type, {__newindex=
		function(_, k, v)
			vtbl[k] = v
		end
	})

	if super then
		-- find the element from super class and save it in vtbl
		setmetatable(vtbl, {__index=
			function(_, k)
				local ret= _class[super][k]
				vtbl[k] = ret
				return ret
			end
		})
	end

	return class_type
end