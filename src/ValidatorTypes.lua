--!strict

--#region Core

export type Check = false | {
	_func: (any, ...any) -> boolean,
	_params: typeof(table.pack(...)),
}

export type Checker = typeof(setmetatable({}, {})) & {
	Check: (self: Checker, data: any) -> boolean,
	Assert: (self: Checker, data: any, message: string?) -> any,
}

export type PublicValidator = Checker & {
	Or: (self: PublicValidator) -> RootMethods,
	Freeze: (self: PublicValidator) -> Checker,
}
export type PrivateValidator = PublicValidator & {
	_checksGroups: { { Check } },
}

--#endregion

--#region Root

export type RootMethods = {
	IsNumber: (self: RootMethods) -> PublicNumberValidator,
	IsInteger: (self: RootMethods) -> PublicNumberValidator,
	IsNil: (self: RootMethods) -> PublicNilValidator,
	IsString: (self: RootMethods) -> PublicStringValidator,
	IsBoolean: (self: RootMethods) -> PublicBooleanValidator,
	IsNan: (self: RootMethods) -> PublicNanValidator,
	IsAnInstance: (self: RootMethods, instanceClass: string) -> PublicInstanceValidator,
	IsAnInstanceStrict: (self: RootMethods, instanceClass: string) -> PublicInstanceValidator,
	IsTable: (self: RootMethods, schema: { [any]: Checker }?) -> PublicTableValidator,
	IsTableStrict: (self: RootMethods, schema: { [any]: Checker }?) -> PublicTableValidator,
	IsTypeOf: (self: RootMethods, type: string) -> PublicTypeValidator,
	IsEnumItem: (self: RootMethods, enum: Enum?) -> PublicEnumValidator,
}
export type PublicRootValidator = PublicValidator & RootMethods
export type PrivateRootValidator = PublicRootValidator & PrivateValidator

--#endregion

--#region Number

export type NumberValidatorMethods = {
	IsGreater: (self: NumberValidatorMethods, than: number) -> PublicNumberValidator,
}
export type PublicNumberValidator = PublicValidator & NumberValidatorMethods & {
	Not: (self: PublicValidator) -> NumberValidatorMethods,
}
export type PrivateNumberValidator = PublicNumberValidator & PrivateValidator

--#endregion

--#region Nil

export type PublicNilValidator = PublicValidator & {}
export type PrivateNilValidator = PublicNilValidator & PrivateValidator

--#endregion

--#region String

export type StringValidatorMethods = {}
export type PublicStringValidator = PublicValidator & StringValidatorMethods & {
	Not: (self: PublicValidator) -> StringValidatorMethods,
}
export type PrivateStringValidator = PublicStringValidator & PrivateValidator

--#endregion

--#region Boolean

export type PublicBooleanValidator = PublicValidator & {}
export type PrivateBooleanValidator = PublicBooleanValidator & PrivateValidator

--#endregion

--#region Boolean

export type PublicNanValidator = PublicValidator & {}
export type PrivateNanValidator = PublicNanValidator & PrivateValidator

--#endregion

--#region Instance

export type InstanceValidatorMethods = {}
export type PublicInstanceValidator = PublicValidator & InstanceValidatorMethods & {}
export type PrivateInstanceValidator = PublicInstanceValidator & PrivateValidator

--#endregion

--#region Table

export type TableValidatorMethods = {}
export type PublicTableValidator = PublicValidator & TableValidatorMethods & {}
export type PrivateTableValidator = PublicTableValidator & PrivateValidator

--#endregion

--#region Type

export type TypeValidatorMethods = {}
export type PublicTypeValidator = PublicValidator & TypeValidatorMethods & {}
export type PrivateTypeValidator = PublicTypeValidator & PrivateValidator

--#endregion

--#region Enum

export type EnumValidatorMethods = {}
export type PublicEnumValidator = PublicValidator & EnumValidatorMethods & {}
export type PrivateEnumValidator = PublicEnumValidator & PrivateValidator

--#endregion

return {}
