--[[
	Contains markers for annotating objects with types.

	To set the type of an object, use `Type` as a key and the actual marker as
	the value:

		local foo = {
			[Type] = Type.Foo,
		}
]]

local Symbol = getgenv().RoactWeb__Symbol
local strict = getgenv().RoactWeb__require("strict")

getgenv().RoactWeb__Type = newproxy(true)

local TypeInternal = {}

local function addType(name)
	TypeInternal[name] = Symbol.named("Roact" .. name)
end

addType("Binding")
addType("Element")
addType("HostChangeEvent")
addType("HostEvent")
addType("StatefulComponentClass")
addType("StatefulComponentInstance")
addType("VirtualNode")
addType("VirtualTree")

function TypeInternal.of(value)
	if typeof(value) ~= "table" then
		return nil
	end

	return value[getgenv().RoactWeb__Type]
end

getmetatable(getgenv().RoactWeb__Type).__index = TypeInternal

getmetatable(getgenv().RoactWeb__Type).__tostring = function()
	return "RoactType"
end

strict(TypeInternal, "Type")

return getgenv().RoactWeb__Type