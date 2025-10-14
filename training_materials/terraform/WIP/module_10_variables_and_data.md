# 📊 Module 10: Variables and Data

## _Duration: 2.5 hours | Labs: 3_ | Difficulty: 🟢🟡 Beginner - Intermediate\*

### 🎯 Learning Objectives

By the end of this module, you will be able to:

- ✅ Master input variables with advanced types and validation for Jamf Pro resources
- ✅ Use variable definition files and environment variables in Jamf Pro configurations
- ✅ Understand variable precedence and loading order
- ✅ Create and use output values effectively for Jamf Pro resource integration
- ✅ Work with local values for computed expressions in device management
- ✅ Use data sources to query existing Jamf Pro infrastructure
- ✅ Implement variable validation and sensitive handling for API credentials
- ✅ Reference named values across Jamf Pro configurations

### 📚 Topics Covered

#### 📥 Input Variables

Input variables serve as **parameters** for Terraform configurations, making them flexible and reusable across different Jamf Pro environments.

**🎯 Variable Declaration Syntax:**

```hcl
variable "name" {
  description = "Description of the variable"
  type        = string
  default     = "default_value"
  sensitive   = false
  nullable    = true

  validation {
    condition     = length(var.name) > 0
    error_message = "Name cannot be empty."
  }
}
```

**📋 Variable Types for Jamf Pro:**

**🔤 String Variables:**

String variables are the most common type, used for text-based configuration values like names, descriptions, and identifiers. In Jamf Pro contexts, strings are essential for resource naming, process identification, and user-facing text.

```hcl
variable "extension_attribute_name" {
  description = "Name for the computer extension attribute"
  type        = string
  default     = "Department Code"

  validation {
    condition     = can(regex("^[A-Za-z0-9 _-]+$", var.extension_attribute_name))
    error_message = "Extension attribute name must contain only alphanumeric characters, spaces, hyphens, and underscores."
  }
}

variable "jamf_environment" {
  description = "Jamf Pro environment"
  type        = string

  validation {
    condition     = contains(["dev", "staging", "prod"], var.jamf_environment)
    error_message = "Jamf environment must be dev, staging, or prod."
  }
}

variable "restricted_software_process" {
  description = "Process name to restrict"
  type        = string

  validation {
    condition     = length(var.restricted_software_process) > 0 && can(regex("\\.(app|exe)$", var.restricted_software_process))
    error_message = "Process name must end with .app or .exe extension."
  }
}
```

**💡 String Variable Best Practices:**

- **Use descriptive names**: `extension_attribute_name` instead of just `name`
- **Include validation**: Regex patterns ensure proper formatting for Jamf Pro requirements
- **Provide defaults**: Sensible defaults reduce configuration overhead
- **Environment-specific**: Use string variables for environment differentiation (dev/staging/prod)
- **Resource naming**: Strings are perfect for creating consistent naming conventions across Jamf Pro resources

**🔢 Number Variables:**

Number variables handle numeric values including integers and floating-point numbers. In Jamf Pro, numbers are crucial for timeouts, intervals, priorities, counts, and IDs. They're essential for configuring security policies, API settings, and operational parameters.

```hcl
variable "api_token_lifetime_hours" {
  description = "API token lifetime in hours"
  type        = number
  default     = 2

  validation {
    condition     = var.api_token_lifetime_hours >= 1 && var.api_token_lifetime_hours <= 24
    error_message = "API token lifetime must be between 1 and 24 hours."
  }
}

variable "password_rotation_hours" {
  description = "LAPS password rotation interval in hours"
  type        = number
  default     = 24

  validation {
    condition     = var.password_rotation_hours >= 1 && var.password_rotation_hours <= 168
    error_message = "Password rotation must be between 1 and 168 hours (1 week)."
  }
}

variable "enrollment_rank" {
  description = "Rank order for enrollment panes"
  type        = number
  default     = 1

  validation {
    condition     = var.enrollment_rank >= 1 && var.enrollment_rank <= 10
    error_message = "Enrollment rank must be between 1 and 10."
  }
}

variable "max_popup_choices" {
  description = "Maximum number of choices in popup menus"
  type        = number
  default     = 15

  validation {
    condition     = var.max_popup_choices >= 2 && var.max_popup_choices <= 50
    error_message = "Popup menu choices must be between 2 and 50 options."
  }
}
```

**💡 Number Variable Best Practices:**

- **Range validation**: Always validate numeric ranges for Jamf Pro API limits
- **Business logic**: Use validation to enforce business rules (e.g., token lifetime policies)
- **Unit clarity**: Include units in variable names (hours, seconds, days, count)
- **Reasonable defaults**: Set defaults that work for most environments
- **Security considerations**: Lower numbers for production security settings (shorter token lifetimes)
- **Operational limits**: Consider Jamf Pro's operational constraints when setting ranges

**✅ Boolean Variables:**

Boolean variables represent true/false values and are perfect for feature flags, enable/disable toggles, and conditional logic. In Jamf Pro, booleans control feature activation, security settings, and operational behaviors. They're essential for creating flexible configurations that can be easily toggled.

```hcl
variable "enable_extension_attribute" {
  description = "Enable the extension attribute for inventory collection"
  type        = bool
  default     = true
}

variable "auto_deploy_laps" {
  description = "Enable automatic deployment of LAPS"
  type        = bool
  default     = false
}

variable "kill_restricted_process" {
  description = "Kill process when restricted software is detected"
  type        = bool
  default     = true
}

variable "api_integration_enabled" {
  description = "Enable API integration"
  type        = bool
  default     = true
}

variable "send_notifications" {
  description = "Send notifications for policy violations"
  type        = bool
  default     = true
}

variable "enforce_security_baseline" {
  description = "Enforce security baseline configurations"
  type        = bool
  default     = false
}
```

**💡 Boolean Variable Best Practices:**

- **Clear naming**: Use verbs like `enable_`, `auto_`, `send_`, `enforce_` to indicate action
- **Security defaults**: Default to secure/conservative settings (false for auto-deploy, true for notifications)
- **Environment awareness**: Use booleans for environment-specific feature toggles
- **Feature flags**: Perfect for gradual rollouts and A/B testing scenarios
- **Conditional resources**: Use with `count` or `for_each` to conditionally create resources
- **Documentation**: Clearly document the impact of true/false values in descriptions

**📋 List Variables:**

List variables store ordered collections of values of the same type. In Jamf Pro contexts, lists are perfect for popup menu choices, API scopes, device locations, and any scenario where you need multiple similar values. Lists maintain order and allow duplicates, making them ideal for sequential operations.

```hcl
variable "popup_menu_choices" {
  description = "Choices for extension attribute popup menu"
  type        = list(string)
  default     = ["Engineering", "Sales", "Marketing", "Support", "Executive"]

  validation {
    condition     = length(var.popup_menu_choices) >= 2 && length(var.popup_menu_choices) <= 20
    error_message = "Popup menu must have between 2 and 20 choices."
  }
}

variable "mobile_device_locations" {
  description = "Available device locations"
  type        = list(string)
  default     = ["Head Office", "Branch Office", "Home Office", "Client Site"]
}

variable "api_scopes" {
  description = "API authorization scopes"
  type        = list(string)
  default     = ["Read Computer Extension Attributes", "Create Computer Extension Attributes"]

  validation {
    condition     = length(var.api_scopes) > 0
    error_message = "At least one API scope must be specified."
  }
}

variable "restricted_process_names" {
  description = "List of process names to restrict"
  type        = list(string)
  default     = ["Install macOS Big Sur.app", "Steam.app", "BitTorrent.app"]

  validation {
    condition = alltrue([
      for process in var.restricted_process_names :
      can(regex("\\.app$", process))
    ])
    error_message = "All process names must end with .app extension (macOS application bundles)."
  }
}

variable "enrollment_pane_ranks" {
  description = "Ordered list of enrollment pane ranks"
  type        = list(number)
  default     = [1, 2, 3, 4, 5]

  validation {
    condition = alltrue([
      for rank in var.enrollment_pane_ranks :
      rank >= 1 && rank <= 10
    ])
    error_message = "All enrollment pane ranks must be between 1 and 10."
  }
}
```

**💡 List Variable Best Practices:**

- **Ordered data**: Use lists when order matters (enrollment pane sequences, priority lists)
- **Homogeneous types**: All items in a list must be the same type
- **Validation with `alltrue`**: Validate each item in the list using functions like `alltrue`
- **Length constraints**: Always validate list length for UI and API limitations
- **Default ordering**: Provide sensible default ordering that works for most use cases
- **Iteration**: Perfect for use with `for_each` and `count` meta-arguments
- **Dynamic content**: Lists work well with dynamic blocks for conditional resource creation

**🗺️ Map Variables:**

