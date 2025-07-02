--[[
	Contains markers for annotating objects with types.

	To set the type of an object, use `Type` as a key and the actual marker as
	the value:

		local foo = {
			[Type] = Type.Foo,
		}
]]

local Symbol = getgenv().require("Symbol")
local strict = getgenv().require("strict")

getgenv().Type = newproxy(true)

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

	return value[getgenv().Type]
end

getmetatable(getgenv().Type).__index = TypeInternal

getmetatable(getgenv().Type).__tostring = function()
	return "RoactType"
end

strict(TypeInternal, "Type")

return getgenv().Type