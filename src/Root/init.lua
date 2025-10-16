--!strict

local BooleanValidator = require(script.Parent.Boolean)
local NanValidator = require(script.Parent.Nan)
local NilValidator = require(script.Parent.Nil)
local NumberValidator = require(script.Parent.Number)
local StringValidator = require(script.Parent.String)

local RootValidator = {}
RootValidator.__index = RootValidator

RootValidator.IsNumber = NumberValidator.IsNumber
RootValidator.IsInteger = NumberValidator.IsInteger
RootValidator.IsNil = NilValidator.IsNil
RootValidator.IsString = StringValidator.IsString
RootValidator.IsBoolean = BooleanValidator.IsBoolean
RootValidator.IsNan = NanValidator.IsNan

return RootValidator
