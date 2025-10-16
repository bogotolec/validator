--!strict

local ValidatorTypes = require(script.Parent.ValidatorTypes)

local Helpers = {}

function Helpers.AddCheck(
	validator: ValidatorTypes.PrivateValidator,
	func: (any, ...any) -> boolean,
	...
)
	table.insert(validator._checksGroups[#validator._checksGroups], {
		_func = func,
		_params = table.pack(...),
	})
end

return Helpers
