--[[
	Packages up the internals of Roact and exposes a public API for it.
]]

getgenv().RoactWeb__require("Symbol")
getgenv().RoactWeb__require("PropMarkers.Children")
getgenv().RoactWeb__require("PropMarkers.Ref")
getgenv().RoactWeb__require("ElementKind")
getgenv().RoactWeb__require("Type")

local GlobalConfig = getgenv().RoactWeb__require("GlobalConfig")
local createReconciler = getgenv().RoactWeb__require("createReconciler")
local createReconcilerCompat = getgenv().RoactWeb__require("createReconcilerCompat")
local RobloxRenderer = getgenv().RoactWeb__require("RobloxRenderer")
local strict = getgenv().RoactWeb__require("strict")
local Binding = getgenv().RoactWeb__require("Binding")

local robloxReconciler = createReconciler(RobloxRenderer)
local reconcilerCompat = createReconcilerCompat(robloxReconciler)

local Roact = strict {
	Component = getgenv().RoactWeb__require("Component"),
	createElement = getgenv().RoactWeb__require("createElement"),
	createFragment = getgenv().RoactWeb__require("createFragment"),
	oneChild = getgenv().RoactWeb__require("oneChild"),
	PureComponent = getgenv().RoactWeb__require("PureComponent"),
	None = getgenv().RoactWeb__require("None"),
	Portal = getgenv().RoactWeb__require("Portal"),
	createRef = getgenv().RoactWeb__require("createRef"),
	createBinding = Binding.create,
	joinBindings = Binding.join,
	createContext = getgenv().RoactWeb__require("createContext"),

	Change = getgenv().RoactWeb__require("PropMarkers.Change"),
	Children = getgenv().Children,
	Event = getgenv().RoactWeb__require("PropMarkers.Event"),
	Ref = getgenv().Ref,

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

print("[!] Loaded RoactWeb using version: 3")

return Roact
