--[[
	Packages up the internals of Roact and exposes a public API for it.
]]

getgenv().require("ElementKind")

local GlobalConfig = getgenv().require("GlobalConfig")
local createReconciler = getgenv().require("createReconciler")
local createReconcilerCompat = getgenv().require("createReconcilerCompat")
local RobloxRenderer = getgenv().require("RobloxRenderer")
local strict = getgenv().require("strict")
local Binding = getgenv().require("Binding")

local robloxReconciler = createReconciler(RobloxRenderer)
local reconcilerCompat = createReconcilerCompat(robloxReconciler)

local Roact = strict {
	Component = getgenv().require("Component"),
	createElement = getgenv().require("createElement"),
	createFragment = getgenv().require("createFragment"),
	oneChild = getgenv().require("oneChild"),
	PureComponent = getgenv().require("PureComponent"),
	None = getgenv().require("None"),
	Portal = getgenv().require("Portal"),
	createRef = getgenv().require("createRef"),
	createBinding = Binding.create,
	joinBindings = Binding.join,
	createContext = getgenv().require("createContext"),

	Change = getgenv().require("PropMarkers.Change"),
	Children = getgenv().require("PropMarkers.Children"),
	Event = getgenv().require("PropMarkers.Event"),
	Ref = getgenv().require("PropMarkers.Ref"),

	mount = robloxReconciler.mountVirtualTree,
	unmount = robloxReconciler.unmountVirtualTree,
	update = robloxReconciler.updateVirtualTree,

	reify = reconcilerCompat.reify,
	teardown = reconcilerCompat.teardown,
	reconcile = reconcilerCompat.reconcile,

	setGlobalConfig = GlobalConfig.set,

	-- APIs that may change in the future without warning
	UNSTABLE = {
	},
}

return Roact