Map variables store key-value pairs where keys are always strings and values are of a specified type. Maps are excellent for configuration lookups, environment-specific settings, and associating names with values. In Jamf Pro, maps are perfect for branding configurations, environment settings, and attribute type mappings.

```hcl
variable "extension_attribute_types" {
  description = "Extension attribute configurations by type"
  type        = map(string)
  default = {
    department = "POPUP"
    location   = "POPUP"
    asset_tag  = "TEXT"
    notes      = "TEXT"
  }
}

variable "enrollment_branding" {
  description = "Branding colors for enrollment customization"
  type        = map(string)
  default = {
    text_color        = "000000"
    button_color      = "0066CC"
    button_text_color = "FFFFFF"
    background_color  = "F5F5F5"
  }

  validation {
    condition = alltrue([
      for color in values(var.enrollment_branding) : can(regex("^[0-9A-Fa-f]{6}$", color))
    ])
    error_message = "All colors must be valid 6-digit hex codes."
  }
}

variable "laps_settings_by_environment" {
  description = "LAPS settings per environment"
  type        = map(number)
  default = {
    dev     = 1
    staging = 12
    prod    = 24
  }
}

variable "api_token_lifetimes" {
  description = "API token lifetimes by integration type"
  type        = map(number)
  default = {
    development    = 8
    testing       = 4
    production    = 2
    emergency     = 1
  }

  validation {
    condition = alltrue([
      for lifetime in values(var.api_token_lifetimes) :
      lifetime >= 1 && lifetime <= 24
    ])
    error_message = "All API token lifetimes must be between 1 and 24 hours."
  }
}

variable "restriction_severity_levels" {
  description = "Restriction severity levels by software category"
  type        = map(string)
  default = {
    gaming        = "WARN"
    development   = "BLOCK"
    unauthorized  = "TERMINATE"
    suspicious    = "QUARANTINE"
  }

  validation {
    condition = alltrue([
      for level in values(var.restriction_severity_levels) :
      contains(["WARN", "BLOCK", "TERMINATE", "QUARANTINE"], level)
    ])
    error_message = "Severity levels must be WARN, BLOCK, TERMINATE, or QUARANTINE."
  }
}
```

**💡 Map Variable Best Practices:**

- **Key-value relationships**: Perfect for lookups and associations (environment → settings)
- **Configuration tables**: Use for storing related configuration values by category
- **Environment mapping**: Excellent for environment-specific configurations
- **Validation with `values()`**: Validate all map values using the `values()` function
- **Consistent keys**: Use consistent, descriptive key names across your configurations
- **Type consistency**: All values in a map must be the same type
- **Default completeness**: Ensure default maps cover all expected use cases

**🏗️ Complex Object Variables:**

Complex object variables are the most powerful variable type, allowing you to define structured data with multiple attributes of different types. They're perfect for representing complete resource configurations, complex settings with relationships, and multi-faceted data structures. In Jamf Pro, objects excel at representing extension attributes, enrollment customizations, and comprehensive policy configurations.

```hcl
variable "computer_extension_attributes" {
  description = "Computer extension attribute configurations"
  type = map(object({
    enabled                = bool
    description            = string
    input_type             = string
    inventory_display_type = string
    data_type              = string
    popup_choices          = optional(list(string))
    script_contents        = optional(string)
  }))

  default = {
    "Department" = {
      enabled                = true
      description            = "Employee department for device assignment"
      input_type             = "POPUP"
      inventory_display_type = "USER_AND_LOCATION"
      data_type              = "STRING"
      popup_choices          = ["Engineering", "Sales", "Marketing", "Support"]
      script_contents        = null
    }
    "Asset Tag" = {
      enabled                = true
      description            = "Physical asset tag number"
      input_type             = "TEXT"
      inventory_display_type = "HARDWARE"
      data_type              = "STRING"
      popup_choices          = null
      script_contents        = null
    }
    "OS Build" = {
      enabled                = true
      description            = "Operating system build version"
      input_type             = "SCRIPT"
      inventory_display_type = "GENERAL"
      data_type              = "STRING"
      popup_choices          = null
      script_contents        = "#!/bin/bash\nsw_vers -buildVersion"
    }
  }

  validation {
    condition = alltrue([
      for name, config in var.computer_extension_attributes :
      contains(["POPUP", "TEXT", "SCRIPT"], config.input_type)
    ])
    error_message = "Input type must be POPUP, TEXT, or SCRIPT."
  }

  validation {
    condition = alltrue([
      for name, config in var.computer_extension_attributes :
      config.input_type != "POPUP" || config.popup_choices != null
    ])
    error_message = "POPUP input type requires popup_choices to be specified."
  }

  validation {
    condition = alltrue([
      for name, config in var.computer_extension_attributes :
      config.input_type != "SCRIPT" || config.script_contents != null
    ])
    error_message = "SCRIPT input type requires script_contents to be specified."
  }
}
```

**💡 Complex Object Variable Best Practices:**

- **Logical grouping**: Group related attributes together in meaningful object structures
- **Optional fields**: Use `optional()` for fields that aren't always required
- **Multiple validation rules**: Create separate validation blocks for different business rules
- **Conditional validation**: Use logical operators to validate field dependencies
- **Nested structures**: Objects can contain other complex types (lists, maps, nested objects)
- **Documentation**: Clearly document object structure and field relationships
- **Default completeness**: Provide complete default objects that demonstrate proper usage
- **Type safety**: Object types enforce structure and catch configuration errors early
- **Resource mapping**: Perfect for one-to-one mapping with complex Jamf Pro resources
- **Environment variations**: Use objects to represent environment-specific configurations with the same structure

**🔗 Variable Type Summary:**

| Variable Type | Use Case                         | Jamf Pro Examples                                            | Key Features                                   |
| ------------- | -------------------------------- | ------------------------------------------------------------ | ---------------------------------------------- |
| **String**    | Text values, names, identifiers  | Extension attribute names, process names, environment labels | Simple, validation-friendly, human-readable    |
| **Number**    | Numeric values, counts, timeouts | API token lifetimes, rotation hours, rank orders             | Range validation, mathematical operations      |
| **Boolean**   | Feature flags, enable/disable    | Auto-deploy settings, kill processes, send notifications     | Simple true/false logic, conditional resources |
| **List**      | Ordered collections, sequences   | Popup choices, API scopes, process names                     | Ordered, homogeneous, iteration-friendly       |
| **Map**       | Key-value associations, lookups  | Environment settings, branding colors, type mappings         | Fast lookups, configuration tables             |
| **Object**    | Complex structured data          | Extension attributes, enrollment customizations              | Most flexible, type-safe, validation-rich      |

variable "mobile_extension_attributes" {
description = "Mobile device extension attribute configurations"
type = map(object({
description = string
data_type = string
inventory_display_type = string
input_type = string
popup_choices = optional(list(string))
}))

default = {
"Device Location" = {
description = "Primary location where device is used"
data_type = "STRING"
inventory_display_type = "USER_AND_LOCATION"
input_type = "POPUP"
popup_choices = ["Head Office", "Branch Office", "Home Office", "Client Site"]
}
"User Department" = {
description = "Department of device user"
data_type = "STRING"
inventory_display_type = "GENERAL"
input_type = "TEXT"
popup_choices = null
}
}
}

variable "restricted_software_configs" {
description = "Restricted software configurations"
type = map(object({
process_name = string
match_exact_process_name = bool
send_notification = bool
kill_process = bool
delete_executable = bool
display_message = string
}))

default = {
"high_sierra_installer" = {
process_name = "Install macOS High Sierra.app"
match_exact_process_name = true
send_notification = true
kill_process = true
delete_executable = true
display_message = "macOS High Sierra installation is not permitted on this device."
}
"unauthorized_game" = {
process_name = "Game.app"
match_exact_process_name = false
send_notification = true
kill_process = true
delete_executable = false
display_message = "Gaming applications are restricted during business hours."
}
}
}

variable "enrollment_customizations" {
description = "Enrollment customization configurations"
type = map(object({
display_name = string
description = string
branding = object({
text_color = string
button_color = string
button_text_color = string
background_color = string
})
text_pane = optional(object({
title = string
body = string
subtext = string
back_button_text = string
continue_button_text = string
}))
sso_enabled = bool
}))

default = {
"Corporate Standard" = {
display_name = "Corporate Device Enrollment"
description = "Standard corporate device enrollment process"
branding = {
text_color = "000000"
button_color = "0066CC"
button_text_color = "FFFFFF"
background_color = "F5F5F5"
}
text_pane = {
title = "Welcome to Corporate IT"
body = "We're setting up your device with the tools you need to be productive."
subtext = "This process takes about 10 minutes."
back_button_text = "Back"
continue_button_text = "Continue"
}
sso_enabled = true
}
"Executive Enrollment" = {
display_name = "Executive Device Setup"
description = "Enhanced enrollment for executive devices"
branding = {
text_color = "000000"
button_color = "1F4E79"
button_text_color = "FFFFFF"
background_color = "F8F9FA"
}
text_pane = {
title = "Executive Device Configuration"
body = "Your device will be configured with executive-level access and security."
subtext = "Please contact IT if you need assistance."
back_button_text = "Previous"
continue_button_text = "Proceed"
}
sso_enabled = true
}
}
}

