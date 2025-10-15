--!strict

local Core = require(script.Parent.Core)
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

function Helpers.CreateIndex<T>(c: T): (ValidatorTypes.PrivateValidator, string) -> any
	assert(typeof(c) == "table", `Expected {c} to be a table.`)
	return function(self: ValidatorTypes.PrivateValidator, key: string): any
		if key == "Not" then
			table.insert(self._checksGroups[#self._checksGroups], false)
			return self
		end

		if key == "Or" then
			return Core.Or(self)
		end

		return c[key]
	end
end

return Helpers
