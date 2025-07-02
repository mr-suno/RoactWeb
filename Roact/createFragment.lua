local ElementKind = getgenv().ElementKind
local Type = getgenv().require("Type")

local function createFragment(elements)
	return {
		[Type] = Type.Element,
		[ElementKind] = ElementKind.Fragment,
		elements = elements,
	}
end

return createFragment