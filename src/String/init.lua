--!strict

local StringChecks = require(script.StringChecks)
local CoreValidator = require(script.Parent.Core)
local Helpers = require(script.Parent.Helpers)
local ValidatorTypes = require(script.Parent.ValidatorTypes)

export type PrivateValidator = ValidatorTypes.PrivateValidator
export type PrivateNumberValidator = ValidatorTypes.PrivateNumberValidator

local StringValidator = {}
setmetatable(StringValidator, CoreValidator)
StringValidator.__index = StringValidator

function StringValidator.new(): ValidatorTypes.PublicNumberValidator
	local self = setmetatable(CoreValidator.new() :: any, StringValidator)
	Helpers.AddCheck(self, StringChecks.IsString)
	return self
end

function StringValidator.IsString(self: PrivateValidator): PrivateNumberValidator
	local new = setmetatable(self :: any, StringValidator)
	Helpers.AddCheck(new, StringChecks.IsString)
	return new
end

return StringValidator
