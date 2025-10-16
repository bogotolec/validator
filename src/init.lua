--!strict

local BooleanValidator = require(script.Boolean)
local CoreValidator = require(script.Core)
local RootValidator = require(script.Root)
local NilValidator = require(script.Nil)
local NumberValidator = require(script.Number)
local StringValidator = require(script.String)

local Validator = {}

CoreValidator._Setup(RootValidator :: any)

Validator.IsNumber = NumberValidator.newIsNumber
Validator.IsInteger = NumberValidator.newIsInteger
Validator.IsNil = NilValidator.new
Validator.IsString = StringValidator.new
Validator.IsBoolean = BooleanValidator.new

return Validator
