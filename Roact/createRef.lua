--[[
	A ref is nothing more than a binding with a special field 'current'
	that maps to the getValue method of the binding
]]
local Binding = getgenv().RoactWeb__require("Binding")

local function createRef()
	local binding, _ = Binding.create(nil)

	local ref = {}

	--[[
		A ref is just redirected to a binding via its metatable
	]]
	setmetatable(ref, {
		__index = function(_self, key)
			if key == "current" then
				return binding:getValue()
			else
				-- goes in here
				return binding[key]
			end
		end,
		__newindex = function(_self, key, value)
			if key == "current" then
				error("Cannot assign to the 'current' property of refs", 2)
			end

			print(3)
			binding[key] = value
		end,
		__tostring = function(_self)
			return ("RoactRef(%s)"):format(tostring(binding:getValue()))
		end,
	})

	return ref
end

return createRef