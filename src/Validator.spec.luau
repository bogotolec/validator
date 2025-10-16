--!strict

local Validator = require(script.Parent)

return function()
	describe("Validator", function()
		it("00. Check if it works", function()
			local validator =
				Validator.IsInteger():IsGreater(5):Not():IsGreater(14):Or():IsNil():Freeze()

			expect(validator:Check(0)).to.be.equal(false)
			expect(validator:Check(5)).to.be.equal(false)
			expect(validator:Check(10)).to.be.equal(true)
			expect(validator:Check(15)).to.be.equal(false)
			expect(validator:Check(nil)).to.be.equal(true)
			expect(validator:Check("10")).to.be.equal(false)

			local success, value = pcall(function()
				return validator:Assert(0, "Error")
			end)

			expect(success).to.be.equal(false)
			expect(value).never.to.be.equal(0)

			success, value = pcall(function()
				return validator:Assert(10, "Error")
			end)

			expect(success).to.be.equal(true)
			expect(value).to.be.equal(10)
		end)

		it("01. Test strings", function()
			local validator = Validator.IsString():Freeze()

			expect(validator:Check(0)).to.be.equal(false)
			expect(validator:Check("0")).to.be.equal(true)
			expect(validator:Check(nil)).to.be.equal(false)

			validator = Validator.IsNumber():Or():IsString():Freeze()

			expect(validator:Check(0)).to.be.equal(true)
			expect(validator:Check("0")).to.be.equal(true)
			expect(validator:Check(nil)).to.be.equal(false)
		end)
	end)
end
