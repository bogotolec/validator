--!strict

local BooleanValidator = require(script.Parent.Boolean)
local InstanceValidator = require(script.Parent.Instance)
local NanValidator = require(script.Parent.Nan)
local NilValidator = require(script.Parent.Nil)
local NumberValidator = require(script.Parent.Number)
local StringValidator = require(script.Parent.String)
local TableValidator = require(script.Parent.Table)
local TypeValidator = require(script.Parent.Type)

local RootValidator = {}
RootValidator.__index = RootValidator

RootValidator.IsNumber = NumberValidator.IsNumber
RootValidator.IsInteger = NumberValidator.IsInteger
RootValidator.IsNil = NilValidator.IsNil
RootValidator.IsString = StringValidator.IsString
RootValidator.IsBoolean = BooleanValidator.IsBoolean
RootValidator.IsNan = NanValidator.IsNan
RootValidator.IsAnInstance = InstanceValidator.IsAnInstance
RootValidator.IsAnInstanceStrict = InstanceValidator.IsAnInstanceStrict
RootValidator.IsTable = TableValidator.IsTable
RootValidator.IsTableStrict = TableValidator.IsTableStrict
RootValidator.IsTypeOf = TypeValidator.IsTypeOf

return RootValidator
