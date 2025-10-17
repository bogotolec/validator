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

function StringValidator.IsUTF8(
	self: ValidatorTypes.PrivateStringValidator
): ValidatorTypes.PrivateStringValidator
	Helpers.AddCheck(self, StringChecks.IsUTF8)
	return self
end

function StringValidator.MaxLen(
	self: ValidatorTypes.PrivateStringValidator,
	len: number
): ValidatorTypes.PrivateStringValidator
	Helpers.AddCheck(self, StringChecks.MaxLen, len)
	return self
end

function StringValidator.MinLen(
	self: ValidatorTypes.PrivateStringValidator,
	len: number
): ValidatorTypes.PrivateStringValidator
	Helpers.AddCheck(self, StringChecks.MinLen, len)
	return self
end

function StringValidator.MaxUTF8Len(
	self: ValidatorTypes.PrivateStringValidator,
	len: number
): ValidatorTypes.PrivateStringValidator
	Helpers.AddCheck(self, StringChecks.MaxUTF8Len, len)
	return self
end

function StringValidator.MinUTF8Len(
	self: ValidatorTypes.PrivateStringValidator,
	len: number
): ValidatorTypes.PrivateStringValidator
	Helpers.AddCheck(self, StringChecks.MinUTF8Len, len)
	return self
end

return StringValidator
