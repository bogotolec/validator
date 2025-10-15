--!strict

local CoreValidator = require(script.Core)
local RootValidator = require(script.Root)
local NilValidator = require(script.Nil)
local NumberValidator = require(script.Number)

local Validator = {}

CoreValidator._Setup(RootValidator :: any)

Validator.IsNumber = NumberValidator.newIsNumber
Validator.IsInteger = NumberValidator.newIsInteger
Validator.IsNil = NilValidator.new

return Validator