````

#### 🔒 Sensitive Variables

**🛡️ Sensitive Variable Handling for Jamf Pro:**
```hcl
variable "jamf_api_credentials" {
  description = "Jamf Pro API credentials"
  type = object({
    client_id     = string
    client_secret = string
  })
  sensitive = true

  validation {
    condition     = length(var.jamf_api_credentials.client_id) > 0 && length(var.jamf_api_credentials.client_secret) > 0
    error_message = "Both client_id and client_secret must be provided."
  }
}

variable "vpp_service_token" {
  description = "Apple Business Manager VPP service token"
  type        = string
  sensitive   = true

  validation {
    condition     = can(base64decode(var.vpp_service_token))
    error_message = "VPP service token must be a valid base64 encoded string."
  }
}

variable "enrollment_image_path" {
  description = "Path to enrollment customization image"
  type        = string
  sensitive   = true
  default     = "/path/to/secure/logo.png"
}

variable "ldap_credentials" {
  description = "LDAP server credentials for enrollment"
  type = object({
    bind_username = string
    bind_password = string
  })
  sensitive = true
  default = {
    bind_username = ""
    bind_password = ""
  }
}
````

#### 📂 Variable Definition Files

**📁 terraform.tfvars (Auto-loaded):**

```hcl
# terraform.tfvars
jamf_environment = "production"

extension_attribute_name = "Corporate Department"
api_token_lifetime_hours = 2
password_rotation_hours  = 24

enable_extension_attribute = true
auto_deploy_laps          = true
kill_restricted_process   = true

popup_menu_choices = [
  "Engineering",
  "Sales",
  "Marketing",
  "Support",
  "Executive",
  "Finance"
]

mobile_device_locations = [
  "Corporate Headquarters",
  "Regional Office - East",
  "Regional Office - West",
  "Remote Work",
  "Client Site"
]

enrollment_branding = {
  text_color        = "2C3E50"
  button_color      = "3498DB"
  button_text_color = "FFFFFF"
  background_color  = "ECF0F1"
}

laps_settings_by_environment = {
  dev     = 1
  staging = 12
  prod    = 24
}
```

**🌍 Environment-Specific Files:**

```hcl
# dev.tfvars
jamf_environment = "dev"
api_token_lifetime_hours = 8
password_rotation_hours = 1
auto_deploy_laps = false

computer_extension_attributes = {
  "Dev Department" = {
    enabled                = true
    description            = "Development department assignment"
    input_type             = "POPUP"
    inventory_display_type = "USER_AND_LOCATION"
    data_type              = "STRING"
    popup_choices          = ["Dev Team", "QA Team", "DevOps"]
    script_contents        = null
  }
}

# staging.tfvars
jamf_environment = "staging"
api_token_lifetime_hours = 4
password_rotation_hours = 12
auto_deploy_laps = true

# prod.tfvars
jamf_environment = "prod"
api_token_lifetime_hours = 2
password_rotation_hours = 24
auto_deploy_laps = true

enrollment_customizations = {
  "Production Enrollment" = {
    display_name = "Corporate Device Enrollment - Production"
    description  = "Production environment device enrollment"
    branding = {
      text_color        = "000000"
      button_color      = "D32F2F"
      button_text_color = "FFFFFF"
      background_color  = "FFFFFF"
    }
    text_pane = {
      title                = "Production Device Setup"
      body                 = "This device will be configured for production use."
      subtext              = "Please ensure you have proper authorization."
      back_button_text     = "Back"
      continue_button_text = "Continue"
    }
    sso_enabled = true
  }
}
```

**🔄 Variable Loading Precedence (Highest to Lowest):**

1. **Command line flags**: `-var` and `-var-file`
2. **Environment variables**: `TF_VAR_jamf_environment`
3. **terraform.tfvars.json**
4. **terraform.tfvars**
5. **\*.auto.tfvars.json** (alphabetical order)
6. **\*.auto.tfvars** (alphabetical order)
7. **Variable defaults** in configuration files

#### 📤 Output Values

Output values expose information about your Jamf Pro infrastructure for use by other configurations, scripts, or users.

**🎯 Basic Output Syntax:**

```hcl
output "name" {
  description = "Description of the output"
  value       = expression
  sensitive   = false
  depends_on  = [resource.example]
}
```

**📊 Jamf Pro Resource Outputs:**

```hcl
# Extension attribute outputs
output "computer_extension_attribute_ids" {
  description = "IDs of created computer extension attributes"
  value = {
    for name, attr in jamfpro_computer_extension_attribute.corporate_attributes :
    name => attr.id
  }
}

output "mobile_extension_attribute_details" {
  description = "Details of mobile device extension attributes"
  value = {
    for name, attr in jamfpro_mobile_device_extension_attribute.device_tracking :
    name => {
      id          = attr.id
      name        = attr.name
      input_type  = attr.input_type
      data_type   = attr.data_type
    }
  }
}

# API integration outputs (sensitive)
output "api_integration_client_id" {
  description = "API integration client ID"
  value       = jamfpro_api_integration.corporate_api.client_id
  sensitive   = true
}

output "api_integration_details" {
  description = "API integration configuration details"
  value = {
    display_name = jamfpro_api_integration.corporate_api.display_name
    enabled      = jamfpro_api_integration.corporate_api.enabled
    token_lifetime = jamfpro_api_integration.corporate_api.access_token_lifetime_seconds
  }
}

# Restricted software outputs
output "restricted_software_policies" {
  description = "Restricted software policy details"
  value = {
    for name, policy in jamfpro_restricted_software.corporate_restrictions :
    name => {
      id           = policy.id
      process_name = policy.process_name
      enabled      = policy.send_notification
    }
  }
}

# Enrollment customization outputs
output "enrollment_customization_ids" {
  description = "Enrollment customization IDs for reference"
  value = {
    for name, enrollment in jamfpro_enrollment_customization.corporate_enrollments :
    name => enrollment.id
  }
}

output "enrollment_branding_summary" {
  description = "Summary of enrollment branding configurations"
  value = {
    for name, enrollment in jamfpro_enrollment_customization.corporate_enrollments :
    name => {
      display_name     = enrollment.display_name
      button_color     = enrollment.branding_settings[0].button_color
      background_color = enrollment.branding_settings[0].background_color
    }
  }
}

# VPP and LAPS outputs
output "vpp_location_id" {
  description = "Volume Purchasing Program location ID"
  value       = jamfpro_volume_purchasing_locations.corporate_vpp.id
}

output "laps_configuration_summary" {
  description = "LAPS configuration summary"
  value = {
    auto_deploy_enabled    = jamfpro_local_admin_password_settings.corporate_laps.auto_deploy_enabled
    rotation_time_hours    = jamfpro_local_admin_password_settings.corporate_laps.password_rotation_time_seconds / 3600
    auto_rotate_enabled    = jamfpro_local_admin_password_settings.corporate_laps.auto_rotate_enabled
  }
}

# Computed outputs using locals
output "extension_attribute_summary" {
  description = "Summary of all extension attributes created"
  value = {
    total_computer_attributes = length(local.computer_attributes)
    total_mobile_attributes   = length(local.mobile_attributes)
    popup_attributes          = length(local.popup_attributes)
    text_attributes          = length(local.text_attributes)
    script_attributes        = length(local.script_attributes)
  }
}

