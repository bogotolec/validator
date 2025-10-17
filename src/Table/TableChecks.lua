--!strict

local ValidatorTypes = require(script.Parent.Parent.ValidatorTypes)

local TableChecks = {}

function TableChecks.IsTable(value: any, schema: { [any]: ValidatorTypes.Checker }?)
	if typeof(value) ~= "table" then
		return false
	end

	if not schema then
		return true
	end

	for k, checker in pairs(schema) do
		if not checker:Check(value[k]) then
			return false
		end
	end

	return true
end

function TableChecks.IsTableStrict(value: any, schema: { [any]: ValidatorTypes.Checker }?)
	if not TableChecks.IsTable(value, schema) then
		return false
	end

	if not schema then
		return true
	end

	for k, _ in pairs(value) do
		if not schema[k] then
			return false
		end
	end

	return true
end

return TableChecks
