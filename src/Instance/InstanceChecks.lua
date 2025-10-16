--!strict

local InstanceChecks = {}

function InstanceChecks.IsA(value: any, instanceClass: string): boolean
	return typeof(value) == "Instance" and value:IsA(instanceClass)
end

function InstanceChecks.IsClass(value: any, instanceClass: string): boolean
	return typeof(value) == "Instance" and value.ClassName == instanceClass
end

return InstanceChecks
