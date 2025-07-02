local ElementKind = getgenv().RoactWeb__ElementKind
local Type = getgenv().RoactWeb__Type

local function createFragment(elements)
	return {
		[Type] = Type.Element,
		[ElementKind] = ElementKind.Fragment,
		elements = elements,
	}
end

return createFragment