# Environment-specific outputs
output "environment_configuration" {
  description = "Current environment configuration summary"
  value = {
    environment         = var.jamf_environment
    api_token_lifetime  = var.api_token_lifetime_hours
    laps_rotation_hours = var.password_rotation_hours
    total_restrictions  = length(var.restricted_software_configs)
    enrollment_types    = length(var.enrollment_customizations)
  }
}
```

#### 🏷️ Local Values

Local values help reduce repetition and improve maintainability by computing expressions once and referencing them multiple times.

**🎯 Local Value Syntax:**

```hcl
locals {
  name = expression
}
```

**🔧 Jamf Pro Local Values:**

```hcl
locals {
  # Common naming conventions
  resource_prefix = "${var.jamf_environment}-${random_string.suffix.result}"

  # Environment-specific settings
  is_production = var.jamf_environment == "prod"
  is_development = var.jamf_environment == "dev"

  # API configuration
  api_token_lifetime_seconds = var.api_token_lifetime_hours * 3600

  # LAPS configuration
  laps_rotation_seconds = var.password_rotation_hours * 3600
  laps_expiration_days = var.jamf_environment == "prod" ? 90 : 30

  # Extension attribute categorization
  computer_attributes = {
    for name, config in var.computer_extension_attributes :
    name => config
  }

  mobile_attributes = {
    for name, config in var.mobile_extension_attributes :
    name => config
  }

  popup_attributes = {
    for name, config in var.computer_extension_attributes :
    name => config
    if config.input_type == "POPUP"
  }

  text_attributes = {
    for name, config in var.computer_extension_attributes :
    name => config
    if config.input_type == "TEXT"
  }

  script_attributes = {
    for name, config in var.computer_extension_attributes :
    name => config
    if config.input_type == "SCRIPT"
  }

  # Restricted software message templates
  restriction_messages = {
    for name, config in var.restricted_software_configs :
    name => "${config.display_message} Contact IT support for assistance."
  }

  # Enrollment customization computed values
  enrollment_titles = {
    for name, config in var.enrollment_customizations :
    name => "${config.display_name} - ${title(var.jamf_environment)}"
  }

  # Branding color validation
  valid_colors = {
    for name, config in var.enrollment_customizations :
    name => {
      text_valid       = can(regex("^[0-9A-Fa-f]{6}$", config.branding.text_color))
      button_valid     = can(regex("^[0-9A-Fa-f]{6}$", config.branding.button_color))
      background_valid = can(regex("^[0-9A-Fa-f]{6}$", config.branding.background_color))
    }
  }

  # Security settings based on environment
  security_settings = {
    kill_process      = local.is_production ? true : var.kill_restricted_process
    delete_executable = local.is_production ? true : false
    send_notification = true
  }

  # VPP configuration
  vpp_config = {
    auto_populate = local.is_production ? true : false
    auto_register = local.is_production ? true : false
    notifications = !local.is_development
  }

  # Common tags for all resources
  common_tags = {
    Environment   = var.jamf_environment
    ManagedBy     = "terraform"
    Module        = "variables-and-data"
    CreatedDate   = formatdate("YYYY-MM-DD", timestamp())
  }

  # Computed scope configurations
  default_scope = {
    all_computers = false
    computer_ids  = []
    building_ids  = local.is_production ? [1, 2, 3] : [99]
  }
}
```

#### 📥 Data Sources

Data sources allow Terraform to fetch information about existing Jamf Pro infrastructure.

**🎯 Data Source Syntax:**

```hcl
data "provider_type" "name" {
  # Configuration arguments
}
```

**Note**: _Currently, the Jamf Pro provider has limited data source support. The following examples demonstrate the pattern using hypothetical data sources that may be available in future provider versions._

**🔍 Hypothetical Jamf Pro Data Sources:**

```hcl
# Query existing categories
data "jamfpro_categories" "existing" {
  filter {
    name   = "name"
    values = ["Security", "Productivity"]
  }
}

# Get specific category details
data "jamfpro_category" "security" {
  name = "Security"
}

# Query existing sites
data "jamfpro_sites" "all" {}

data "jamfpro_site" "main" {
  name = "Main Office"
}

# Get existing extension attributes
data "jamfpro_computer_extension_attributes" "existing" {}

# Query API integrations
data "jamfpro_api_integrations" "current" {
  enabled = true
}

# Get VPP locations
data "jamfpro_volume_purchasing_locations" "existing" {}
```

### 🟢 Simple Use Cases

**📍 Environment Information:**

```hcl
# Random suffix for unique naming
resource "random_string" "suffix" {
  length  = 6
  upper   = false
  special = false
}

# Simple extension attribute with environment-specific naming
resource "jamfpro_computer_extension_attribute" "department" {
  name        = "${var.jamf_environment}-Department-${random_string.suffix.result}"
  enabled     = var.enable_extension_attribute
  description = "Employee department for ${var.jamf_environment} environment"
  input_type  = "POPUP"
  popup_menu_choices = var.popup_menu_choices
  inventory_display_type = "USER_AND_LOCATION"
  data_type   = "STRING"
}

# Basic API integration
resource "jamfpro_api_integration" "basic" {
  display_name                  = "${local.resource_prefix}-basic-api"
  enabled                       = var.api_integration_enabled
  access_token_lifetime_seconds = local.api_token_lifetime_seconds
  authorization_scopes          = var.api_scopes
}
```

**🔧 LAPS Configuration:**

```hcl
# Local admin password settings with environment-specific values
resource "jamfpro_local_admin_password_settings" "corporate" {
  auto_deploy_enabled                 = var.auto_deploy_laps
  password_rotation_time_seconds      = local.laps_rotation_seconds
  auto_rotate_enabled                 = local.is_production
  auto_rotate_expiration_time_seconds = local.laps_expiration_days * 24 * 3600
}
```

**📱 Mobile Extension Attributes:**

```hcl
# Mobile device location tracking
resource "jamfpro_mobile_device_extension_attribute" "location" {
  name                   = "Device Location - ${title(var.jamf_environment)}"
  description            = "Primary location where mobile device is used"
  data_type              = "STRING"
  inventory_display_type = "USER_AND_LOCATION"
  input_type             = "POPUP"
  popup_menu_choices     = var.mobile_device_locations
}

# User department tracking
resource "jamfpro_mobile_device_extension_attribute" "user_dept" {
  name                   = "User Department - ${title(var.jamf_environment)}"
  description            = "Department of mobile device user"
  data_type              = "STRING"
  inventory_display_type = "GENERAL"
  input_type             = "TEXT"
}
```

### 🟡 Medium Use Cases

**🚫 Restricted Software with Dynamic Configuration:**

```hcl
# Create restricted software policies from variable configuration
resource "jamfpro_restricted_software" "corporate_restrictions" {
  for_each = var.restricted_software_configs

  name                     = "${local.resource_prefix}-${each.key}"
  process_name             = each.value.process_name
  match_exact_process_name = each.value.match_exact_process_name
  send_notification        = each.value.send_notification && local.security_settings.send_notification
  kill_process             = each.value.kill_process && local.security_settings.kill_process
  delete_executable        = each.value.delete_executable && local.security_settings.delete_executable
  display_message          = local.restriction_messages[each.key]

  site_id {
    id = -1
  }

  scope {
    all_computers = local.default_scope.all_computers
    building_ids  = local.default_scope.building_ids

    exclusions {
      computer_ids = local.is_development ? [1, 2, 3] : []
    }
  }
}
```

**🎨 Enrollment Customization with Complex Branding:**

```hcl
# Create enrollment customizations from variable configuration
resource "jamfpro_enrollment_customization" "corporate" {
  for_each = var.enrollment_customizations

  site_id      = "-1"
  display_name = local.enrollment_titles[each.key]
  description  = "${each.value.description} (${title(var.jamf_environment)})"

  branding_settings {
    text_color        = each.value.branding.text_color
    button_color      = each.value.branding.button_color
    button_text_color = each.value.branding.button_text_color
    background_color  = each.value.branding.background_color
  }

  # Conditional text pane
  dynamic "text_pane" {
    for_each = each.value.text_pane != null ? [each.value.text_pane] : []
    content {
      display_name         = "Welcome - ${each.key}"
      rank                 = var.enrollment_rank
      title                = text_pane.value.title
      body                 = text_pane.value.body
      subtext              = "${text_pane.value.subtext} Environment: ${upper(var.jamf_environment)}"
      back_button_text     = text_pane.value.back_button_text
      continue_button_text = text_pane.value.continue_button_text
    }
  }

  # Conditional SSO pane for production
  dynamic "sso_pane" {
    for_each = each.value.sso_enabled && local.is_production ? [1] : []
    content {
      display_name                       = "Corporate SSO - ${each.key}"
      rank                               = var.enrollment_rank + 1
      is_group_enrollment_access_enabled = true
      group_enrollment_access_name       = "All-Employees"
      is_use_jamf_connect                = true
      short_name_attribute               = "sAMAccountName"
      long_name_attribute                = "displayName"
    }
  }
}
```

**💾 Volume Purchasing Program Integration:**

```hcl
# VPP location with environment-specific configuration
resource "jamfpro_volume_purchasing_locations" "corporate" {
  name                                      = "${title(var.jamf_environment)} Apple Business Manager"
  service_token                             = var.vpp_service_token
  automatically_populate_purchased_content  = local.vpp_config.auto_populate
  send_notification_when_no_longer_assigned = local.vpp_config.notifications
  auto_register_managed_users               = local.vpp_config.auto_register
  site_id                                   = "-1"
}
```

### 🔴 Complex Use Cases

**🏗️ Multi-Attribute Extension System:**

```hcl
# Create computer extension attributes from complex variable
resource "jamfpro_computer_extension_attribute" "corporate_attributes" {
  for_each = local.computer_attributes

  name        = "${local.resource_prefix}-${each.key}"
  enabled     = each.value.enabled
  description = "${each.value.description} (${title(var.jamf_environment)})"
  input_type  = each.value.input_type
  inventory_display_type = each.value.inventory_display_type
  data_type   = each.value.data_type

  # Conditional popup choices
  popup_menu_choices = each.value.popup_choices != null ? each.value.popup_choices : null

  # Conditional script contents
  script_contents = each.value.script_contents != null ? each.value.script_contents : null
}

