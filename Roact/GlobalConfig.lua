--[[
	Exposes a single instance of a configuration as Roact's GlobalConfig.
]]

local Config = getgenv().RoactWeb__require("Config")

return Config.new()