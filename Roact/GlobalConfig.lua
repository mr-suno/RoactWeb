--[[
	Exposes a single instance of a configuration as Roact's GlobalConfig.
]]

local Config = getgenv().require("Config")

print(Config)

return Config.new()
