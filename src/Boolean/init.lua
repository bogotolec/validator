--!strict

local BooleanChecks = require(script.BooleanChecks)
local CoreValidator = require(script.Parent.Core)
local Helpers = require(script.Parent.Helpers)
local ValidatorTypes = require(script.Parent.ValidatorTypes)

local BooleanValidator = {}
setmetatable(BooleanValidator, CoreValidator)
BooleanValidator.__index = BooleanValidator

function BooleanValidator.new(): ValidatorTypes.PublicBooleanValidator
	local self = setmetatable(CoreValidator.new() :: any, BooleanValidator)
	Helpers.AddCheck(self, BooleanChecks.IsBoolean)
	return self
end

function BooleanValidator.IsBoolean(
	self: ValidatorTypes.PrivateValidator
): ValidatorTypes.PublicBooleanValidator
	local new = setmetatable(self :: any, BooleanValidator)
	Helpers.AddCheck(new, BooleanChecks.IsBoolean)
	return new
end

return BooleanValidator
