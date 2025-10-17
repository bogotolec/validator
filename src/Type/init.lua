--!strict

local TypeChecks = require(script.TypeChecks)
local CoreValidator = require(script.Parent.Core)
local Helpers = require(script.Parent.Helpers)
local ValidatorTypes = require(script.Parent.ValidatorTypes)

local TypeValidator = {}
setmetatable(TypeValidator, CoreValidator)
TypeValidator.__index = TypeValidator

function TypeValidator.new(type: string): ValidatorTypes.PublicTypeValidator
	local self = setmetatable(CoreValidator.new() :: any, TypeValidator)
	Helpers.AddCheck(self, TypeChecks.IsTypeOf, type)
	return self
end

function TypeValidator.IsTypeOf(
	self: ValidatorTypes.PrivateValidator,
	type: string
): ValidatorTypes.PublicTypeValidator
	local new = setmetatable(self :: any, TypeValidator)
	Helpers.AddCheck(new, TypeChecks.IsTypeOf, type)
	return new
end

return TypeValidator
