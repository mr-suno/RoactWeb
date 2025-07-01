return function()
	local Component = getgenv().require("Component")
	local ElementKind = getgenv().require("ElementKind")
	local GlobalConfig = getgenv().require("GlobalConfig")
	local Logging = getgenv().require("Logging")
	local Type = getgenv().require("Type")
	local Portal = getgenv().require("Portal")
	local Children = getgenv().require("PropMarkers/Children")

	local createElement = getgenv().require("createElement")

	it("should create new primitive elements", function()
		local element = createElement("Frame")

		expect(element).to.be.ok()
		expect(Type.of(element)).to.equal(Type.Element)
		expect(ElementKind.of(element)).to.equal(ElementKind.Host)
	end)

	it("should create new functional elements", function()
		local element = createElement(function() end)

		expect(element).to.be.ok()
		expect(Type.of(element)).to.equal(Type.Element)
		expect(ElementKind.of(element)).to.equal(ElementKind.Function)
	end)

	it("should create new stateful components", function()
		local Foo = Component:extend("Foo")

		local element = createElement(Foo)

		expect(element).to.be.ok()
		expect(Type.of(element)).to.equal(Type.Element)
		expect(ElementKind.of(element)).to.equal(ElementKind.Stateful)
	end)

	it("should create new portal elements", function()
		local element = createElement(Portal)

		expect(element).to.be.ok()
		expect(Type.of(element)).to.equal(Type.Element)
		expect(ElementKind.of(element)).to.equal(ElementKind.Portal)
	end)

	it("should accept props", function()
		local element = createElement("StringValue", {
			Value = "Foo",
		})

		expect(element).to.be.ok()
		expect(element.props.Value).to.equal("Foo")
	end)

	it("should accept props and children", function()
		local child = createElement("IntValue")

		local element = createElement("StringValue", {
			Value = "Foo",
		}, {
			Child = child,
		})

		expect(element).to.be.ok()
		expect(element.props.Value).to.equal("Foo")
		expect(element.props[Children]).to.be.ok()
		expect(element.props[Children].Child).to.equal(child)
	end)

	it("should accept children with without props", function()
		local child = createElement("IntValue")

		local element = createElement("StringValue", nil, {
			Child = child,
		})

		expect(element).to.be.ok()
		expect(element.props[Children]).to.be.ok()
		expect(element.props[Children].Child).to.equal(child)
	end)

	it("should warn once if children is specified in two different ways", function()
		local logInfo = Logging.capture(function()
			-- Using a loop here to ensure that multiple occurrences of the same
			-- warning only cause output once.
			for _ = 1, 2 do
				createElement("Frame", {
					[Children] = {},
				}, {})
			end
		end)

		expect(#logInfo.warnings).to.equal(1)
		expect(logInfo.warnings[1]:find("createElement")).to.be.ok()
		expect(logInfo.warnings[1]:find("Children")).to.be.ok()
	end)

	it("should have a `source` member if elementTracing is set", function()
		local config = {
			elementTracing = true,
		}

		GlobalConfig.scoped(config, function()
			local element = createElement("StringValue")

			expect(element.source).to.be.a("string")
		end)
	end)
end
