--!strict

local TableChecks = require(script.TableChecks)
local CoreValidator = require(script.Parent.Core)
local Helpers = require(script.Parent.Helpers)
local ValidatorTypes = require(script.Parent.ValidatorTypes)

local TableValidator = {}
setmetatable(TableValidator, CoreValidator)
TableValidator.__index = TableValidator

function TableValidator.newIsTable(
	schema: { [any]: ValidatorTypes.Checker }?
): ValidatorTypes.PublicTableValidator
	local self = setmetatable(CoreValidator.new() :: any, TableValidator)
	Helpers.AddCheck(self, TableChecks.IsTable, schema)
	return self
end

function TableValidator.newIsTableStrict(
	schema: { [any]: ValidatorTypes.Checker }?
): ValidatorTypes.PublicTableValidator
	local self = setmetatable(CoreValidator.new() :: any, TableValidator)
	Helpers.AddCheck(self, TableChecks.IsTableStrict, schema)
	return self
end

function TableValidator.IsTable(
	self: ValidatorTypes.PrivateValidator,
	schema: { [any]: ValidatorTypes.Checker }?
): ValidatorTypes.PrivateTableValidator
	local new = setmetatable(self :: any, TableValidator)
	Helpers.AddCheck(new, TableChecks.IsTable, schema)
	return new
end

function TableValidator.IsTableStrict(
	self: ValidatorTypes.PrivateValidator,
	schema: { [any]: ValidatorTypes.Checker }?
): ValidatorTypes.PrivateTableValidator
	local new = setmetatable(self :: any, TableValidator)
	Helpers.AddCheck(new, TableChecks.IsTableStrict, schema)
	return new
end

return TableValidator
