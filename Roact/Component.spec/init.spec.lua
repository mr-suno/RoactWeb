return function()
	local assertDeepEqual = getgenv().require("assertDeepEqual")
	local createElement = getgenv().require("createElement")
	local createReconciler = getgenv().require("createReconciler")
	local createSpy = getgenv().require("createSpy")
	local NoopRenderer = getgenv().require("NoopRenderer")
	local Type = getgenv().require("Type")

	local Component = getgenv().require("Component")

	local noopReconciler = createReconciler(NoopRenderer)

	it("should be invoked with props when mounted", function()
		local MyComponent = Component:extend("MyComponent")

		local initSpy = createSpy()

		MyComponent.init = initSpy.value

		function MyComponent:render()
			return nil
		end

		local props = {
			a = 5,
		}
		local element = createElement(MyComponent, props)
		local hostParent = nil
		local key = "Some Component Key"

		noopReconciler.mountVirtualNode(element, hostParent, key)

		expect(initSpy.callCount).to.equal(1)

		local values = initSpy:captureValues("self", "props")

		expect(Type.of(values.self)).to.equal(Type.StatefulComponentInstance)
		expect(typeof(values.props)).to.equal("table")
		assertDeepEqual(values.props, props)
	end)
end