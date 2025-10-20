<div align="center">
  <h1>Validator</h1>
  <p>
    <a href="https://github.com/bogotolec/validator/releases/latest">
      <img src="https://img.shields.io/github/v/release/bogotolec/validator.svg" alt="Latest release" />
    </a>
    <a href="https://github.com/bogotolec/validator/actions">
      <img src="https://github.com/bogotolec/validator/actions/workflows/publish.yaml/badge.svg" alt="Build and release status" />
    </a>
    <a href="https://github.com/bogotolec/validator/actions">
      <img src="https://github.com/bogotolec/validator/actions/workflows/ci.yaml/badge.svg" alt="Build and release status" />
    </a>
  </p>
  <p>
    A powerful and flexible data validation library for Roblox
  </p>
</div>

## Installation

### Using wally

Validator can be added as a dependency in [Wally](https://wally.run/) project:

```toml
[dependencies]
Validator = "bogotolec/validator@0.1.0"
```

### Downloading from releases

1. Go to [releases page](https://github.com/bogotolec/validator/releases/)
2. Download Validator.rbxm of preferred version
3. Insert the file into project of Roblox Studio

## Usage

### Basic Validation

Create a simple validator and use it to validate values:

```lua
local Validator = require("Validator")

-- Create a validator for numbers
local number = Validator.IsInteger():Freeze()

-- Use Check() to test values
print(number:Check(5)) -- true
print(number:Check(0.5)) -- true
print(number:Check("hello")) -- false

-- Use Assert() to throw errors for invalid values
number:Assert(5) -- passes
number:Assert(0.5) -- throws error: `Value {value} does not satisfy the validator checks.`
number:Assert(0.5, "Number must be integer") -- throws error: "Number must be integer"
```

### Complex Validation Chain

Build more complex validators by chaining multiple conditions:

```lua
local Validator = require("Validator")

-- Create a validator for a player instance
local playerValidator = Validator
    .IsAnInstance("Player")
    :IsProperty("Name", Validator.IsString():MinLen(3):Freeze())
    :HasTag("Active")
    :Freeze()

-- Validate a player
local function validatePlayer(player)
    return playerValidator:Assert(player, "Invalid player instance")
end
```

### Using OR Logic

Combine multiple conditions with OR logic:

```lua
local Validator = require("Validator")

-- Create a validator that accepts either numbers or strings
local numberOrString = Validator
    .IsNumber()
    :Or()
    :IsString()
    :Freeze()

print(numberOrString:Check(42)) -- true
print(numberOrString:Check("hello")) -- true
print(numberOrString:Check(true)) -- false
```

### Using NOT Logic

Negate validation rules using Not():

```lua
local Validator = require("Validator")

-- Create a validator for numbers between 0 and 100
local numberInRange = Validator
    .IsNumber()
    :IsGreater(0)    -- must be > 0
    :Not()
    :IsGreater(100)  -- must NOT be > 100
    :Freeze()

print(numberInRange:Check(0)) -- false (not > 0)
print(numberInRange:Check(50)) -- true (> 0 and not > 100)
print(numberInRange:Check(100)) -- true (> 0 and not > 100)
print(numberInRange:Check(101)) -- false (> 100)
```

### Table Validation

Validate table structures with schema:

```lua
local Validator = require("Validator")

-- Create validators for table fields
local nameValidator = Validator.IsString():MinLen(2):Freeze()
local ageValidator = Validator.IsNumber():IsGreater(0):Freeze()

-- Create a validator for a person table
local personValidator = Validator
    .IsTable({
        name = nameValidator,
        age = ageValidator,
    })
    :Freeze()

-- Validate a person table
local person = {
    name = "John",
    age = 25,
}
print(personValidator:Check(person)) -- true

local invalidPerson = {
    name = "J", -- too short
    age = 25,
}
print(personValidator:Check(invalidPerson)) -- false
```

## API Reference

### Core Methods

#### Validation Methods

These methods could be used anytime, both before and after freezing.

- `:Check(data: any) -> boolean` - Returns true if the data matches all validation rules.
- `:Assert(data: any, message?: string) -> any` - Throws an error with optional message if validation fails, otherwise returns the data.

#### Chain Building Methods

- `:Or()` - Starts a new validation chain combined with OR logic.
- `:Not()` - Negates the next validation rule in the chain.
- `:Freeze()` - Finalizes the validator and prevents further modifications.

#### Common Validation Methods

Available on most validator types before freezing:

- `:IsInTable(table: {[any]: any})` - Checks if value exists as a value in the given table
- `:IsKeyOf(table: {[any]: any})` - Checks if value exists as a key in the given table
- `:IsEqual(otherValue: any)` - Checks if value exactly equals the given value

**Warning:** Table methods don't clone the input table, so avoid using tables that might change.

### Number Validation

By default, all number validators checks that given value is not NaN.

- `:IsNumber()` - Validates that value is a number.
- `:IsInteger()` - Validates that value is an integer.

After above methods, below methods can be used until the next `:Or`:

- `:IsGreater(than: number)` - Checks if number is greater than given value.

### Nan Validation

- `IsNan() -> NanValidator` - Validates that value is NaN.

### String Validation

- `IsString()` - Validates that value is a string.

After above methods, below methods can be used until the next `:Or`:

- `IsUTF8()` - Validates that string is valid UTF-8
- `MaxLen(len: number)` - Sets maximum string length in bytes.
- `MinLen(len: number)` - Sets minimum string length in bytes.
- `MaxUTF8Len(len: number)` - Sets maximum length in UTF-8 characters.
- `MinUTF8Len(len: number)` - Sets minimum length in UTF-8 characters.

### Instance Validation

- `IsAnInstance(instanceClass: string)` - Validates that value is an Instance of given class.
- `IsAnInstanceStrict(instanceClass: string)` - Validates that value is exactly the given class (no inheritance).

After above methods, below methods can be used until the next `:Or`:

- `IsProperty(property: string, validator: Validator)` - Validates an instance property.
- `IsAttribute(attribute: string, validator: Validator)` - Validates an instance attribute.
- `HasTag(tag: string)` - Checks if instance has given tag.

### Table Validation

- `:IsTable(schema?: {[any]: Validator})` - Validates tables with optional schema.
- `:IsTableStrict(schema?: {[any]: Validator})` - Validates tables with optional schema, but will trigger negatively if there are extra keys, which are not present in provided schema.

In both methods schema represents a table with any keys and Validator values, so in given data all the values will be checked with Validator of such key.

### Boolean validation

- `:IsBoolean()` - Validates that value is a boolean.

### Enum validation

- `:IsEnumItem(enum?: Enum)` - Validates that value is an EnumItem. You can specify if a value is EnumItem of specific Enum.

### Simple Type Validation

- `:IsTypeOf(type: string)` - Validates value's type. Can be used for Vectors, CFrames, etc.

### Nil Validation

- `:IsNil()` - Validates that value is nil.
