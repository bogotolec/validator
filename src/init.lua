--!strict

local ValidatorTypes = require(script.ValidatorTypes)

export type Check = ValidatorTypes.Check
export type Checker = ValidatorTypes.Checker
export type Validator = ValidatorTypes.PublicValidator
export type RootValidator = ValidatorTypes.PublicRootValidator
export type NumberValidator = ValidatorTypes.PublicNumberValidator
export type NilValidator = ValidatorTypes.PublicNilValidator
export type StringValidator = ValidatorTypes.PublicNilValidator
export type BooleanValidator = ValidatorTypes.PublicBooleanValidator
export type NanValidator = ValidatorTypes.PublicNanValidator
export type InstanceValidator = ValidatorTypes.PublicInstanceValidator
export type TableValidator = ValidatorTypes.PublicTableValidator
export type TypeValidator = ValidatorTypes.PublicTypeValidator
export type EnumValidator = ValidatorTypes.PublicEnumValidator

local BooleanValidator = require(script.Boolean)
local CoreValidator = require(script.Core)
local EnumValidator = require(script.Enum)
local InstanceValidator = require(script.Instance)
local NanValidator = require(script.Nan)
local RootValidator = require(script.Root)
local NilValidator = require(script.Nil)
local NumberValidator = require(script.Number)
local StringValidator = require(script.String)
local TableValidator = require(script.Table)
local TypeValidator = require(script.Type)

local Validator = {}

CoreValidator._Setup(RootValidator :: any)

Validator.IsNumber = NumberValidator.newIsNumber
Validator.IsInteger = NumberValidator.newIsInteger
Validator.IsNil = NilValidator.new
Validator.IsString = StringValidator.new
Validator.IsBoolean = BooleanValidator.new
Validator.IsNan = NanValidator.new
Validator.IsAnInstance = InstanceValidator.newIsAnInstance
Validator.IsAnInstanceStrict = InstanceValidator.newIsAnInstanceStrict
Validator.IsTable = TableValidator.newIsTable
Validator.IsTableStrict = TableValidator.newIsTableStrict
Validator.IsTypeOf = TypeValidator.new
Validator.IsEnumItem = EnumValidator.new

return Validator
