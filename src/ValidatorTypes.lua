--!strict

export type Check = false | {
	_func: (any, ...any) -> boolean,
	_params: typeof(table.pack(...)),
}

export type PublicValidator = typeof(setmetatable({}, {})) & {
	Check: (self: PublicValidator, data: any) -> boolean,
	Or: (self: PublicValidator) -> PublicRootValidator,
}
export type PrivateValidator = PublicValidator & {
	_checksGroups: { { Check } },
}

export type RootMethods = {
	IsNumber: (self: PublicValidator) -> PublicNumberValidator,
	IsInteger: (self: PublicValidator) -> PublicNumberValidator,
	IsNil: (self: PublicValidator) -> PublicNilValidator,
}
export type PublicRootValidator = PublicValidator & RootMethods
export type PrivateRootValidator = PublicRootValidator & PrivateValidator

export type NumberValidatorMethods = {
	IsGreater: (self: NumberValidatorMethods, than: number) -> PublicNumberValidator,
}
export type PublicNumberValidator = PublicValidator & NumberValidatorMethods & {
	Not: (self: PublicValidator) -> NumberValidatorMethods,
}
export type PrivateNumberValidator = PublicNumberValidator & PrivateValidator

export type PublicNilValidator = PublicValidator & {}
export type PrivateNilValidator = PublicNilValidator & PrivateValidator

return {}
