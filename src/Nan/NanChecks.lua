--!strict

local NanChecks = {}

function NanChecks.IsNan(value: any): boolean
	return typeof(value) == "number" and value ~= value -- NaN check
end

return NanChecks
