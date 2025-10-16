--!strict

local NanChecks = require(script.NanChecks)
local CoreValidator = require(script.Parent.Core)
local Helpers = require(script.Parent.Helpers)
local ValidatorTypes = require(script.Parent.ValidatorTypes)

local NanValidator = {}
setmetatable(NanValidator, CoreValidator)
NanValidator.__index = NanValidator

function NanValidator.new(): ValidatorTypes.PublicNanValidator
	local self = setmetatable(CoreValidator.new() :: any, NanValidator)
	Helpers.AddCheck(self, NanChecks.IsNan)
	return self
end

function NanValidator.IsNan(
	self: ValidatorTypes.PrivateValidator
): ValidatorTypes.PublicNanValidator
	local new = setmetatable(self :: any, NanValidator)
	Helpers.AddCheck(new, NanChecks.IsNan)
	return new
end

return NanValidator
