return function()
	local createElement = getgenv().require("createElement")
	local createReconciler = getgenv().require("createReconciler")
	local createSpy = getgenv().require("createSpy")
	local NoopRenderer = getgenv().require("NoopRenderer")
	local Type = getgenv().require("Type")

	local Component = getgenv().require("Component")

	local noopReconciler = createReconciler(NoopRenderer)

	it("should be invoked when unmounted", function()
		local MyComponent = Component:extend("MyComponent")

		local willUnmountSpy = createSpy()

		MyComponent.willUnmount = willUnmountSpy.value

		function MyComponent:render()
			return nil
		end

		local element = createElement(MyComponent)
		local hostParent = nil
		local key = "Test"

		local node = noopReconciler.mountVirtualNode(element, hostParent, key)
		noopReconciler.unmountVirtualNode(node)

		expect(willUnmountSpy.callCount).to.equal(1)

		local values = willUnmountSpy:captureValues("self")

		expect(Type.of(values.self)).to.equal(Type.StatefulComponentInstance)
	end)
end