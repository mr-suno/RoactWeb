return function()
	local assertDeepEqual = getgenv().require("assertDeepEqual")
	local createElement = getgenv().require("createElement")
	local createReconciler = getgenv().require("createReconciler")
	local createSpy = getgenv().require("createSpy")
	local NoopRenderer = getgenv().require("NoopRenderer")
	local Type = getgenv().require("Type")

	local Component = getgenv().require("Component")

	local noopReconciler = createReconciler(NoopRenderer)

	it("should be invoked when updated via updateVirtualNode", function()
		local MyComponent = Component:extend("MyComponent")

		local didUpdateSpy = createSpy()
		MyComponent.didUpdate = didUpdateSpy.value

		function MyComponent:render()
			return nil
		end

		local initialProps = {
			a = 5,
		}
		local initialElement = createElement(MyComponent, initialProps)
		local hostParent = nil
		local key = "Test"

		local virtualNode = noopReconciler.mountVirtualNode(initialElement, hostParent, key)

		expect(didUpdateSpy.callCount).to.equal(0)

		local newProps = {
			a = 6,
			b = 2,
		}
		local newElement = createElement(MyComponent, newProps)
		noopReconciler.updateVirtualNode(virtualNode, newElement)

		expect(didUpdateSpy.callCount).to.equal(1)

		local values = didUpdateSpy:captureValues("self", "oldProps", "oldState")

		expect(Type.of(values.self)).to.equal(Type.StatefulComponentInstance)
		assertDeepEqual(values.oldProps, initialProps)
		assertDeepEqual(values.oldState, {})
	end)

	it("should be invoked when updated via setState", function()
		local MyComponent = Component:extend("MyComponent")

		local didUpdateSpy = createSpy()
		MyComponent.didUpdate = didUpdateSpy.value

		local initialState = {
			a = 4,
		}

		local setState
		function MyComponent:init()
			setState = function(...)
				return self:setState(...)
			end

			self:setState(initialState)
		end

		function MyComponent:render()
		end

		local element = createElement(MyComponent)
		local hostParent = nil
		local key = "Test"

		noopReconciler.mountVirtualNode(element, hostParent, key)

		expect(didUpdateSpy.callCount).to.equal(0)

		setState({
			a = 5,
		})

		expect(didUpdateSpy.callCount).to.equal(1)

		local values = didUpdateSpy:captureValues("self", "oldProps", "oldState")

		expect(Type.of(values.self)).to.equal(Type.StatefulComponentInstance)
		assertDeepEqual(values.oldProps, {})
		assertDeepEqual(values.oldState, initialState)
	end)
end