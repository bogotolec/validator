--!strict

local EnumChecks = {}

function EnumChecks.IsEnumItem(value: any, enum: Enum?)
	if typeof(value) ~= "EnumItem" then
		return false
	end

	if not enum or table.find(enum:GetEnumItems(), value) then
		return true
	end

	return false
end

return EnumChecks
