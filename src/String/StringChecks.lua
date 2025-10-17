--!strict

local StringChecks = {}

function StringChecks.IsString(value: any): boolean
	return type(value) == "string"
end

function StringChecks.IsUTF8(value: string): boolean
	return if utf8.len(value) then true else false
end

function StringChecks.MaxLen(value: any, len: number): boolean
	return string.len(value) <= len
end

function StringChecks.MinLen(value: any, len: number): boolean
	return string.len(value) >= len
end

function StringChecks.MaxUTF8Len(value: any, len: number): boolean
	local result = utf8.len(value)
	return if result then result <= len else false
end

function StringChecks.MinUTF8Len(value: any, len: number): boolean
	local result = utf8.len(value)
	return if result then result >= len else false
end

return StringChecks
