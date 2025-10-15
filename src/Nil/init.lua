--!strict

local NilChecks = require(script.NilChecks)
local CoreValidator = require(script.Parent.Core)
local Helpers = require(script.Parent.Helpers)
local ValidatorTypes = require(script.Parent.ValidatorTypes)

local NilValidator = {}
setmetatable(NilValidator, CoreValidator)
NilValidator.__index = NilValidator

function NilValidator.new(): ValidatorTypes.PublicNilValidator
	local self = setmetatable(CoreValidator.new() :: any, NilValidator)
	Helpers.AddCheck(self, NilChecks.IsNil)
	return self
end

function NilValidator.IsNil(
	self: ValidatorTypes.PrivateValidator
): ValidatorTypes.PublicNilValidator
	local new = setmetatable(self :: any, NilValidator)
	Helpers.AddCheck(new, NilChecks.IsNil)
	return new
end

return NilValidator
