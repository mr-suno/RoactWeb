return function()
	local createElement = getgenv().require("createElement")
	local createReconciler = getgenv().require("createReconciler")
	local createSpy = getgenv().require("createSpy")
	local NoopRenderer = getgenv().require("NoopRenderer")
	local Type = getgenv().require("Type")

	local Component = getgenv().require("Component")

	local noopReconciler = createReconciler(NoopRenderer)

	it("should be invoked when mounted", function()
		local MyComponent = Component:extend("MyComponent")

		local didMountSpy = createSpy()

		MyComponent.didMount = didMountSpy.value

		function MyComponent:render()
			return nil
		end

		local element = createElement(MyComponent)
		local hostParent = nil
		local key = "Test"

		noopReconciler.mountVirtualNode(element, hostParent, key)

		expect(didMountSpy.callCount).to.equal(1)

		local values = didMountSpy:captureValues("self")

		expect(Type.of(values.self)).to.equal(Type.StatefulComponentInstance)
	end)
end
