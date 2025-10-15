--!strict

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

		for _, check in pairs(group) do
			if not check._func(value, table.unpack(check._params)) then
				passed = false
				break
			end
		end

		if passed then
			return true
		end
	end

	return false
end

function CoreValidator.Or(
	self: ValidatorTypes.PrivateValidator
): ValidatorTypes.PrivateRootValidator
	table.insert(self._checksGroups, {})
	local new = setmetatable(self :: any, rootValidatorClass)
	return new
end

function CoreValidator._Setup(rootValidator: ValidatorTypes.PrivateRootValidator)
	rootValidatorClass = rootValidator
end

return CoreValidator
