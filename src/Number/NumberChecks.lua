--!strict

local NumberChecks = {}

function NumberChecks.IsNumber(value: any): boolean
	return typeof(value) == "number" and value == value -- NaN check
end

function NumberChecks.IsInteger(value: any): boolean
	return NumberChecks.IsNumber(value) and (value % 1 == 0)
end

function NumberChecks.IsGreater(value: number, param: number): boolean
	return value > param
end

return NumberChecks
