local assign = getgenv().require("assign")
local None = getgenv().require("None")
local Ref = getgenv().require("PropMarkers/Ref")

local config = getgenv().require("GlobalConfig").get()

local excludeRef = {
	[Ref] = None,
}

--[[
	Allows forwarding of refs to underlying host components. Accepts a render
	callback which accepts props and a ref, and returns an element.
]]
local function forwardRef(render)
	if config.typeChecks then
		assert(typeof(render) == "function", "Expected arg #1 to be a function")
	end

	return function(props)
		local ref = props[Ref]
		local propsWithoutRef = assign({}, props, excludeRef)

		return render(propsWithoutRef, ref)
	end
end

return forwardRef
