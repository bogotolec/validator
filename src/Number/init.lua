--!strict

local NumberChecks = require(script.NumberChecks)
local CoreValidator = require(script.Parent.Core)
local Helpers = require(script.Parent.Helpers)
local ValidatorTypes = require(script.Parent.ValidatorTypes)

export type PrivateValidator = ValidatorTypes.PrivateValidator
export type PrivateNumberValidator = ValidatorTypes.PrivateNumberValidator

local NumberValidator = {}
setmetatable(NumberValidator, CoreValidator)
NumberValidator.__index = Helpers.CreateIndex(NumberValidator)

function NumberValidator.newIsNumber(): ValidatorTypes.PublicNumberValidator
	local self = setmetatable(CoreValidator.new() :: any, NumberValidator)
	Helpers.AddCheck(self, NumberChecks.IsNumber)
	return self
end

function NumberValidator.newIsInteger(): ValidatorTypes.PublicNumberValidator
	local self = setmetatable(CoreValidator.new() :: any, NumberValidator)
	Helpers.AddCheck(self, NumberChecks.IsInteger)
	return self
end

function NumberValidator.IsNumber(self: PrivateValidator): PrivateNumberValidator
	local new = setmetatable(self :: any, NumberValidator)
	Helpers.AddCheck(new, NumberChecks.IsNumber)
	return new
end

function NumberValidator.IsInteger(
	self: ValidatorTypes.PrivateValidator?
): ValidatorTypes.PrivateNumberValidator
	local new = setmetatable(self :: any, NumberValidator)
	Helpers.AddCheck(new, NumberChecks.IsInteger)
	return new
end

function NumberValidator.IsGreater(
	self: ValidatorTypes.PrivateNumberValidator,
	than: number
): ValidatorTypes.PrivateNumberValidator
	Helpers.AddCheck(self, NumberChecks.IsGreater, than)
	return self
end

return NumberValidator
