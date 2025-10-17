--!strict

local CoreChecks = {}

function CoreChecks.IsInTable(value: any, t: { [any]: any }): boolean
	for _, v in pairs(t) do
		if v == value then
			return true
		end
	end

	return false
end

function CoreChecks.IsKeyOf(value: any, t: { [any]: any }): boolean
	return if t[value] ~= nil then true else false
end

function CoreChecks.IsEqual(value: any, otherValue: any): boolean
	return value == otherValue
end

return CoreChecks
