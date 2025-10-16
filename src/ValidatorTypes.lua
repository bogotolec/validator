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

return {}