# Create mobile extension attributes
resource "jamfpro_mobile_device_extension_attribute" "device_tracking" {
  for_each = local.mobile_attributes

  name                   = "${local.resource_prefix}-Mobile-${each.key}"
  description            = each.value.description
  data_type              = each.value.data_type
  inventory_display_type = each.value.inventory_display_type
  input_type             = each.value.input_type
  popup_menu_choices     = each.value.popup_choices
}
```

**🔐 Advanced API Integration with Role-Based Access:**

```hcl
# API role for extension attribute management
resource "jamfpro_api_role" "extension_attribute_manager" {
  display_name = "${local.resource_prefix}-ExtAttr-Manager"
  privileges = [
    "Create Computer Extension Attributes",
    "Read Computer Extension Attributes",
    "Update Computer Extension Attributes",
    "Create Mobile Device Extension Attributes",
    "Read Mobile Device Extension Attributes",
    "Update Mobile Device Extension Attributes"
  ]
}

# Advanced API integration with computed scopes
resource "jamfpro_api_integration" "advanced" {
  display_name                  = "${local.resource_prefix}-advanced-integration"
  enabled                       = var.api_integration_enabled && local.is_production
  access_token_lifetime_seconds = local.api_token_lifetime_seconds
  authorization_scopes          = [jamfpro_api_role.extension_attribute_manager.display_name]

  depends_on = [
    jamfpro_computer_extension_attribute.corporate_attributes,
    jamfpro_mobile_device_extension_attribute.device_tracking
  ]
}
```

**🎯 Comprehensive Device Management Integration:**

```hcl
# Local values for complex integration
locals {
  # Compute extension attribute mappings
  extension_attribute_mapping = {
    for name, attr in jamfpro_computer_extension_attribute.corporate_attributes :
    name => {
      id          = attr.id
      name        = attr.name
      input_type  = attr.input_type
      enabled     = attr.enabled
    }
  }

  # Integration configuration
  integration_config = {
    total_computer_attrs = length(jamfpro_computer_extension_attribute.corporate_attributes)
    total_mobile_attrs   = length(jamfpro_mobile_device_extension_attribute.device_tracking)
    total_restrictions   = length(jamfpro_restricted_software.corporate_restrictions)
    api_enabled         = jamfpro_api_integration.advanced.enabled
    laps_enabled        = jamfpro_local_admin_password_settings.corporate.auto_deploy_enabled
    vpp_configured      = jamfpro_volume_purchasing_locations.corporate.id != null
  }
}

# Output comprehensive configuration
output "device_management_summary" {
  description = "Complete device management configuration summary"
  value = {
    environment = var.jamf_environment
    configuration = local.integration_config
    extension_attributes = local.extension_attribute_mapping
    api_integration = {
      id           = jamfpro_api_integration.advanced.id
      display_name = jamfpro_api_integration.advanced.display_name
      enabled      = jamfpro_api_integration.advanced.enabled
    }
    laps_settings = {
      enabled           = jamfpro_local_admin_password_settings.corporate.auto_deploy_enabled
      rotation_hours    = var.password_rotation_hours
      auto_rotate       = jamfpro_local_admin_password_settings.corporate.auto_rotate_enabled
    }
    vpp_location = {
      id   = jamfpro_volume_purchasing_locations.corporate.id
      name = jamfpro_volume_purchasing_locations.corporate.name
    }
    enrollment_customizations = {
      for name, enrollment in jamfpro_enrollment_customization.corporate :
      name => {
        id           = enrollment.id
        display_name = enrollment.display_name
      }
    }
  }
}
```

---

## 🧪 **Lab 1**: Variables - The Very Basics

**Duration**: 10 minutes

Let's start with the absolute basics - what is a variable and how do you create one?

**🎯 What You'll Learn:**

- How to declare a simple variable
- Basic variable types (string, number, bool)
- How variables work without any complexity

**Step 1: Create Your First Variables**

Create a new directory `terraform-variables-basics` and create `variables.tf`:

```hcl
# This is a simple string variable
variable "department_name" {
  description = "Name of the department"
  type        = string
  default     = "Engineering"
}

# This is a simple number variable
variable "team_size" {
  description = "Number of people in the team"
  type        = number
  default     = 5
}

# This is a simple boolean variable
variable "is_active" {
  description = "Whether the department is active"
  type        = bool
  default     = true
}
```

**Step 2: See Your Variables**

Create `main.tf` (we're not creating resources yet, just learning variables):

```hcl
# We'll use locals to show how variables work
locals {
  department_info = "Department: ${var.department_name}"
  team_info       = "Team Size: ${var.team_size}"
  status_info     = "Active: ${var.is_active}"
}
```

**Step 3: Output Your Variables**

Create `outputs.tf`:

```hcl
output "department_name" {
  description = "The department name from our variable"
  value       = var.department_name
}

output "team_size" {
  description = "The team size from our variable"
  value       = var.team_size
}

output "is_active" {
  description = "Whether the department is active"
  value       = var.is_active
}

output "combined_info" {
  description = "All information combined"
  value = {
    department = var.department_name
    size       = var.team_size
    active     = var.is_active
  }
}
```

**Step 4: Test Your First Variables**

```bash
# Initialize (creates .terraform directory)
terraform init

# See what Terraform will do (no resources, just variables)
terraform plan

# Apply to see the outputs
terraform apply

# Try changing a variable value
terraform plan -var='department_name=Sales'
terraform apply -var='department_name=Sales'

# Try changing multiple variables
terraform apply -var='department_name=Marketing' -var='team_size=8' -var='is_active=false'
```

**🎉 Congratulations!** You've learned:

- How to declare variables with `variable "name" { }`
- The three basic types: `string`, `number`, `bool`
- How to reference variables with `var.name`
- How to override variables with `-var`

---

## 🧪 **Lab 2**: Using Variables in Resources

**Duration**: 15 minutes

Now let's use variables to actually create Jamf Pro resources!

**🎯 What You'll Learn:**

- How to use variables in real resources
- String interpolation with `${}`
- How variables make configurations flexible

**Step 1: Add Resource Variables**

Add to your `variables.tf`:

```hcl
# Variables for creating a Jamf Pro extension attribute
variable "attribute_name" {
  description = "Name for the extension attribute"
  type        = string
  default     = "Department"
}

variable "attribute_description" {
  description = "Description for the extension attribute"
  type        = string
  default     = "Employee department"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}
```

**Step 2: Create a Real Resource Using Variables**

Update `main.tf`:

```hcl
# Random suffix for unique naming (required for Jamf Pro)
resource "random_string" "suffix" {
  length  = 6
  upper   = false
  special = false
}

# Create an extension attribute using our variables
resource "jamfpro_computer_extension_attribute" "department" {
  name        = "${var.attribute_name}-${var.environment}-${random_string.suffix.result}"
  enabled     = var.is_active
  description = "${var.attribute_description} for ${var.department_name} team"
  input_type  = "TEXT"
  inventory_display_type = "USER_AND_LOCATION"
  data_type   = "STRING"
}
```

**Step 3: Update Outputs to Show Resource Information**

Update `outputs.tf`:

```hcl
output "extension_attribute_id" {
  description = "ID of the created extension attribute"
  value       = jamfpro_computer_extension_attribute.department.id
}

output "extension_attribute_name" {
  description = "Full name of the extension attribute"
  value       = jamfpro_computer_extension_attribute.department.name
}

output "resource_summary" {
  description = "Summary of what we created"
  value = {
    attribute_id   = jamfpro_computer_extension_attribute.department.id
    attribute_name = jamfpro_computer_extension_attribute.department.name
    department     = var.department_name
    environment    = var.environment
    team_size      = var.team_size
  }
}
```

**Step 4: Test Variables with Real Resources**

```bash
# Plan to see what will be created
terraform plan

# Apply to create the extension attribute
terraform apply

# Try different values
terraform plan -var='department_name=Sales' -var='attribute_name=Department Code'
terraform apply -var='department_name=Sales' -var='attribute_name=Department Code'

