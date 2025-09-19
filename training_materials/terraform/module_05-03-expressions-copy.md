# Module 5-03 - Advanced Jamf Pro Configuration

## _Duration: 2 hour | Labs: 7_ | Difficulty: 🟡 Intermediate\*

## 🎯 Learning Objectives

By the end of this module, you will be able to:

- ✅ Use expressions in the context of Jamf Pro resources
- ✅ Create Types and Values - Using data type handling
- ✅ Create String Templates - Using dynamic string construction
- ✅ Use Operators - Using mathematical and logic operations
- ✅ Create Conditional Expressions - Using If/else statements
- ✅ Use For Expressions - Developing Data transformation loops
- ✅ Create Splat Expressions - Collecting element extraction
- ✅ Use Dynamic Blocks - Creating Dynamic resource configuration

### 📚 Topics Covered

Now that you have had time to play around with the most common resources that will be used in the day to day of managing Jamf. This section will take you through some of the more advanced techniques that you can use in Terraform to make the code as dynamic as possible and allow you to do some pretty clever things with the management of your Jamf instance.

Overall, these advanced techniques can be referred to as 'Expressions' and will probably be referenced as expressions throughout this section.

**Expressions** are the building blocks of Terraform configurations that **compute and return values**. They can reference variables, perform calculations, transform data, and implement complex logic.

In this section, you will cover the following topics:

- [**Types and Values** - Data type handling](#-types-and-values)
- [**String Templates** - Dynamic string construction](#-string-templates)
- [**Operators** - Mathematical and logical operations](#-operators)
- [**Conditional Expressions** - If/else logic](#-conditional-expressions)
- [**For Expressions** - Data transformation loops](#-for-expressions)
- [**Splat Expressions** - Collection element extraction](#-splat-expressions)
- [**Dynamic Blocks** - Dynamic resource configuration](#-dynamic-blocks)

**Examples of Expressions**

```hcl
# Expression examples
locals {
  # Simple value expression
  department = "Engineering"

  # Mathematical expression
  policy_retry_limit = var.base_retry * 2

  # Conditional expression
  configuration_scope = var.environment == "production" ? "All Computers" : "Test Group"

  # For expression
  computer_names = [for i in range(3) : "Eng-MacBook-${i + 1}"]

  # String template
  profile_name = "${var.project}-Config-${local.department}-${random_id.suffix.hex}"
}
```

## Types and Values

Terraform uses expressions to define configuration in .tf files. Expressions are made up of values and types, which determine how Terraform interprets and validates your configuration.

Understanding types and values is key to writing clean, reusable modules — and will help when working with providers like the Jamf Pro provider we will be using in this course.

### Understanding Types and Values

#### Types

Terraform has several **primitive types**:

- **string** – text values

  Example: `"Hello world"`

- **number** – integers or decimals

  Example: `42`, `3.14`

- **bool** – true or false

  Example: `true`, `false`

And several **complex types**:

- **list(<TYPE>)** – an ordered sequence

  Example: `["macOS", "iOS", "tvOS"]`

- **map(<TYPE>)** – key/value pairs

  Example: `{ "admin" = "Alice", "viewer" = "Bob" }`

- **set(<TYPE>)** – an unordered collection of unique values

  Example: `["alpha", "beta", "gamma"]`

- **object({ … })** – a collection of named attributes with specified types

  Example:

  ```bash
  {
  username = "jamf-admin"
  enabled  = true
  roles    = ["read", "write"]
  }
  ```

- **tuple([ … ])** – a fixed-length ordered collection of potentially different types

  Example: `[ "macOS", 14, true ]`

#### Values

Values are the actual data that populate those types.

**Primitive Value** examples:

```
# string
name = "MacBook Pro"

# number (integer)
device_limit = 5

# number (float/decimal)
os_version = 14.2

# bool
enabled = true
```

**Complex Value** examples:

```
# list(string)
os_list = ["macOS", "iOS", "iPadOS"]

# list(number)
ports = [80, 443, 8080]

# map(string)
user_roles = {
  "alice" = "admin"
  "bob"   = "viewer"
}

# set(string)
unique_tags = toset(["alpha", "beta", "beta"])
# result is ["alpha", "beta"] because there is no duplicates (unique)

# object
device_info = {
  name    = "Jamf-managed Mac"
  enabled = true
  tags    = ["macOS", "laptop"]
}

# tuple
mixed_values = ["Mac", 14, true]
```

#### Type Conversion

Terraform will try to convert values when possible:

```hcl
# number can be used where string is expected
title = "Version ${1.0}"   # becomes "Version 1"
```

But not all conversions are allowed — e.g., `"abc"` cannot convert to a number.

#### Practical Examples

**Example 1:** Variable with a simple type:

```hcl
# Number type
variable "device_limit" {
  type    = number
  default = 10
}

# String type
variable "device_name" {
  type    = string
  default = "MacBook Pro"
}
```

**Example 2:** Variable with a complex type:

```hcl
# Object type
variable "device_info" {
  type = object({
    name    = string
    enabled = bool
    tags    = list(string)
  })
  default = {
    name    = "Jamf-managed Mac"
    enabled = true
    tags    = ["macOS", "laptop"]
  }
}

# List type
variable "macos_versions" {
  description = "List of supported macOS versions"
  type        = list(string)
  default = [
    "13.6",  # Ventura
    "14.5",  # Sonoma
    "15.0",  # Sequoia (example future release)
  ]
}
```

### Exercises

Now that we have covered some types and values, we will go over some exercises to develop the knowledge in practical examples.

#### Exercises 1 - Identify Types

Look at the following values. What type is each?

```hcl
"Jamf Pro"
false
["alpha", "beta", "gamma"]
{ "us" = "New York", "eu" = "Berlin" }
[ "Mac", 14, true ]
```

**Answer:**

<details>
  <summary>Click to reveal</summary>
  <ul>
    <li>String</li>
    <li>boolean</li>
    <li>list</li>
    <li>map</li>
    <li>tuple</li>
  </ul>
</details>

#### Exercise 2 - Defining a Variable

Write a variable that defines a list of device models (strings), with a default of at least 3 models.

**Answer:**

<details>

  <summary>Click to reveal</summary>

```hcl
variable "macos_versions" {
  description = "List of supported macOS versions"
  type        = list(string)
  default = [
    "13.6",  # Ventura
    "14.5",  # Sonoma
    "15.0",  # Sequoia (example future release)
  ]
}
```

</details>

#### Exercise 3 - Object Practice

Define a variable admin_user as an object with:

- `username` (string)
- `enabled` (bool)
- `roles` (list of strings)

Set the default to `"jamf-admin"`, `true`, and `["read", "write"]`.

**Answer:**

<details>

  <summary>Click to reveal</summary>

```hcl
  variable "admin_user" {
    type = object({
      username    = string
      enabled = bool
      roles    = list(string)
    })
    default = {
      username    = "jamf-admin"
      enabled = true
      tags    = ["read", "write"]
    }
  }
```

</details>

#### Exercise 4 - Bonus (Maps)

Create a map of department names to the number of devices they manage.

Example:

```hcl
it = 120
hr = 30
marketing = 45
```

**Answer:**

<details>

  <summary>Click to reveal</summary>

```hcl
  variable "department_devices" {
    type = map(number)
    description = "A map of departments and devices they manage"
    default = {
      it        = 120
      hr        = 30
      marketing = 45
    }
  }
```

</details>

### Wrap-Up

Types define the shape of values.

Values are the actual data.

Terraform validates that values match expected types, preventing errors.

Mastering this helps when defining reusable modules and provider configurations (e.g., Jamf Pro).
