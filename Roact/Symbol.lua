--[[
	A 'Symbol' is an opaque marker type.

	Symbols have the type 'userdata', but when printed to the console, the name
	of the symbol is shown.
]]

getgenv().RoactWeb__Symbol = {}

--[[
	Creates a Symbol with the given name.

	When printed or coerced to a string, the symbol will turn into the string
	given as its name.
]]
getgenv().RoactWeb__Symbol.named = function(name)
	assert(type(name) == "string", "Symbols must be created using a string name!")

	local self = newproxy(true)

	local wrappedName = ("Symbol(%s)"):format(name)

	getmetatable(self).__tostring = function()
		return wrappedName
	end

	return self
end

return getgenv().RoactWeb__Symbol