# Clean up
terraform destroy
```

**🎉 You've learned:**

- How to use variables in resource arguments
- String interpolation: `"${var.name}"`
- How variables make resources flexible and reusable

---

## 🧪 **Lab 3**: Outputs - Getting Information Back

**Duration**: 10 minutes

Let's master outputs - how to get information from your Terraform resources.

**🎯 What You'll Learn:**

- Different types of outputs
- How to structure output data
- When outputs are useful

**Step 1: Create Multiple Resources**

Update `main.tf` to create more resources:

```hcl
# Create multiple extension attributes
resource "jamfpro_computer_extension_attribute" "department" {
  name        = "Department-${var.environment}-${random_string.suffix.result}"
  enabled     = var.is_active
  description = "Employee department"
  input_type  = "TEXT"
  inventory_display_type = "USER_AND_LOCATION"
  data_type   = "STRING"
}

resource "jamfpro_computer_extension_attribute" "location" {
  name        = "Location-${var.environment}-${random_string.suffix.result}"
  enabled     = var.is_active
  description = "Office location"
  input_type  = "TEXT"
  inventory_display_type = "USER_AND_LOCATION"
  data_type   = "STRING"
}
```

**Step 2: Create Different Types of Outputs**

Replace `outputs.tf`:

```hcl
# Simple value output
output "department_attribute_id" {
  description = "ID of the department extension attribute"
  value       = jamfpro_computer_extension_attribute.department.id
}

# Multiple related values
output "all_attribute_ids" {
  description = "IDs of all extension attributes"
  value = {
    department = jamfpro_computer_extension_attribute.department.id
    location   = jamfpro_computer_extension_attribute.location.id
  }
}

# Computed/calculated output
output "total_attributes_created" {
  description = "Total number of extension attributes created"
  value       = 2
}

# Mixed data output
output "deployment_summary" {
  description = "Complete deployment information"
  value = {
    environment = var.environment
    department  = var.department_name
    attributes = {
      department_id   = jamfpro_computer_extension_attribute.department.id
      department_name = jamfpro_computer_extension_attribute.department.name
      location_id     = jamfpro_computer_extension_attribute.location.id
      location_name   = jamfpro_computer_extension_attribute.location.name
    }
    settings = {
      team_size = var.team_size
      active    = var.is_active
    }
  }
}
```

**Step 3: Test Different Output Types**

```bash
# Apply to create resources
terraform apply

# View all outputs
terraform output

# View a specific output
terraform output department_attribute_id

# View structured output
terraform output deployment_summary

# Output in JSON format (useful for scripts)
terraform output -json deployment_summary
```

**🎉 You've learned:**

- Simple outputs: `value = resource.attribute`
- Structured outputs with maps: `{ key = value }`
- How to view outputs with `terraform output`
- Different output formats (text vs JSON)

---

## 🧪 **Lab 4**: Variable Files - Different Environments

**Duration**: 15 minutes

Learn how to manage different environments with variable files.

**🎯 What You'll Learn:**

- How to create `.tfvars` files
- Managing different environments
- Variable file precedence

**Step 1: Create Environment-Specific Variable Files**

Create `dev.tfvars`:

```hcl
# Development environment settings
department_name      = "Dev Team"
team_size           = 3
is_active           = true
environment         = "dev"
attribute_name      = "Dev Department"
attribute_description = "Development team assignment"
```

Create `staging.tfvars`:

```hcl
# Staging environment settings
department_name      = "Staging Team"
team_size           = 2
is_active           = true
environment         = "staging"
attribute_name      = "Staging Department"
attribute_description = "Staging environment assignment"
```

Create `prod.tfvars`:

```hcl
# Production environment settings
department_name      = "Production Team"
team_size           = 10
is_active           = true
environment         = "prod"
attribute_name      = "Production Department"
attribute_description = "Production environment assignment"
```

**Step 2: Test Different Environments**

```bash
# Clean up previous resources
terraform destroy

# Deploy to dev environment
terraform plan -var-file="dev.tfvars"
terraform apply -var-file="dev.tfvars"

# See what dev created
terraform output deployment_summary

# Switch to staging (destroy dev first)
terraform destroy -var-file="dev.tfvars"
terraform apply -var-file="staging.tfvars"

# Compare staging output
terraform output deployment_summary

# Switch to production
terraform destroy -var-file="staging.tfvars"
terraform apply -var-file="prod.tfvars"

# See production output
terraform output deployment_summary
```

**Step 3: Create a Default terraform.tfvars**

Create `terraform.tfvars` (automatically loaded):

```hcl
# Default values - automatically loaded
department_name      = "Default Team"
team_size           = 5
is_active           = true
environment         = "default"
attribute_name      = "Default Department"
attribute_description = "Default department assignment"
```

**Step 4: Test Variable Precedence**

```bash
# This uses terraform.tfvars automatically
terraform plan

# This overrides terraform.tfvars
terraform plan -var-file="dev.tfvars"

# Command line overrides everything
terraform plan -var-file="dev.tfvars" -var="team_size=99"
```

**🎉 You've learned:**

- `.tfvars` files for environment-specific values
- `terraform.tfvars` is loaded automatically
- `-var-file` to specify which file to use
- Variable precedence: command line > var-file > terraform.tfvars > defaults

---

## 🧪 **Lab 5**: Validation - Making Variables Safer

**Duration**: 15 minutes

Now let's learn how to add validation rules to make variables safer.

**🎯 What You'll Learn:**

- How to add validation rules
- Common validation patterns
- When validation helps prevent mistakes

**Step 1: Add Simple Validation**

Update your `variables.tf` with validation rules:

```hcl
variable "department_name" {
  description = "Name of the department"
  type        = string
  default     = "Engineering"

  # Simple validation - must not be empty
  validation {
    condition     = length(var.department_name) > 0
    error_message = "Department name cannot be empty."
  }
}

variable "team_size" {
  description = "Number of people in the team"
  type        = number
  default     = 5

  # Number range validation
  validation {
    condition     = var.team_size >= 1 && var.team_size <= 100
    error_message = "Team size must be between 1 and 100 people."
  }
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"

  # Must be one of specific values
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be dev, staging, or prod."
  }
}

variable "attribute_name" {
  description = "Name for the extension attribute"
  type        = string
  default     = "Department"

  # Pattern validation with regex
  validation {
    condition     = can(regex("^[A-Za-z0-9 _-]+$", var.attribute_name))
    error_message = "Attribute name can only contain letters, numbers, spaces, hyphens, and underscores."
  }
}
```

**Step 2: Test Validation Rules**

```bash
# These should work fine
terraform plan -var='department_name=Sales'
terraform plan -var='team_size=10'
terraform plan -var='environment=staging'

# These should fail with validation errors
terraform plan -var='department_name='        # Empty string
terraform plan -var='team_size=0'             # Too small
terraform plan -var='team_size=200'           # Too large
terraform plan -var='environment=test'        # Invalid environment
terraform plan -var='attribute_name=Bad@Name' # Invalid characters
```

**🎉 You've learned:**

- Basic validation with `validation { }` blocks
- Length validation: `length(var.name) > 0`
- Range validation: `var.num >= 1 && var.num <= 100`
- Choice validation: `contains(["a", "b"], var.choice)`
- Pattern validation: `can(regex("pattern", var.text))`

---

## 🧪 **Lab 6**: Lists - Working with Collections

**Duration**: 15 minutes

Learn how to work with lists (ordered collections of the same type).

**🎯 What You'll Learn:**

- How to create list variables
- Using lists in resources
- Basic list operations

**Step 1: Create Simple List Variables**

Add to your `variables.tf`:

```hcl
# List of strings - department names
variable "department_list" {
  description = "List of all departments"
  type        = list(string)
  default     = ["Engineering", "Sales", "Marketing"]

  validation {
    condition     = length(var.department_list) >= 1
    error_message = "Must have at least one department."
  }
}

# List of numbers - office floors
variable "office_floors" {
  description = "Floor numbers where teams work"
  type        = list(number)
  default     = [1, 2, 3, 4]
}

# List of locations for popup menus
variable "office_locations" {
  description = "Available office locations"
  type        = list(string)
  default     = ["New York", "San Francisco", "London", "Remote"]
}
```

**Step 2: Use Lists in Resources**

Update `main.tf`:

```hcl
# Create one extension attribute for each department
resource "jamfpro_computer_extension_attribute" "department_attributes" {
  count = length(var.department_list)

  name        = "${var.department_list[count.index]}-Dept-${var.environment}-${random_string.suffix.result}"
  enabled     = true
  description = "Extension attribute for ${var.department_list[count.index]} department"
  input_type  = "TEXT"
  inventory_display_type = "USER_AND_LOCATION"
  data_type   = "STRING"
}

# Create a location picker using the office locations list
resource "jamfpro_computer_extension_attribute" "office_location" {
  name        = "Office-Location-${var.environment}-${random_string.suffix.result}"
  enabled     = true
  description = "Employee office location"
  input_type  = "POPUP"
  popup_menu_choices = var.office_locations
  inventory_display_type = "USER_AND_LOCATION"
  data_type   = "STRING"
}
```

**Step 3: Output List Information**

Add to `outputs.tf`:

```hcl
# Show the original list
output "all_departments" {
  description = "All departments from our list"
  value       = var.department_list
}

