--!strict

local StringChecks = require(script.StringChecks)
local CoreValidator = require(script.Parent.Core)
local Helpers = require(script.Parent.Helpers)
local ValidatorTypes = require(script.Parent.ValidatorTypes)

local StringValidator = {}
setmetatable(StringValidator, CoreValidator)
StringValidator.__index = StringValidator

function StringValidator.new(): ValidatorTypes.PublicStringValidator
	local self = setmetatable(CoreValidator.new() :: any, StringValidator)
	Helpers.AddCheck(self, StringChecks.IsString)
	return self
end

function StringValidator.IsString(
	self: ValidatorTypes.PrivateValidator
): ValidatorTypes.PrivateStringValidator
	local new = setmetatable(self :: any, StringValidator)
	Helpers.AddCheck(new, StringChecks.IsString)
	return new
end

return StringValidator
