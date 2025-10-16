--!strict

local StringChecks = {}

function StringChecks.IsString(value: any): boolean
	return type(value) == "string"
end

return StringChecks
