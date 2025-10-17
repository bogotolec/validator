--!strict

local Validator = require(script.Parent)

return function()
	describe("00. Core", function()
		it("00. Creates, freezes and checks", function()
			local validator = Validator.IsNumber():Freeze()

			expect(validator:Check(0)).to.be.equal(true)
			expect(validator:Check(nil)).to.be.equal(false)
		end)

		it("01. Combines complex expressions", function()
			local validator =
				Validator.IsInteger():IsGreater(5):Not():IsGreater(14):Or():IsNil():Freeze()

			expect(validator:Check(0)).to.be.equal(false)
			expect(validator:Check(5)).to.be.equal(false)
			expect(validator:Check(10)).to.be.equal(true)
			expect(validator:Check(15)).to.be.equal(false)
			expect(validator:Check(nil)).to.be.equal(true)
			expect(validator:Check("10")).to.be.equal(false)
		end)

		it("02. Asserts", function()
			local validator =
				Validator.IsInteger():IsGreater(5):Not():IsGreater(14):Or():IsNil():Freeze()

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

		it("03. Methods: IsEqual", function()
			local validator = Validator.IsString():Not():IsEqual("aaa"):Freeze()

			expect(validator:Check(1)).to.be.equal(false)
			expect(validator:Check("1")).to.be.equal(true)
			expect(validator:Check("aaa")).to.be.equal(false)
			expect(validator:Check(nil)).to.be.equal(false)
		end)

		it("04. Methods: IsInTable", function()
			local values = {
				"aaa",
				"bbb",
				"ccc",
			}

			local validator = Validator.IsString():IsInTable(values):Freeze()

			expect(validator:Check(1)).to.be.equal(false)
			expect(validator:Check("1")).to.be.equal(false)
			expect(validator:Check("aaa")).to.be.equal(true)
			expect(validator:Check(nil)).to.be.equal(false)

			validator = Validator.IsString():Not():IsInTable(values):Freeze()

			expect(validator:Check(1)).to.be.equal(false)
			expect(validator:Check("1")).to.be.equal(true)
			expect(validator:Check("aaa")).to.be.equal(false)
			expect(validator:Check(nil)).to.be.equal(false)
		end)

		it("05. Methods: IsKeyOf", function()
			local values = {
				"aaa",
				"bbb",
				"ccc",
			}

			local validator = Validator.IsInteger():IsKeyOf(values):Freeze()

			expect(validator:Check(1)).to.be.equal(true)
			expect(validator:Check(0)).to.be.equal(false)
			expect(validator:Check(4)).to.be.equal(false)
			expect(validator:Check("1")).to.be.equal(false)
			expect(validator:Check("aaa")).to.be.equal(false)
			expect(validator:Check(nil)).to.be.equal(false)
		end)
	end)

	describe("01. Strings", function()
		it("00. Creates", function()
			local validator = Validator.IsString():Freeze()

			expect(validator:Check(0)).to.be.equal(false)
			expect(validator:Check("0")).to.be.equal(true)
			expect(validator:Check(nil)).to.be.equal(false)
			expect(validator:Check(string.pack("BBBB", 0xFF, 0xFE, 0x00, 0x80))).to.be.equal(true)
		end)

		it("01. Combines", function()
			local validator = Validator.IsNumber():Or():IsString():Freeze()

			expect(validator:Check(0)).to.be.equal(true)
			expect(validator:Check("0")).to.be.equal(true)
			expect(validator:Check(nil)).to.be.equal(false)
			expect(validator:Check(string.pack("BBBB", 0xFF, 0xFE, 0x00, 0x80))).to.be.equal(true)
		end)

		it("02. Methods: IsUTF8", function()
			local validator = Validator.IsString():IsUTF8():Freeze()

			expect(validator:Check(nil)).to.be.equal(false)
			expect(validator:Check(0)).to.be.equal(false)
			expect(validator:Check("abcde")).to.be.equal(true)
			expect(validator:Check(string.pack("BBBB", 0xFF, 0xFE, 0x00, 0x80))).to.be.equal(false)
		end)

		it("03. Methods: MinLen and MaxLen", function()
			local validator = Validator.IsString():MinLen(5):MaxLen(10):Freeze()

			expect(validator:Check(nil)).to.be.equal(false)
			expect(validator:Check(0)).to.be.equal(false)
			expect(validator:Check("abcd")).to.be.equal(false)
			expect(validator:Check("abcde")).to.be.equal(true)
			expect(validator:Check("abcdeabcde")).to.be.equal(true)
			expect(validator:Check("abcdeabcdef")).to.be.equal(false)
			expect(validator:Check("абвгдеёжзи")).to.be.equal(false)
		end)

		it("04. Methods: MinUTF8Len and MaxUTF8Len", function()
			local validator = Validator.IsString():MinUTF8Len(5):MaxUTF8Len(10):Freeze()

			expect(validator:Check(nil)).to.be.equal(false)
			expect(validator:Check(0)).to.be.equal(false)
			expect(validator:Check("abcd")).to.be.equal(false)
			expect(validator:Check("abcde")).to.be.equal(true)
			expect(validator:Check("abcdeabcde")).to.be.equal(true)
			expect(validator:Check("abcdeabcdef")).to.be.equal(false)
			expect(validator:Check("абвгдеёжзи")).to.be.equal(true)
		end)
	end)

	describe("02. Booleans", function()
		it("00. Creates", function()
			local validator = Validator.IsBoolean():Freeze()

			expect(validator:Check(true)).to.be.equal(true)
			expect(validator:Check(false)).to.be.equal(true)
			expect(validator:Check(0)).to.be.equal(false)
			expect(validator:Check(nil)).to.be.equal(false)
		end)

		it("01. Combines", function()
			local validator = Validator.IsNumber():Or():IsBoolean():Freeze()

			expect(validator:Check(true)).to.be.equal(true)
			expect(validator:Check(false)).to.be.equal(true)
			expect(validator:Check(0)).to.be.equal(true)
			expect(validator:Check(nil)).to.be.equal(false)
		end)
	end)

	describe("03. Numbers and NaNs", function()
		local nan = 0 / 0
		it("00. Creates and combines IsNumber", function()
			local validator = Validator.IsNumber():Freeze()

			expect(validator:Check(nan)).to.be.equal(false)
			expect(validator:Check(0)).to.be.equal(true)
			expect(validator:Check(0.5)).to.be.equal(true)
			expect(validator:Check("0")).to.be.equal(false)

			validator = Validator.IsString():Or():IsNumber():Freeze()

			expect(validator:Check(nan)).to.be.equal(false)
			expect(validator:Check(0)).to.be.equal(true)
			expect(validator:Check(0.5)).to.be.equal(true)
			expect(validator:Check("0")).to.be.equal(true)
		end)

		it("01. Creates and combines IsInteger", function()
			local validator = Validator.IsInteger():Freeze()

			expect(validator:Check(nan)).to.be.equal(false)
			expect(validator:Check(0)).to.be.equal(true)
			expect(validator:Check(0.5)).to.be.equal(false)
			expect(validator:Check("0")).to.be.equal(false)

			validator = Validator.IsString():Or():IsInteger():Freeze()

			expect(validator:Check(nan)).to.be.equal(false)
			expect(validator:Check(0)).to.be.equal(true)
			expect(validator:Check(0.5)).to.be.equal(false)
			expect(validator:Check("0")).to.be.equal(true)
		end)

		it("02. Creates and combines IsNan", function()
			local validator = Validator.IsNan():Freeze()

			expect(validator:Check(nan)).to.be.equal(true)
			expect(validator:Check(0)).to.be.equal(false)
			expect(validator:Check(0.5)).to.be.equal(false)
			expect(validator:Check("0")).to.be.equal(false)

			validator = Validator.IsString():Or():IsNan():Freeze()

			expect(validator:Check(nan)).to.be.equal(true)
			expect(validator:Check(0)).to.be.equal(false)
			expect(validator:Check(0.5)).to.be.equal(false)
			expect(validator:Check("0")).to.be.equal(true)
		end)

		it("03. Methods: IsGreater", function()
			local validator = Validator.IsNumber():IsGreater(5):Freeze()

			expect(validator:Check(nan)).to.be.equal(false)
			expect(validator:Check(0)).to.be.equal(false)
			expect(validator:Check(0.5)).to.be.equal(false)
			expect(validator:Check(5)).to.be.equal(false)
			expect(validator:Check(5.00001)).to.be.equal(true)
			expect(validator:Check(6)).to.be.equal(true)
			expect(validator:Check(-math.huge)).to.be.equal(false)
			expect(validator:Check(math.huge)).to.be.equal(true)
			expect(validator:Check("0")).to.be.equal(false)
		end)
	end)

	describe("04. Instances", function()
		local part = Instance.new("Part")
		local model = Instance.new("Model")
		local decal = Instance.new("Decal")

		it("00. Creates and combines IsAnInstance", function()
			local validator = Validator.IsAnInstance("PVInstance"):Freeze()

			expect(validator:Check(nil)).to.be.equal(false)
			expect(validator:Check(0)).to.be.equal(false)
			expect(validator:Check(part)).to.be.equal(true)
			expect(validator:Check(model)).to.be.equal(true)
			expect(validator:Check(decal)).to.be.equal(false)
		end)

		it("01. Creates and combines IsAnInstanceStrict", function()
			local validator = Validator.IsAnInstanceStrict("PVInstance"):Freeze()

			expect(validator:Check(nil)).to.be.equal(false)
			expect(validator:Check(0)).to.be.equal(false)
			expect(validator:Check(part)).to.be.equal(false)
			expect(validator:Check(model)).to.be.equal(false)
			expect(validator:Check(decal)).to.be.equal(false)

			validator = Validator.IsAnInstanceStrict("Part"):Freeze()

			expect(validator:Check(nil)).to.be.equal(false)
			expect(validator:Check(0)).to.be.equal(false)
			expect(validator:Check(part)).to.be.equal(true)
			expect(validator:Check(model)).to.be.equal(false)
			expect(validator:Check(decal)).to.be.equal(false)
		end)
	end)

	describe("05. Tables", function()
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

		it("00. Creates and combines", function()
			local validator = Validator.IsTable():Freeze()

			expect(validator:Check(nil)).to.be.equal(false)
			expect(validator:Check({})).to.be.equal(true)
			expect(validator:Check(table1)).to.be.equal(true)
			expect(validator:Check(table2)).to.be.equal(true)
			expect(validator:Check(table3)).to.be.equal(true)
			expect(validator:Check(0)).to.be.equal(false)

			validator = Validator.IsNumber():Or():IsTable():Freeze()

			expect(validator:Check(nil)).to.be.equal(false)
			expect(validator:Check({})).to.be.equal(true)
			expect(validator:Check(table1)).to.be.equal(true)
			expect(validator:Check(table2)).to.be.equal(true)
			expect(validator:Check(table3)).to.be.equal(true)
			expect(validator:Check(0)).to.be.equal(true)
		end)

		it("01. Creates and combines with schema", function()
			local validator = Validator.IsTable({
				a = Validator.IsInteger():IsGreater(15),
			}):Freeze()

			expect(validator:Check(nil)).to.be.equal(false)
			expect(validator:Check({})).to.be.equal(false)
			expect(validator:Check(table1)).to.be.equal(false)
			expect(validator:Check(table2)).to.be.equal(true)
			expect(validator:Check(table3)).to.be.equal(false)
			expect(validator:Check(0)).to.be.equal(false)

			validator = Validator.IsNumber()
				:Or()
				:IsTable({
					a = Validator.IsInteger():IsGreater(15),
				})
				:Freeze()

			expect(validator:Check(nil)).to.be.equal(false)
			expect(validator:Check({})).to.be.equal(false)
			expect(validator:Check(table1)).to.be.equal(false)
			expect(validator:Check(table2)).to.be.equal(true)
			expect(validator:Check(table3)).to.be.equal(false)
			expect(validator:Check(0)).to.be.equal(true)
		end)

		it("02. Creates and combines with schema strict", function()
			local validator = Validator.IsTableStrict({
				a = Validator.IsInteger(),
			}):Freeze()

			expect(validator:Check(nil)).to.be.equal(false)
			expect(validator:Check({})).to.be.equal(false)
			expect(validator:Check(table1)).to.be.equal(true)
			expect(validator:Check(table2)).to.be.equal(true)
			expect(validator:Check(table3)).to.be.equal(false)
			expect(validator:Check(0)).to.be.equal(false)

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
	end)

	describe("06. Types", function()
		it("00. Creates and combines", function()
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
	end)

	describe("07. Enums", function()
		it("00. Creates and combines", function()
			local validator = Validator.IsEnumItem():Freeze()

			expect(validator:Check(1)).to.be.equal(false)
			expect(validator:Check("1")).to.be.equal(false)
			expect(validator:Check(Enum.KeyCode.A)).to.be.equal(true)
			expect(validator:Check(Enum.PartType.Ball)).to.be.equal(true)

			validator = Validator.IsNumber():Or():IsEnumItem():Freeze()

			expect(validator:Check(1)).to.be.equal(true)
			expect(validator:Check("1")).to.be.equal(false)
			expect(validator:Check(Enum.KeyCode.A)).to.be.equal(true)
			expect(validator:Check(Enum.PartType.Ball)).to.be.equal(true)
		end)

		it("01. Creates and combines with given Enum", function()
			local validator = Validator.IsEnumItem(Enum.KeyCode):Freeze()

			expect(validator:Check(1)).to.be.equal(false)
			expect(validator:Check("1")).to.be.equal(false)
			expect(validator:Check(Enum.KeyCode.A)).to.be.equal(true)
			expect(validator:Check(Enum.PartType.Ball)).to.be.equal(false)

			validator = Validator.IsNumber():Or():IsEnumItem(Enum.KeyCode):Freeze()

			expect(validator:Check(1)).to.be.equal(true)
			expect(validator:Check("1")).to.be.equal(false)
			expect(validator:Check(Enum.KeyCode.A)).to.be.equal(true)
			expect(validator:Check(Enum.PartType.Ball)).to.be.equal(false)
		end)
	end)
end
