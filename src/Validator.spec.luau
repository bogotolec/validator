--!strict

local Validator = require(script.Parent)

return function()
	describe("Validator", function()
		it("Should work", function()
			local validator =
				Validator.IsInteger():IsGreater(5):Not():IsGreater(14):Or():IsNil():Freeze()

			expect(validator:Check(0)).to.be.equal(false)
			expect(validator:Check(5)).to.be.equal(false)
			expect(validator:Check(10)).to.be.equal(true)
			expect(validator:Check(15)).to.be.equal(false)
			expect(validator:Check(nil)).to.be.equal(true)
			expect(validator:Check("10")).to.be.equal(false)
		end)
	end)
end
