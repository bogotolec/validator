--!strict

local TypeChecks = {}

function TypeChecks.IsTypeOf(value: any, type: string): boolean
	return typeof(value) == type
end

return TypeChecks