# Show list length
output "department_count" {
  description = "Total number of departments"
  value       = length(var.department_list)
}

# Show specific list items
output "first_department" {
  description = "First department in the list"
  value       = var.department_list[0]
}

output "last_department" {
  description = "Last department in the list"
  value       = var.department_list[length(var.department_list) - 1]
}

# Show all created attribute IDs
output "department_attribute_ids" {
  description = "IDs of all department attributes"
  value       = jamfpro_computer_extension_attribute.department_attributes[*].id
}

# Show office locations
output "available_locations" {
  description = "Available office locations"
  value       = var.office_locations
}
```

**Step 4: Test Lists**

```bash
# Apply with default list
terraform apply

# View list outputs
terraform output all_departments
terraform output department_count
terraform output department_attribute_ids

# Test with a custom list
terraform plan -var='department_list=["Finance", "Legal", "HR"]'
terraform apply -var='department_list=["Finance", "Legal", "HR"]'

# Test with different locations
terraform plan -var='office_locations=["Boston", "Austin", "Seattle"]'

# Test validation - this should fail (empty list)
terraform plan -var='department_list=[]'
```

**🎉 You've learned:**

- List variables: `type = list(string)`
- Accessing list items: `var.list[0]`, `var.list[1]`
- List length: `length(var.list)`
- Using lists with `count`: `count = length(var.list)`
- List splat operator: `resource[*].attribute`
- Lists in popup menus: `popup_menu_choices = var.list`

---

## 🧪 **Lab 7**: Maps - Key-Value Pairs

**Duration**: 15 minutes

Learn how to work with maps (key-value collections).

**🎯 What You'll Learn:**

- How to create map variables
- Using maps for lookups
- Maps vs lists - when to use each

**Step 1: Create Simple Map Variables**

Add to your `variables.tf`:

```hcl
# Map of department codes
variable "department_codes" {
  description = "Department name to code mapping"
  type        = map(string)
  default = {
    engineering = "ENG"
    sales       = "SAL"
    marketing   = "MKT"
    support     = "SUP"
  }
}

# Map of team sizes
variable "team_sizes" {
  description = "Team size by department"
  type        = map(number)
  default = {
    engineering = 15
    sales       = 8
    marketing   = 5
    support     = 6
  }
}

# Map of manager names
variable "department_managers" {
  description = "Manager for each department"
  type        = map(string)
  default = {
    engineering = "Alice Johnson"
    sales       = "Bob Smith"
    marketing   = "Carol Davis"
    support     = "David Wilson"
  }
}
```

**Step 2: Use Maps in Resources**

Update `main.tf`:

```hcl
# Create extension attributes using for_each with maps
resource "jamfpro_computer_extension_attribute" "department_codes" {
  for_each = var.department_codes

  name        = "${each.key}-Code-${each.value}-${var.environment}-${random_string.suffix.result}"
  enabled     = true
  description = "Department code for ${each.key}: ${each.value}"
  input_type  = "TEXT"
  inventory_display_type = "USER_AND_LOCATION"
  data_type   = "STRING"
}

# Create manager attributes using map lookups
resource "jamfpro_computer_extension_attribute" "department_info" {
  for_each = var.department_codes

  name        = "${each.key}-Info-${var.environment}-${random_string.suffix.result}"
  enabled     = true
  description = "Department: ${each.key} | Code: ${each.value} | Manager: ${var.department_managers[each.key]} | Team Size: ${var.team_sizes[each.key]}"
  input_type  = "TEXT"
  inventory_display_type = "GENERAL"
  data_type   = "STRING"
}
```

**Step 3: Output Map Information**

Add to `outputs.tf`:

```hcl
# Show the original maps
output "department_codes" {
  description = "All department codes"
  value       = var.department_codes
}

output "team_sizes" {
  description = "Team sizes by department"
  value       = var.team_sizes
}

# Show specific map values
output "engineering_code" {
  description = "Engineering department code"
  value       = var.department_codes["engineering"]
}

output "sales_team_size" {
  description = "Sales team size"
  value       = var.team_sizes["sales"]
}

# Show all map keys
output "all_departments_from_map" {
  description = "All department names from the map"
  value       = keys(var.department_codes)
}

# Show all map values
output "all_codes" {
  description = "All department codes"
  value       = values(var.department_codes)
}

# Show created resources from maps
output "department_code_attributes" {
  description = "Department code attributes created"
  value = {
    for key, attr in jamfpro_computer_extension_attribute.department_codes :
    key => {
      id   = attr.id
      name = attr.name
      code = var.department_codes[key]
    }
  }
}
```

**Step 4: Test Maps**

```bash
# Apply with default maps
terraform apply

# View map outputs
terraform output department_codes
terraform output team_sizes
terraform output all_departments_from_map
terraform output department_code_attributes

# Test with custom maps
terraform plan -var='department_codes={finance="FIN", legal="LEG", hr="HRD"}'

# Test with different team sizes
terraform plan -var='team_sizes={engineering=20, sales=12, marketing=8}'

# Apply with custom values
terraform apply -var='department_codes={finance="FIN", legal="LEG"}' \
                -var='team_sizes={finance=5, legal=3}' \
                -var='department_managers={finance="Eve Brown", legal="Frank Green"}'
```

**🎉 You've learned:**

- Map variables: `type = map(string)` or `type = map(number)`
- Accessing map values: `var.map["key"]` or `var.map[each.key]`
- Using maps with `for_each`: `for_each = var.map`
- Map functions: `keys(var.map)`, `values(var.map)`
- Map iteration: `each.key` and `each.value`
- When to use maps vs lists: Maps for lookups, lists for ordered data

---

## 🧪 **Lab 8**: Locals - Computed Values

**Duration**: 15 minutes

Learn how to use locals for computed values and avoiding repetition.

**🎯 What You'll Learn:**

- What locals are and when to use them
- Computing values from variables
- Avoiding repetition with locals

**Step 1: Create Simple Locals**

Add to `main.tf`:

```hcl
# Local values for computed expressions
locals {
  # Simple computed values
  resource_prefix = "${var.environment}-${random_string.suffix.result}"
  is_production   = var.environment == "prod"

  # Computed from our lists and maps
  total_departments = length(var.department_list)
  total_employees   = sum(values(var.team_sizes))

  # String computations
  organization_name = "ACME Corp"
  full_prefix      = "${local.organization_name}-${local.resource_prefix}"

  # Conditional values
  backup_enabled = local.is_production ? true : false
  retention_days = local.is_production ? 90 : 30
}
```

**Step 2: Use Locals in Resources**

Update your resources to use locals:

```hcl
# Use locals to avoid repetition
resource "jamfpro_computer_extension_attribute" "organization_info" {
  name        = "Org-Info-${local.resource_prefix}"
  enabled     = true
  description = "${local.organization_name} | Environment: ${var.environment} | Production: ${local.is_production} | Total Employees: ${local.total_employees}"
  input_type  = "TEXT"
  inventory_display_type = "GENERAL"
  data_type   = "STRING"
}

resource "jamfpro_computer_extension_attribute" "backup_info" {
  name        = "Backup-Settings-${local.resource_prefix}"
  enabled     = true
  description = "Backup Enabled: ${local.backup_enabled} | Retention: ${local.retention_days} days"
  input_type  = "TEXT"
  inventory_display_type = "GENERAL"
  data_type   = "STRING"
}
```

**Step 3: Output Local Values**

Add to `outputs.tf`:

```hcl
# Show computed local values
output "computed_values" {
  description = "Values computed by locals"
  value = {
    resource_prefix     = local.resource_prefix
    is_production      = local.is_production
    total_departments  = local.total_departments
    total_employees    = local.total_employees
    organization_name  = local.organization_name
    full_prefix       = local.full_prefix
    backup_enabled    = local.backup_enabled
    retention_days    = local.retention_days
  }
}

# Show how locals help avoid repetition
output "organization_summary" {
  description = "Organization summary using locals"
  value = {
    name              = local.organization_name
    environment       = var.environment
    is_production     = local.is_production
    total_departments = local.total_departments
    total_employees   = local.total_employees
    backup_settings = {
      enabled        = local.backup_enabled
      retention_days = local.retention_days
    }
  }
}
```

**Step 4: Test Locals**

```bash
# Apply to see computed values
terraform apply

# View computed values
terraform output computed_values
terraform output organization_summary

# Test with different environment
terraform apply -var='environment=prod'
terraform output computed_values  # Notice how is_production and backup settings change

