--!strict

local CoreChecks = require(script.CoreChecks)
local Helpers = require(script.Parent.Helpers)
local ValidatorTypes = require(script.Parent.ValidatorTypes)

local CoreValidator = {}
CoreValidator.__index = CoreValidator

local rootValidatorClass: ValidatorTypes.PrivateRootValidator

function CoreValidator.new(): ValidatorTypes.PrivateValidator
	local self = {
		_checksGroups = { {} },
	}

	local validator = setmetatable(self :: any, CoreValidator)

	return validator
end

function CoreValidator.Check(self: ValidatorTypes.PrivateValidator, value: any): boolean
	for _, group in pairs(self._checksGroups) do
		local passed = if next(group) then true else false

		local isNegated = false

		for _, check in pairs(group) do
			if not check then
				isNegated = not isNegated
				continue
			end

			assert(type(check) == "table", "Check is not table, which is not possible.")

			local res = check._func(value, table.unpack(check._params))

			if (isNegated and res) or (not isNegated and not res) then
				passed = false
				break
			end
			isNegated = false
		end

		if passed then
			return true
		end
	end

	return false
end

function CoreValidator.Assert(
	self: ValidatorTypes.PrivateValidator,
	value: any,
	message: string?
): any
	if not self:Check(value) then
		error(message or `Value {value} does not satisfy the validator checks.`)
	end

	return value
end

function CoreValidator.Freeze(self: ValidatorTypes.PrivateValidator): ValidatorTypes.Checker
	-- TODO add actual freeze (prohibit calling other methods)
	return self
end

function CoreValidator.Or(
	self: ValidatorTypes.PrivateValidator
): ValidatorTypes.PrivateRootValidator
	table.insert(self._checksGroups, {})
	local new = setmetatable(self :: any, rootValidatorClass)
	return new
end

function CoreValidator.Not(self: ValidatorTypes.PrivateValidator): ValidatorTypes.PrivateValidator
	table.insert(self._checksGroups[#self._checksGroups], false)
	return self
end

function CoreValidator.IsInTable(
	self: ValidatorTypes.PrivateValidator,
	t: { [any]: any }
): ValidatorTypes.PrivateValidator
	Helpers.AddCheck(self, CoreChecks.IsInTable, t)
	return self
end

function CoreValidator.IsKeyOf(
	self: ValidatorTypes.PrivateValidator,
	t: { [any]: any }
): ValidatorTypes.PrivateValidator
	Helpers.AddCheck(self, CoreChecks.IsKeyOf, t)
	return self
end

function CoreValidator.IsEqual(
	self: ValidatorTypes.PrivateValidator,
	otherValue: any
): ValidatorTypes.PrivateValidator
	Helpers.AddCheck(self, CoreChecks.IsEqual, otherValue)
	return self
end

function CoreValidator._Setup(rootValidator: ValidatorTypes.PrivateRootValidator)
	rootValidatorClass = rootValidator
end

return CoreValidator
