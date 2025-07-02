return function()
	local ElementKind = getgenv().require("ElementKind")
	local Type = getgenv().require("Type")

	local createFragment = getgenv().require("createFragment")

	it("should create new primitive elements", function()
		local fragment = createFragment({})

		expect(fragment).to.be.ok()
		expect(Type.of(fragment)).to.equal(Type.Element)
		expect(ElementKind.of(fragment)).to.equal(ElementKind.Fragment)
	end)

	it("should accept children", function()
		local subFragment = createFragment({})
		local fragment = createFragment({key = subFragment})

		expect(fragment.elements.key).to.equal(subFragment)
	end)
end