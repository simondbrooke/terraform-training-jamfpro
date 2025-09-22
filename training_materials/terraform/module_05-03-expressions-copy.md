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

## String Templates

String templates let you insert values into strings dynamically using the syntax:

```hcl
"Hello, ${var.name}"
```

This is especially useful in Jamf Pro Terraform configurations where you need to build policy names, group names, or labels that include variables, for example, using naming conventions.

### Basic String Templates

This would be how you can use basic string templates by creating a variable of a device name and then outputting it in a sentence:

```hcl
# Create the variable
variable "device_name" {
  default = "MacBook"
}

# Use the Terraform output to display the sentence including the variable
output "greeting" {
  value = "Hello, ${var.device_name}"
}
```

**Result:**

```hcl
Hello, MacBook
```

### Using Multiple Expressions

You can also do this with using multiple expressions:

```hcl
variable "os" {
  default = "macOS"
}

variable "version" {
  default = "14.2"
}

output "full_os_name" {
  value = "${var.os} Version ${var.version}"
}
```

**Result:**

```hcl
macOS Version 14.2
```

### String Templates with Jamf Pro Resources

Imagine you want to name a **Jamf Pro Policy** based on the application it installs and the target OS:

```hcl
variable "app_name" {
  default = "Google Chrome"
}

variable "os" {
  default = "macOS"
}

resource "jamfpro_policy" "chrome_install" {
  name = "Install ${var.app_name} on ${var.os}"

  # ... other Jamf Pro policy arguments ...
}
```

**Resulting policy name in Jamf Pro:**

```hcl
Install Google Chrom on macOS
```

### Interpolation with Functions

String templates can use Terraform functions too. This example uses the lower() function to take an uppercase string and make it lowercase:

```hcl
variable "department" {
  default = "IT"
}

output "lowercase_dept" {
  value = "Department: ${lower(var.department)}"
}
```

**Result:**

```hcl
Department: it
```

### Heredoc Strings (Multiline Templates)

If you need multi-line scrips or messages in Jamf Pro (e.g., a custom script for a policy), use a heredoc:

```hcl
# Using the heredoc syntax of EOT to encapsulate the inline script:
resource "jamfpro_script" "inline_script" {
  name            = "tf-example-script-inline"
  script_contents = <<EOT
#!/bin/bash
echo "Welcome to ${var.department} Department!"
echo "This Mac is managed by Jamf Pro."
EOT
  os_requirements = "13.1"
  priority        = "BEFORE"
  info            = "Your script info here."
  notes           = ""

}
```

### Exercises

Now that you have had some examples of String Templates, here are some exercises to concrete the knowledge.

#### Exercise 1 - Simple Template

Write a String Template that outputs `Installing Zoom on macOS` (using variables `app_name = "Zoom"` and `os = "macOS"`)

**Answer:**

<details>

  <summary>Click to reveal</summary>

```hcl
variable "app_name" {
  default = "Zoom"
}

variable "os" {
  default = "macOS"
}

output "full_os_name" {
  value = "Installing ${var.app_name} on ${var.os}"
}
```

</details>

#### Exercise 2 - Creating a Policy using Strings

Using what you learned in the previous modules, create a Jamf Pro policy, with a payload that performs a recon and with a resource named. Don't scope it to anyone for now:

```hcl
Update Inventory for Marketing
```

(using variables `policy_type = "Update Inventory"` and `department = "Marketing"`)

**Minimal Viable Answer:**

<details>

  <summary>Click to reveal</summary>

```hcl
variable "policy_type" {
  default = "Update Inventory"
}

variable "department" {
  default = "Marketing"
}

resource "jamfpro_policy" "jamfpro_policy_001" {
  name                          = "${var.policy_type} for ${var.department}"
  enabled                       = false

  scope {
    all_computers = false
  }

  payloads {
    maintenance {
      recon                       = true
      reset_name                  = false
      install_all_cached_packages = false
      heal                        = false
      prebindings                 = false
      permissions                 = false
      byhost                      = false
      system_cache                = false
      user_cache                  = false
      verify                      = false
    }
  }
}


```

</details>

#### Exercise 3 - Create a Multiline Script

Write a heredoc string in an inline Jamf Pro Script that outputs the following when run:

```hcl
Hello, Alice!
Your Mac is enrolled in Jamf Pro.
```

(Use a variable `username = "Alice"` in the template)

**Minimal Viable Answer:**

<details>

  <summary>Click to reveal</summary>

```hcl
variable "username" {
  default = "Alice"
}

resource "jamfpro_script" "inline_script" {
  name            = "tf-example-script-inline"
  script_contents = <<EOT
#!/bin/bash
echo "Hello, ${var.username}"
echo "Your Mac is enrolled in Jamf Pro."
EOT
  priority        = "BEFORE"
}
```

