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

		it("02. Test booleans", function()
			local validator = Validator.IsBoolean():Freeze()

			expect(validator:Check(true)).to.be.equal(true)
			expect(validator:Check(false)).to.be.equal(true)
			expect(validator:Check(0)).to.be.equal(false)
			expect(validator:Check(nil)).to.be.equal(false)

			validator = Validator.IsNumber():Or():IsBoolean():Freeze()

			expect(validator:Check(true)).to.be.equal(true)
			expect(validator:Check(false)).to.be.equal(true)
			expect(validator:Check(0)).to.be.equal(true)
			expect(validator:Check(nil)).to.be.equal(false)
		end)

		it("03. Test numbers and nans", function()
			local nan = 0 / 0
			local validator = Validator.IsNan():Freeze()

			expect(validator:Check(nan)).to.be.equal(true)
			expect(validator:Check(0)).to.be.equal(false)
			expect(validator:Check(0.5)).to.be.equal(false)
			expect(validator:Check("0")).to.be.equal(false)

			validator = Validator.IsNumber():Freeze()

			expect(validator:Check(nan)).to.be.equal(false)
			expect(validator:Check(0)).to.be.equal(true)
			expect(validator:Check(0.5)).to.be.equal(true)
			expect(validator:Check("0")).to.be.equal(false)

			validator = Validator.IsInteger():Freeze()

			expect(validator:Check(nan)).to.be.equal(false)
			expect(validator:Check(0)).to.be.equal(true)
			expect(validator:Check(0.5)).to.be.equal(false)
			expect(validator:Check("0")).to.be.equal(false)

			validator = Validator.IsNumber():Or():IsNan():Freeze()

			expect(validator:Check(nan)).to.be.equal(true)
			expect(validator:Check(0)).to.be.equal(true)
			expect(validator:Check(0.5)).to.be.equal(true)
			expect(validator:Check("0")).to.be.equal(false)
		end)

		it("04. Test instances", function()
			local part = Instance.new("Part")
			part.Parent = workspace

			local validator = Validator.IsAnInstance("BasePart"):Freeze()
			local validatorStrict = Validator.IsAnInstanceStrict("BasePart"):Freeze()

			expect(validator:Check(part)).to.be.equal(true)
			expect(validatorStrict:Check(part)).to.be.equal(false)

			part:Destroy()
		end)

		it("05. Test tables", function()
			local table1 = {
				a = 10,
			}
			local table2 = {
				a = 20,
			}
			local table3 = {
				a = 10,
				b = 20,
			}

			local validator = Validator.IsTable():Freeze()

			expect(validator:Check(nil)).to.be.equal(false)
			expect(validator:Check({})).to.be.equal(true)
			expect(validator:Check(table1)).to.be.equal(true)
			expect(validator:Check(table2)).to.be.equal(true)
			expect(validator:Check(table3)).to.be.equal(true)
			expect(validator:Check(0)).to.be.equal(false)

			validator = Validator.IsTable({
				a = Validator.IsInteger():IsGreater(15),
			}):Freeze()

			expect(validator:Check(nil)).to.be.equal(false)
			expect(validator:Check({})).to.be.equal(false)
			expect(validator:Check(table1)).to.be.equal(false)
			expect(validator:Check(table2)).to.be.equal(true)
			expect(validator:Check(table3)).to.be.equal(false)
			expect(validator:Check(0)).to.be.equal(false)

			validator = Validator.IsTable({
				a = Validator.IsInteger(),
			}):Freeze()

			expect(validator:Check(nil)).to.be.equal(false)
			expect(validator:Check({})).to.be.equal(false)
			expect(validator:Check(table1)).to.be.equal(true)
			expect(validator:Check(table2)).to.be.equal(true)
			expect(validator:Check(table3)).to.be.equal(true)
			expect(validator:Check(0)).to.be.equal(false)

			validator = Validator.IsTableStrict({
				a = Validator.IsInteger(),
			}):Freeze()

			expect(validator:Check(nil)).to.be.equal(false)
			expect(validator:Check({})).to.be.equal(false)
			expect(validator:Check(table1)).to.be.equal(true)
			expect(validator:Check(table2)).to.be.equal(true)
			expect(validator:Check(table3)).to.be.equal(false)
			expect(validator:Check(0)).to.be.equal(false)

			validator = Validator.IsNumber():Or():IsTable():Freeze()

			expect(validator:Check(nil)).to.be.equal(false)
			expect(validator:Check({})).to.be.equal(true)
			expect(validator:Check(table1)).to.be.equal(true)
			expect(validator:Check(table2)).to.be.equal(true)
			expect(validator:Check(table3)).to.be.equal(true)
			expect(validator:Check(0)).to.be.equal(true)

			validator = Validator.IsNumber()
				:Or()
				:IsTableStrict({
					a = Validator.IsInteger(),
				})
				:Freeze()

			expect(validator:Check(nil)).to.be.equal(false)
			expect(validator:Check({})).to.be.equal(false)
			expect(validator:Check(table1)).to.be.equal(true)
			expect(validator:Check(table2)).to.be.equal(true)
			expect(validator:Check(table3)).to.be.equal(false)
			expect(validator:Check(0)).to.be.equal(true)
		end)

		it("06. Test types", function()
			local validator = Validator.IsTypeOf("Vector3"):Freeze()

			expect(validator:Check(nil)).to.be.equal(false)
			expect(validator:Check(Vector3.new(10, 20, 30))).to.be.equal(true)
			expect(validator:Check(Vector3.zero)).to.be.equal(true)
			expect(validator:Check(UDim2.new())).to.be.equal(false)
			expect(validator:Check(0)).to.be.equal(false)

			validator = Validator.IsNumber():Or():IsTypeOf("Vector3"):Freeze()

			expect(validator:Check(nil)).to.be.equal(false)
			expect(validator:Check(Vector3.new(10, 20, 30))).to.be.equal(true)
			expect(validator:Check(Vector3.zero)).to.be.equal(true)
			expect(validator:Check(UDim2.new())).to.be.equal(false)
			expect(validator:Check(0)).to.be.equal(true)
		end)

		it("07. Test enums", function()
			local validator = Validator.IsEnumItem():Freeze()

			expect(validator:Check(1)).to.be.equal(false)
			expect(validator:Check("1")).to.be.equal(false)
			expect(validator:Check(Enum.KeyCode.A)).to.be.equal(true)
			expect(validator:Check(Enum.PartType.Ball)).to.be.equal(true)

			validator = Validator.IsEnumItem(Enum.KeyCode):Freeze()

			expect(validator:Check(1)).to.be.equal(false)
			expect(validator:Check("1")).to.be.equal(false)
			expect(validator:Check(Enum.KeyCode.A)).to.be.equal(true)
			expect(validator:Check(Enum.PartType.Ball)).to.be.equal(false)

			validator = Validator.IsNumber():Or():IsEnumItem():Freeze()

			expect(validator:Check(1)).to.be.equal(true)
			expect(validator:Check("1")).to.be.equal(false)
			expect(validator:Check(Enum.KeyCode.A)).to.be.equal(true)
			expect(validator:Check(Enum.PartType.Ball)).to.be.equal(true)

			validator = Validator.IsNumber():Or():IsEnumItem(Enum.KeyCode):Freeze()

			expect(validator:Check(1)).to.be.equal(true)
			expect(validator:Check("1")).to.be.equal(false)
			expect(validator:Check(Enum.KeyCode.A)).to.be.equal(true)
			expect(validator:Check(Enum.PartType.Ball)).to.be.equal(false)
		end)
	end)
end
