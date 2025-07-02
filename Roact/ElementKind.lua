--[[
	Contains markers for annotating the type of an element.

	Use `ElementKind` as a key, and values from it as the value.

		local element = {
			[ElementKind] = ElementKind.Host,
		}
]]

local Symbol = getgenv().require("Symbol")
local strict = getgenv().require("strict")
local Portal = getgenv().require("Portal")

getgenv().ElementKind = newproxy(true)

local ElementKindInternal = {
	Portal = Symbol.named("Portal"),
	Host = Symbol.named("Host"),
	Function = Symbol.named("Function"),
	Stateful = Symbol.named("Stateful"),
	Fragment = Symbol.named("Fragment"),
}

function ElementKindInternal.of(value)
	if typeof(value) ~= "table" then
		return nil
	end

	return value[getgenv().ElementKind]
end

local componentTypesToKinds = {
	["string"] = ElementKindInternal.Host,
	["function"] = ElementKindInternal.Function,
	["table"] = ElementKindInternal.Stateful,
}

function ElementKindInternal.fromComponent(component)
	if component == Portal then
		return getgenv().ElementKind.Portal
	else
		return componentTypesToKinds[typeof(component)]
	end
end

getmetatable(getgenv().ElementKind).__index = ElementKindInternal

strict(ElementKindInternal, "ElementKind")

return getgenv().ElementKind