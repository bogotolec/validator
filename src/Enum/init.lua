--!strict

local EnumChecks = require(script.EnumChecks)
local CoreValidator = require(script.Parent.Core)
local Helpers = require(script.Parent.Helpers)
local ValidatorTypes = require(script.Parent.ValidatorTypes)

local EnumValidator = {}
setmetatable(EnumValidator, CoreValidator)
EnumValidator.__index = EnumValidator

function EnumValidator.new(enum: Enum?): ValidatorTypes.PublicEnumValidator
	local self = setmetatable(CoreValidator.new() :: any, EnumValidator)
	Helpers.AddCheck(self, EnumChecks.IsEnumItem, enum)
	return self
end

function EnumValidator.IsEnumItem(
	self: ValidatorTypes.PrivateValidator,
	enum: Enum?
): ValidatorTypes.PrivateEnumValidator
	local new = setmetatable(self :: any, EnumValidator)
	Helpers.AddCheck(new, EnumChecks.IsEnumItem, enum)
	return new
end

return EnumValidator
