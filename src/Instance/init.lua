--!strict

local InstanceChecks = require(script.InstanceChecks)
local CoreValidator = require(script.Parent.Core)
local Helpers = require(script.Parent.Helpers)
local ValidatorTypes = require(script.Parent.ValidatorTypes)

local InstanceValidator = {}
setmetatable(InstanceValidator, CoreValidator)
InstanceValidator.__index = InstanceValidator

function InstanceValidator.newIsAnInstance(
	instanceClass: string
): ValidatorTypes.PublicInstanceValidator
	local self = setmetatable(CoreValidator.new() :: any, InstanceValidator)
	Helpers.AddCheck(self, InstanceChecks.IsA, instanceClass)
	return self
end

function InstanceValidator.newIsAnInstanceStrict(
	instanceClass: string
): ValidatorTypes.PublicInstanceValidator
	local self = setmetatable(CoreValidator.new() :: any, InstanceValidator)
	Helpers.AddCheck(self, InstanceChecks.IsClass, instanceClass)
	return self
end

function InstanceValidator.IsAnInstance(
	self: ValidatorTypes.PrivateValidator,
	instanceClass: string
): ValidatorTypes.PrivateInstanceValidator
	local new = setmetatable(self :: any, InstanceValidator)
	Helpers.AddCheck(new, InstanceChecks.IsA, instanceClass)
	return new
end

function InstanceValidator.IsAnInstanceStrict(
	self: ValidatorTypes.PrivateValidator,
	instanceClass: string
): ValidatorTypes.PrivateInstanceValidator
	local new = setmetatable(self :: any, InstanceValidator)
	Helpers.AddCheck(new, InstanceChecks.IsClass, instanceClass)
	return new
end

function InstanceValidator.IsProperty(
	self: ValidatorTypes.PrivateInstanceValidator,
	property: string,
	checker: ValidatorTypes.Checker
): ValidatorTypes.PrivateInstanceValidator
	Helpers.AddCheck(self, InstanceChecks.IsProperty, property, checker)
	return self
end

function InstanceValidator.IsAttribute(
	self: ValidatorTypes.PrivateInstanceValidator,
	attribute: string,
	checker: ValidatorTypes.Checker
): ValidatorTypes.PrivateInstanceValidator
	Helpers.AddCheck(self, InstanceChecks.IsAttribute, attribute, checker)
	return self
end

function InstanceValidator.HasTag(
	self: ValidatorTypes.PrivateInstanceValidator,
	tag: string
): ValidatorTypes.PrivateInstanceValidator
	Helpers.AddCheck(self, InstanceChecks.HasTag, tag)
	return self
end

return InstanceValidator