</details>

### Wrap-Up

String templates = dynamic text building.

Syntax: `${expression}` inside quotes.

Useful in Jamf Pro for policy names, group names, labels, and scripts.

Works with variables and functions.

Multiline templates (heredocs) are perfect for Jamf Pro scripts.

## Operators

Terraform supports a set of operators that let you combine, compare, and transform values in your configurations.
These are especially useful in Jamf Pro modules where you might want to:

- Decide if a policy should be enabled

- Compare OS versions

- Combine strings for naming conventions

- Work with numbers or counts of devices

### Arithmetic Operators

Arithmetic operators are used for numbers to compute calculations

```hcl
variable "base_devices" {
  default = 50
}

variable "extra_devices" {
  default = 10
}

output "total_devices" {
  value = var.base_devices + var.extra_devices
}
```

**Output:**

```hcl
60
```

Other arithmetic operators:

- \- (subtraction)

- \* (multiplication)

- / (division)

- % (modulus / remainder)

### Comparison Operators

Comparison operators are used to compare two values. The output results are either true or false.

- == (equal to)

- != (not equal to)

- \> (greater than)

- < (less than)

- \>= (greater or equal)

- <= (less or equal)

Example in a Jamf Pro context:

```hcl
variable "os_version" {
  default = 14
}

output "requires_upgrade" {
  value = var.os_version < 15
}
```

**Result:**

```
true
```

### Logical Operators

Logical operators are used for combining boolean values which then outputs either a True or False value.

- && (and)

- || (or)

- ! (not)

Example in Jamf Pro: enabling a policy only if the OS is macOS and the department is IT.

```hcl
variable "os" {
default = "macOS"
}

variable "department" {
default = "IT"
}

output "enable_policy" {
value = var.os == "macOS" && var.department == "IT"
}
```

**Result:**

```
true
```

### Practical Jamf Pro Example

Enable a policy only if department = IT and OS = macOS:

```hcl
variable "department" {
  default = "IT"
}

variable "os" {
  default = "macOS"
}

resource "jamfpro_policy" "security_updates" {
  name    = "Security Updates"
  enabled = var.department == "IT" && var.os == "macOS"

  # Rest of the policy has been ommitted, this would be required to be filled in
}
```

### Exercises

Now that we have gone over the different types of operators, here are some exercises to test your knowledge and implement some resources using what you have learned so far.

#### Exercise 1 - Arithmetic

If the **IT department manages 120 devices** and **HR manages 30 devices**, write an expression that outputs the **total number of devices**.

**Minimal Viable Answer:**

<details>

  <summary>Click to reveal</summary>

```hcl
variable "it_department" {
  default = 120
}

variable "hr_department" {
  default = 30
}

output "total_number_of_devices" {
  value = var.it_department + var.hr_department
}
```

</details>

#### Exercise 2 - Comparison

Write an expression that checks if the `os_version` variable is **greater than or equal to 14**.

**Minimal Viable Answer:**

<details>

  <summary>Click to reveal</summary>

```hcl
variable "os_version" {
  default = 15.6.1 # This can be anything
}

output "check_os_version" {
  value = var.os_version >= 14
}
```

</details>

#### Exercise 3 - Logical

Write a condition that returns `true` if **the app name is "Chrome"** OR **the app name is "Firefox"**.

**Minimal Viable Answer:**

<details>

  <summary>Click to reveal</summary>

```hcl
variable "app_name" {
  default = "Chrome # This can be anything
}

output "check_os_version" {
  value = var.app_name == "Chrome || var.app_name == "Firefox"
}
```

</details>

#### Exercise 4 - Jamf Pro Policy Example

Create a Jamf Pro policy resource that is only enabled if the department is `Engineering` and the OS is `macOS`. The policy should be named `Engineering macOS Policy`. The Payload can be anything, for simplicity, you can just enable the recon maintenance payload.

**Minimal Viable Answer:**

<details>

  <summary>Click to reveal</summary>

```hcl
variable "department" {
  default = "Engineering
}

variable "operating_system" {
  default = "macOS"
}

jamfpro_policy "engineer_policy" {
  name                          = "${var.department} ${var.operating_system} Policy"
  enabled                       = var.department == "Engineering" && var.operating_system == "macOS"

  scope {
    all_computers = false
  }

  payloads {
    maintenance {
      recon                       = true
      reset_name                  = false
      install_all_cached_packages = false
      heal                        = false
      prebindings                 = false
      permissions                 = false
      byhost                      = false
      system_cache                = false
      user_cache                  = false
      verify                      = false
    }
  }
}
```

</details>

## Conditional Expressions

## For Expressions

## Splat Expressions

## Dynamic Blocks
