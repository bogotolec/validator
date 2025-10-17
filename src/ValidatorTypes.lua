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

	IsInTable: (self: NumberValidatorMethods, table: { [any]: any }) -> PublicNumberValidator,
	IsKeyOf: (self: NumberValidatorMethods, table: { [any]: any }) -> PublicNumberValidator,
	IsEqual: (self: NumberValidatorMethods, otherValue: any) -> PublicNumberValidator,
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

export type StringValidatorMethods = {
	IsUTF8: (self: StringValidatorMethods) -> PublicStringValidator,
	MaxLen: (self: StringValidatorMethods, len: number) -> PublicStringValidator,
	MinLen: (self: StringValidatorMethods, len: number) -> PublicStringValidator,
	MaxUTF8Len: (self: StringValidatorMethods, len: number) -> PublicStringValidator,
	MinUTF8Len: (self: StringValidatorMethods, len: number) -> PublicStringValidator,

	IsInTable: (self: StringValidatorMethods, table: { [any]: any }) -> PublicStringValidator,
	IsKeyOf: (self: StringValidatorMethods, table: { [any]: any }) -> PublicStringValidator,
	IsEqual: (self: StringValidatorMethods, otherValue: any) -> PublicStringValidator,
}
export type PublicStringValidator = PublicValidator & StringValidatorMethods & {
	Not: (self: PublicValidator) -> StringValidatorMethods,
}
export type PrivateStringValidator = PublicStringValidator & PrivateValidator

--#endregion

--#region Boolean

export type BooleanValidatorMethods = {
	IsInTable: (self: BooleanValidatorMethods, table: { [any]: any }) -> PublicBooleanValidator,
	IsKeyOf: (self: BooleanValidatorMethods, table: { [any]: any }) -> PublicBooleanValidator,
	IsEqual: (self: BooleanValidatorMethods, otherValue: any) -> PublicBooleanValidator,
}
export type PublicBooleanValidator = PublicValidator & {
	Not: (self: PublicValidator) -> BooleanValidatorMethods,
}
export type PrivateBooleanValidator = PublicBooleanValidator & PrivateValidator

--#endregion

--#region Nan

export type PublicNanValidator = PublicValidator & {}
export type PrivateNanValidator = PublicNanValidator & PrivateValidator

--#endregion

--#region Instance

export type InstanceValidatorMethods = {
	IsProperty: (
		self: InstanceValidatorMethods,
		property: string,
		checker: Checker
	) -> PublicInstanceValidator,
	IsAttribute: (
		self: InstanceValidatorMethods,
		attribute: string,
		checker: Checker
	) -> PublicInstanceValidator,
	HasTag: (self: InstanceValidatorMethods, tag: string) -> PublicInstanceValidator,

	IsInTable: (self: InstanceValidatorMethods, table: { [any]: any }) -> PublicInstanceValidator,
	IsKeyOf: (self: InstanceValidatorMethods, table: { [any]: any }) -> PublicInstanceValidator,
	IsEqual: (self: InstanceValidatorMethods, otherValue: any) -> PublicInstanceValidator,
}
export type PublicInstanceValidator = PublicValidator & InstanceValidatorMethods & {
	Not: (self: PublicValidator) -> InstanceValidatorMethods,
}
export type PrivateInstanceValidator = PublicInstanceValidator & PrivateValidator

--#endregion

--#region Table

export type TableValidatorMethods = {
	IsInTable: (self: TableValidatorMethods, table: { [any]: any }) -> PublicTableValidator,
	IsKeyOf: (self: TableValidatorMethods, table: { [any]: any }) -> PublicTableValidator,
	IsEqual: (self: TableValidatorMethods, otherValue: any) -> PublicTableValidator,
}
export type PublicTableValidator = PublicValidator & TableValidatorMethods & {
	Not: (self: PublicValidator) -> TableValidatorMethods,
}
export type PrivateTableValidator = PublicTableValidator & PrivateValidator

--#endregion

--#region Type

export type TypeValidatorMethods = {
	IsInTable: (self: TypeValidatorMethods, table: { [any]: any }) -> PublicTypeValidator,
	IsKeyOf: (self: TypeValidatorMethods, table: { [any]: any }) -> PublicTypeValidator,
	IsEqual: (self: TypeValidatorMethods, otherValue: any) -> PublicTypeValidator,
}
export type PublicTypeValidator = PublicValidator & TypeValidatorMethods & {
	Not: (self: PublicValidator) -> TypeValidatorMethods,
}
export type PrivateTypeValidator = PublicTypeValidator & PrivateValidator

--#endregion

--#region Enum

export type EnumValidatorMethods = {
	IsInTable: (self: EnumValidatorMethods, table: { [any]: any }) -> PublicEnumValidator,
	IsKeyOf: (self: EnumValidatorMethods, table: { [any]: any }) -> PublicEnumValidator,
	IsEqual: (self: EnumValidatorMethods, otherValue: any) -> PublicEnumValidator,
}
export type PublicEnumValidator = PublicValidator & EnumValidatorMethods & {
	Not: (self: PublicValidator) -> EnumValidatorMethods,
}
export type PrivateEnumValidator = PublicEnumValidator & PrivateValidator

--#endregion

return {}
