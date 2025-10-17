--!strict

local ValidatorTypes = require(script.Parent.Parent.ValidatorTypes)

local InstanceChecks = {}

function InstanceChecks.IsA(value: any, instanceClass: string): boolean
	return typeof(value) == "Instance" and value:IsA(instanceClass)
end

function InstanceChecks.IsClass(value: any, instanceClass: string): boolean
	return typeof(value) == "Instance" and value.ClassName == instanceClass
end

function InstanceChecks.IsProperty(
	value: Instance,
	property: string,
	checker: ValidatorTypes.Checker
): boolean
	local success, result = pcall(function(): boolean
		return checker:Check((value :: any)[property])
	end)
	return if success and result then true else false
end

function InstanceChecks.IsAttribute(
	value: Instance,
	attribute: string,
	checker: ValidatorTypes.Checker
): boolean
	return checker:Check(value:GetAttribute(attribute))
end

function InstanceChecks.HasTag(value: Instance, tag: string): boolean
	return value:HasTag(tag)
end

return InstanceChecks
