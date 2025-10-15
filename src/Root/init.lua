--!strict

local NilValidator = require(script.Parent.Nil)
local NumberValidator = require(script.Parent.Number)

local RootValidator = {}
RootValidator.__index = RootValidator

RootValidator.IsNumber = NumberValidator.IsNumber
RootValidator.IsInteger = NumberValidator.IsInteger
RootValidator.IsNil = NilValidator.IsNil

return RootValidator