# Test with different team sizes
terraform apply -var='team_sizes={engineering=25, sales=15, marketing=10}'
terraform output organization_summary  # Notice total_employees changes
```

**🎉 You've learned:**

- Locals compute values once: `locals { name = expression }`
- Reference locals with `local.name` (not `var.name`)
- Locals can use variables, other locals, and functions
- Use locals to avoid repeating complex expressions
- Locals for conditional logic: `condition ? true_value : false_value`
- Locals for calculations: `sum()`, `length()`, string manipulation

---

## 🧪 **Lab 9**: Environment Variables - System-Level Configuration

**Duration**: 15 minutes

Learn how to use system environment variables with Terraform.

**🎯 What You'll Learn:**

- How to use `TF_VAR_*` environment variables
- When environment variables are useful
- Security benefits of environment variables

**Step 1: Understand Environment Variables**

Environment variables starting with `TF_VAR_` automatically become Terraform variables:

- `TF_VAR_environment` becomes `var.environment`
- `TF_VAR_team_size` becomes `var.team_size`
- `TF_VAR_api_token` becomes `var.api_token`

**Step 2: Set Environment Variables**

In your terminal (macOS/Linux):

```bash
# Set basic variables
export TF_VAR_environment="dev"
export TF_VAR_department_name="DevOps"
export TF_VAR_team_size=8

# Set list variables (JSON format)
export TF_VAR_department_list='["DevOps", "Security", "Platform"]'

# Set map variables (JSON format)
export TF_VAR_team_sizes='{"devops": 8, "security": 4, "platform": 6}'
```

For Windows PowerShell:

```powershell
# Set basic variables
$env:TF_VAR_environment = "dev"
$env:TF_VAR_department_name = "DevOps"
$env:TF_VAR_team_size = 8

# Set list variables (JSON format)
$env:TF_VAR_department_list = '["DevOps", "Security", "Platform"]'

# Set map variables (JSON format)
$env:TF_VAR_team_sizes = '{"devops": 8, "security": 4, "platform": 6}'
```

**Step 3: Test Environment Variables**

```bash
# Check what environment variables are set
echo $TF_VAR_environment
echo $TF_VAR_department_name

# Plan using environment variables (no -var needed!)
terraform plan

# Apply using environment variables
terraform apply

# Override environment variables with command line
terraform plan -var='team_size=12'  # This overrides TF_VAR_team_size

# Clear environment variables when done
unset TF_VAR_environment
unset TF_VAR_department_name
unset TF_VAR_team_size
```

**🎉 You've learned:**

- Environment variables: `TF_VAR_name` becomes `var.name`
- Useful for CI/CD pipelines and scripts
- JSON format for complex types: `TF_VAR_list='["a", "b"]'`
- Command line still overrides environment variables
- Scripts can set multiple variables at once

---

## 🧪 **Lab 10**: Sensitive Variables - Handling Secrets Safely

**Duration**: 20 minutes

Learn how to handle sensitive data like API keys and passwords safely.

**🎯 What You'll Learn:**

- How to mark variables as sensitive
- Best practices for handling secrets
- How sensitive variables affect outputs

**Step 1: Create Sensitive Variables**

Add to your `variables.tf`:

```hcl
# Sensitive API credentials
variable "jamf_client_id" {
  description = "Jamf Pro OAuth2 client ID"
  type        = string
  sensitive   = true
  default     = "your-client-id"
}

variable "jamf_client_secret" {
  description = "Jamf Pro OAuth2 client secret"
  type        = string
  sensitive   = true
  default     = "your-client-secret"
}

# Sensitive service token
variable "vpp_service_token" {
  description = "Apple Business Manager VPP service token"
  type        = string
  sensitive   = true
  default     = "sample-base64-encoded-token"

  validation {
    condition     = length(var.vpp_service_token) > 10
    error_message = "VPP service token must be provided."
  }
}
```

**Step 2: Use Sensitive Variables in Resources**

Update `main.tf`:

```hcl
# Extension attribute that references sensitive data indirectly
resource "jamfpro_computer_extension_attribute" "security_info" {
  name        = "Security-Config-${local.resource_prefix}"
  enabled     = true
  description = "Security configuration status (API: ${length(var.jamf_client_id) > 0 ? "configured" : "not configured"})"
  input_type  = "TEXT"
  inventory_display_type = "GENERAL"
  data_type   = "STRING"
}
```

**Step 3: Handle Sensitive Outputs**

Add to `outputs.tf`:

```hcl
# This output will be marked as sensitive automatically
output "api_client_id" {
  description = "API client ID (sensitive)"
  value       = var.jamf_client_id
  sensitive   = true
}

# Safe output - doesn't expose sensitive data
output "security_status" {
  description = "Security configuration status"
  value = {
    vpp_configured = length(var.vpp_service_token) > 10
    api_configured = length(var.jamf_client_id) > 0
  }
}
```

**Step 4: Test Sensitive Variables**

```bash
# Set sensitive variables via environment (recommended)
export TF_VAR_jamf_client_id="real-client-id-123"
export TF_VAR_jamf_client_secret="super-secret-client-secret"
export TF_VAR_vpp_service_token="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9"

# Plan - notice sensitive values are hidden
terraform plan

# Apply
terraform apply

# View outputs - sensitive ones are hidden
terraform output

# View specific sensitive output (still hidden)
terraform output api_client_id

# View non-sensitive status
terraform output security_status

# Clean up sensitive environment variables
unset TF_VAR_jamf_client_id
unset TF_VAR_jamf_client_secret
unset TF_VAR_vpp_service_token
```

**🎉 You've learned:**

- Mark sensitive variables with `sensitive = true`
- Sensitive values are hidden in logs and output
- Use environment variables for secrets in CI/CD
- Never commit sensitive values to version control
- Terraform automatically handles sensitive data propagation

---

## ✅ Module 09 Summary

**🎯 Learning Objectives Achieved:**

- ✅ Mastered **input variables** with progressive complexity from basics to advanced
- ✅ Understood **variable definition files** and environment-specific configurations
- ✅ Implemented **output values** for Jamf Pro resource integration and data retrieval
- ✅ Created **local values** for computed expressions and avoiding repetition
- ✅ Applied **environment variables** for system-level and CI/CD configuration
- ✅ Implemented **sensitive variables** for secure credential handling
- ✅ Understood **variable precedence** and loading order

**🔑 Complete Learning Path Covered:**

- **Lab 1**: Variables - The Very Basics (string, number, bool fundamentals)
- **Lab 2**: Using Variables in Resources (interpolation and resource flexibility)
- **Lab 3**: Outputs - Getting Information Back (simple and structured outputs)
- **Lab 4**: Variable Files - Different Environments (.tfvars and environment management)
- **Lab 5**: Validation - Making Variables Safer (validation rules and patterns)
- **Lab 6**: Lists - Working with Collections (ordered data and iteration)
- **Lab 7**: Maps - Key-Value Pairs (lookups and associations)
- **Lab 8**: Locals - Computed Values (calculations and avoiding repetition)
- **Lab 9**: Environment Variables - System-Level Configuration (TF*VAR*\* usage)
- **Lab 10**: Sensitive Variables - Handling Secrets Safely (security best practices)

**🔑 Key Concepts Mastered:**

- **Variable Types**: string, number, bool, list, map with progressive complexity
- **Validation Rules**: Length, range, pattern, choice validation with real examples
- **Sensitive Variables**: API credentials, tokens with security best practices
- **Variable Files**: Environment-specific configurations for dev/staging/prod
- **Environment Variables**: TF*VAR*\* for CI/CD and system-level configuration
- **Variable Precedence**: Command line > var-file > TF_VAR > .tfvars > defaults
- **Local Values**: Computed expressions, string manipulation, conditional logic

**💼 Professional Skills Developed:**

- **Configuration Management**: Organizing Jamf Pro variables and outputs effectively
- **Security Best Practices**: Handling sensitive API credentials and tokens
- **Infrastructure Integration**: Building upon existing Jamf Pro resources
- **Code Organization**: Structuring configurations for multi-environment deployment
- **Dynamic Configuration**: Creating flexible, reusable Jamf Pro modules

**🏗️ Technical Achievements:**

- Built complete Jamf Pro extension attribute system with validation
- Implemented advanced API integration with role-based access control
- Created dynamic software restriction policies with environment-specific settings
- Developed enrollment customizations with complex branding configurations
- Established patterns for VPP and LAPS integration across environments

**➡️ Next Steps**: Ready to explore **Functions and Expressions** where you'll learn advanced HCL functions for data manipulation, string processing, and complex logic in Jamf Pro configurations!

---

## 🔗 **Next Steps**

Ready to continue your Terraform journey? Proceed to the next module:

**➡️ [Module 11: Meta Arguments](./module_11_meta_arguments.md)**

Master advanced HCL functions and expressions for complex Jamf Pro configurations.

---
