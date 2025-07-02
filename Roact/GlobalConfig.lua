--[[
	Exposes a single instance of a configuration as Roact's GlobalConfig.
]]

local Config = getgenv().require("Config")

return Config.new()