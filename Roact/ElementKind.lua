--[[
	Contains markers for annotating the type of an element.

	Use `ElementKind` as a key, and values from it as the value.

		local element = {
			[ElementKind] = ElementKind.Host,
		}
]]

local Symbol = getgenv().RoactWeb__Symbol
local strict = getgenv().RoactWeb__require("strict")
local Portal = getgenv().RoactWeb__require("Portal")

getgenv().RoactWeb__EK = newproxy(true)
getgenv().RoactWeb__ElementKind = {
	Portal = Symbol.named("Portal"),
	Host = Symbol.named("Host"),
	Function = Symbol.named("Function"),
	Stateful = Symbol.named("Stateful"),
	Fragment = Symbol.named("Fragment"),
}

getgenv().RoactWeb__ElementKind.of = function(value)
	if typeof(value) ~= "table" then
		return nil
	end

	return value[getgenv().RoactWeb__EK]
end

local componentTypesToKinds = {
	["string"] = getgenv().RoactWeb__ElementKind.Host,
	["function"] = getgenv().RoactWeb__ElementKind.Function,
	["table"] = getgenv().RoactWeb__ElementKind.Stateful,
}

getgenv().RoactWeb__ElementKind.fromComponent = function(component)
	if component == Portal then
		return getgenv().ElementKind.Portal
	else
		return componentTypesToKinds[typeof(component)]
	end
end

getmetatable(getgenv().RoactWeb__EK).__index = getgenv().RoactWeb__ElementKind

strict(getgenv().RoactWeb__ElementKind, "ElementKind")

return getgenv().RoactWeb__EK