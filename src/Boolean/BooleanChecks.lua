--!strict

local BooleanChecks = {}

function BooleanChecks.IsBoolean(value: any): boolean
	return typeof(value) == "boolean"
end

return BooleanChecks
