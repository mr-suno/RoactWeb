return function()
	local Type = getgenv().require("Type")

	local Change = getgenv().require("PropMarkers/Change")

	it("should yield change listener objects when indexed", function()
		expect(Type.of(Change.Text)).to.equal(Type.HostChangeEvent)
		expect(Type.of(Change.Selected)).to.equal(Type.HostChangeEvent)
	end)

	it("should yield the same object when indexed again", function()
		local a = Change.Text
		local b = Change.Text
		local c = Change.Selected

		expect(a).to.equal(b)
		expect(a).never.to.equal(c)
	end)
end
