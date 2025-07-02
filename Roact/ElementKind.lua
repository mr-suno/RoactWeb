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

local ElementKind = newproxy(true)

local ElementKindInternal = {
	Portal = Symbol.named("Portal"),
	Host = Symbol.named("Host"),
	Function = Symbol.named("Function"),
	Stateful = Symbol.named("Stateful"),
	Fragment = Symbol.named("Fragment"),
}

local function prettyPrintTable(tbl, indent)
    indent = indent or 0
    local indentStr = string.rep("  ", indent)  -- Create indentation string
    local result = "{\n"

    for key, value in pairs(tbl) do
        result = result .. indentStr .. "  [" .. tostring(key) .. "] = "
        if type(value) == "table" then
            result = result .. prettyPrintTable(value, indent + 1)  -- Recursive call for nested tables
        else
            result = result .. tostring(value) .. ",\n"
        end
    end

    return result .. indentStr .. "},\n"
end

function ElementKindInternal.of(value)
    print("ElementKind.of called with:", prettyPrintTable(value))  -- Print the value being checked
    if typeof(value) ~= "table" then
        return nil
    end

    local kind = value[ElementKind]
    print("Returning kind:", kind)  -- Print the kind being returned
    return kind
end

local componentTypesToKinds = {
	["string"] = ElementKindInternal.Host,
	["function"] = ElementKindInternal.Function,
	["table"] = ElementKindInternal.Stateful,
}

function ElementKindInternal.fromComponent(component)
    if component == Portal then
        return ElementKind.Portal
    end

    local kind = componentTypesToKinds[typeof(component)]
    if kind then
        return kind
    else
        -- Handle unexpected component types
        print("Warning: Unknown component type for:", component)
        return nil  -- or return a default kind if appropriate
    end
end

getmetatable(ElementKind).__index = ElementKindInternal

strict(ElementKindInternal, "ElementKind")

return ElementKind
