# Section 3 - Advanced Techniques

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

---

## 🎯 Types and Values

Terraform supports **primitive types**, **complex types**, and **structural types** for handling different kinds of data.

### 🔤 Primitive Types

```hcl
# String type
variable "environment" {
  description = "Jamf Pro environment name"
  type        = string
  default     = "development"
}

# Number type (integer)
variable "policy_retry_limit" {
  description = "Number of times a policy can retry"
  type        = number
  default     = 3
}

# Number type (float)
variable "patch_threshold" {
  description = "Minimum compliance percentage for patch policies"
  type        = number
  default     = 95.5
}

# Boolean type
variable "enable_self_service" {
  description = "Enable policy in Self Service"
  type        = bool
  default     = true
}

# Using primitive types with Jamf Pro
resource "jamfpro_policy" "install_chrome" {
  name           = "Install Google Chrome (${var.environment})"
  enabled        = true
  frequency      = "Once per computer"
  retry_attempts = var.policy_retry_limit   # number

  self_service {
    use_for_self_service = var.enable_self_service  # bool
    feature_on_main_page = true
    self_service_display_name = "Install Chrome"
  }

  scope {
    all_computers = var.environment == "production" ? true : false  # string conditional
  }

  # Example of using number/float in a description
  # (not functional in Jamf, just showing variable use)
  notes = "Patch compliance threshold is ${var.patch_threshold}%"
}
```

### 📋 Collection Types

```hcl
# List type - ordered collection
variable "departments" {
  description = "List of departments to apply configuration to"
  type        = list(string)
  default     = ["Engineering", "Marketing", "Finance"]
}

# Set type - unordered unique collection
variable "restricted_apps" {
  description = "Set of restricted applications"
  type        = set(string)
  default     = ["Steam", "Spotify", "Dropbox"]
}

# Map type - key-value pairs
variable "profile_metadata" {
  description = "Map of profile metadata"
  type        = map(string)
  default = {
    Environment = "production"
    Project     = "mac-hardening"
    Owner       = "it-admin-team"
  }
}

# Using collection types with Jamf Pro

# Create one configuration profile per department (list)
resource "jamfpro_configuration_profile" "department_profiles" {
  count  = length(var.departments)  # list length
  name   = "${var.departments[count.index]} - Screen Lock Policy"
  payload = file("profiles/screenlock.mobileconfig")

  scope {
    department = var.departments[count.index]  # list access
  }

  category = var.profile_metadata["Project"]   # map lookup
}

# Restrict multiple applications dynamically (set)
resource "jamfpro_restricted_software" "restricted_apps" {
  for_each = var.restricted_apps  # unique set iteration

  name                = "Block ${each.value}"
  process_name        = "${each.value}.app"
  match_exact_process = true
  send_notification   = true
  kill_process        = true
}
```

### 🏗️ Structural Types

```hcl
# Object type - structured data
variable "profile_config" {
  description = "Configuration profile settings"
  type = object({
    display_name       = string
    category           = string
    enabled            = bool
    distribution_method = string
    level              = string
    removal_disallowed = bool
    scope_all_devices  = bool
  })

  default = {
    display_name        = "Screen Lock Policy"
    category            = "Security"
    enabled             = true
    distribution_method = "InstallAutomatically"
    level               = "ComputerLevel"
    removal_disallowed  = true
    scope_all_devices   = true
  }
}

# Tuple type - ordered collection of different types
variable "policy_specs" {
  description = "Policy specifications [name, retry_limit, frequency, enabled]"
  type        = tuple([string, number, string, bool])
  default     = ["Install Chrome", 3, "Once per computer", true]
}

# Using structural types
resource "jamfpro_configuration_profile" "main" {
  name               = var.profile_config.display_name
  category           = var.profile_config.category
  enabled            = var.profile_config.enabled
  distribution_method = var.profile_config.distribution_method
  level              = var.profile_config.level
  removal_disallowed = var.profile_config.removal_disallowed

  scope {
    all_computers = var.profile_config.scope_all_devices
  }

  payload = file("profiles/screenlock.mobileconfig")
}

# Using tuple
locals {
  policy_name    = var.policy_specs[0]  # string
  retry_limit    = var.policy_specs[1]  # number
  frequency      = var.policy_specs[2]  # string
  policy_enabled = var.policy_specs[3]  # bool
}

resource "jamfpro_policy" "install_app" {
  name           = local.policy_name
  enabled        = local.policy_enabled
  frequency      = local.frequency
  retry_attempts = local.retry_limit

  self_service {
    use_for_self_service     = true
    self_service_display_name = local.policy_name
  }

  scope {
    all_computers = true
  }

  package {
    name = "GoogleChrome.pkg"
  }
}
```

---

## 📝 String Templates

String templates enable **dynamic string construction** with interpolation and conditional logic.

### 🔗 String Interpolation

```hcl
# Basic interpolation
locals {
  project_name = "jamf-demo"
  environment  = "production"
  department   = "Engineering"

  # Simple interpolation
  profile_name = "${local.project_name}-${local.environment}-profile"

  # Complex interpolation with functions
  smart_group_name = "${upper(local.department)}-${lower(local.environment)}-${replace(local.project_name, "-", "_")}"

  # Interpolation with expressions
  policy_name = "${local.project_name}-${local.environment}-${formatdate("YYYY-MM-DD", timestamp())}"
}

# Multi-line string with interpolation (example config documentation file)
resource "local_file" "config" {
  filename = "jamf-config.yaml"
  content = <<-EOT
    jamfpro:
      project: ${local.project_name}
      environment: ${local.environment}
      department: ${local.department}
      profile_name: ${local.profile_name}
      policy_name: ${local.policy_name}
      version: ${var.config_version}
  EOT
}

# Interpolation in resource arguments
resource "jamfpro_policy" "install_app" {
  count = 3

  name      = "${local.project_name}-Install-App-${count.index + 1}"
  enabled   = true
  frequency = "Once per computer"

  self_service {
    use_for_self_service      = true
    self_service_display_name = "${local.project_name} App ${count.index + 1}"
  }

  scope {
    all_computers = false
    computer_group = "${local.smart_group_name}-${count.index + 1}"
  }

  package {
    name = "App-${count.index + 1}.pkg"
  }

  category = "Deployment-${local.environment}"
  notes    = "Generated on ${formatdate("YYYY-MM-DD", timestamp())}"
}
```

### 🎛️ String Directives

```hcl
# Conditional directives
locals {
  environment = "production"
  debug_mode  = false
  features    = ["self_service", "patching", "restrictions"]

  environments = {
    dev = {
      scope_group  = "Test Devices"
      retry_limit  = 1
      self_service = true
    }
    staging = {
      scope_group  = "Staging Devices"
      retry_limit  = 2
      self_service = true
    }
    prod = {
      scope_group  = "All Computers"
      retry_limit  = 5
      self_service = false
    }
  }
}

# Conditional directives inside a Jamf Pro policy
resource "jamfpro_policy" "install_chrome" {
  name     = "Install Chrome - ${local.environment}"
  enabled  = true
  frequency = "Once per computer"

  %{if contains(local.features, "self_service")}
  self_service {
    use_for_self_service      = true
    self_service_display_name = "Install Chrome"
    feature_on_main_page      = true
  }
  %{endif}

  scope {
    %{if local.environment == "production"}
    all_computers = true
    %{else}
    computer_group = local.environments[local.environment].scope_group
    %{endif}
  }

  retry_attempts = local.environments[local.environment].retry_limit

  package {
    name = "GoogleChrome.pkg"
  }

  category = "Applications"
  notes    = "Deployed in ${local.environment} environment"
}

# For directive to generate multiple policies
resource "jamfpro_policy" "utilities" {
  for_each = toset(["Install Zoom", "Install Slack", "Run Inventory"])

  name      = "${each.value} - ${local.environment}"
  enabled   = true
  frequency = each.value == "Run Inventory" ? "Ongoing" : "Once per computer"

  scope {
    all_computers = local.environment == "production" ? true : false
  }

  %{if contains(local.features, "self_service")}
  self_service {
    use_for_self_service      = true
    self_service_display_name = each.value
  }
  %{endif}

  notes = "Generated by Terraform for ${local.environment}"
}
```

---

## 🔢 Operators

Terraform supports **arithmetic**, **comparison**, and **logical operators** for expressions.

### ➕ Arithmetic Operators

```hcl
locals {
  # Basic arithmetic
  base_retry   = 5
  multiplier   = 2

  # Addition and subtraction
  max_retries      = local.base_retry + 3       # 8
  min_retries      = local.base_retry - 1       # 4

  # Multiplication and division
  scaled_retries   = local.base_retry * local.multiplier   # 10
  half_retries     = local.base_retry / 2                  # 2.5

  # Modulo
  remainder = local.base_retry % 3             # 2

  # Complex calculations (storage/quota)
  storage_gb       = var.storage_mb / 1024
  monthly_quota_gb = var.daily_quota_gb * 30

  # CPU-style calculation adapted to Jamf: total devices
  total_devices     = var.group_count * var.devices_per_group
  utilization_ratio = (local.total_devices / var.max_devices) * 100
}

# Using arithmetic in Jamf Pro resource configuration
resource "jamfpro_policy" "install_app" {
  count = local.max_retries

  name      = "Install ExampleApp - Attempt ${count.index + 1}"
  enabled   = true
  frequency = "Once per computer"

  retry_attempts = local.min_retries

  self_service {
    use_for_self_service      = true
    self_service_display_name = "Install ExampleApp"
  }

  scope {
    all_computers = false
    computer_group = "Test Group ${count.index + 1}"
  }

  package {
    name = "ExampleApp.pkg"
  }

  category = "Applications"

  notes = <<EOT
    Storage per device: ${local.storage_gb} GB
    Monthly quota: ${local.monthly_quota_gb} GB
    Total devices: ${local.total_devices}
    Utilization: ${local.utilization_ratio}%
  EOT
}
```

### 🔍 Comparison Operators

```hcl
locals {
  environment       = "production"
  policy_attempts   = 5
  cpu_threshold     = 80
  memory_gb         = 16

  # Equality and inequality
  is_production     = local.environment == "production"      # true
  not_dev           = local.environment != "development"     # true

  # Numerical comparisons
  high_retry_count  = local.policy_attempts > 3             # true
  low_retry_count   = local.policy_attempts < 10            # true
  meets_minimum     = local.policy_attempts >= 5            # true
  under_maximum     = local.policy_attempts <= 20           # true

  # Complex comparisons
  needs_stronger_scope = local.cpu_threshold > 75 && local.memory_gb < 32
  is_enterprise_policy = local.policy_attempts >= 10 || local.memory_gb >= 64
}

# Using comparisons in conditionals
resource "jamfpro_policy" "deploy_app" {
  name      = "Deploy ExampleApp"
  enabled   = true
  frequency = local.is_production ? "Once per computer" : "Recurring"

  retry_attempts = local.high_retry_count ? 10 : 3

  self_service {
    use_for_self_service      = true
    self_service_display_name = "Install ExampleApp"
  }

  scope {
    all_computers = local.needs_stronger_scope ? true : false
    computer_group = local.is_enterprise_policy ? "Enterprise Group" : "Standard Group"
  }

  package {
    name = "ExampleApp.pkg"
  }

  category = local.is_enterprise_policy ? "Enterprise Apps" : "Applications"

  notes = <<EOT
    Environment: ${local.environment}
    Retry Attempts: ${local.policy_attempts}
    CPU Threshold: ${local.cpu_threshold}%
    Memory: ${local.memory_gb} GB
    Needs stronger scope? ${local.needs_stronger_scope}
    Enterprise policy? ${local.is_enterprise_policy}
  EOT
}
```

### 🧠 Logical Operators

```hcl
locals {
  environment       = "production"
  enable_backup     = true
  enable_monitoring = true
  device_count      = 5
  region            = "us-west-2"

  # AND operator
  production_ready  = local.environment == "production" && local.enable_backup
  fully_monitored   = local.enable_monitoring && local.device_count > 1

  # OR operator
  needs_backup      = local.environment == "production" || local.device_count > 3
  multi_region      = local.region == "us-west-2" || local.region == "us-east-1"

  # NOT operator
  not_development   = !startswith(local.environment, "dev")
  backup_disabled   = !local.enable_backup

  # Complex logical expressions
  high_availability = (
    local.environment == "production" &&
    local.device_count >= 3 &&
    local.enable_monitoring
  )

  cost_optimized = (
    local.environment != "production" ||
    (local.device_count <= 5 && !local.enable_backup)
  )
}

# Using logical operators in Jamf Pro policy
resource "jamfpro_policy" "deploy_app" {
  name      = "Deploy ExampleApp"
  enabled   = true
  frequency = local.high_availability ? "Once per computer" : "Recurring"

  retry_attempts = local.needs_backup ? 5 : 2

  scope {
    all_computers  = local.fully_monitored
    computer_group = local.production_ready ? "Production Devices" : "Standard Devices"
  }

  package {
    name = "ExampleApp.pkg"
  }

  category = local.cost_optimized ? "Cost Optimized Apps" : "General Apps"

  self_service {
    use_for_self_service      = true
    self_service_display_name = "Install ExampleApp"
  }

  notes = <<EOT
    Environment: ${local.environment}
    Device Count: ${local.device_count}
    High Availability? ${local.high_availability}
    Fully Monitored? ${local.fully_monitored}
    Production Ready? ${local.production_ready}
    Needs Backup? ${local.needs_backup}
    Cost Optimized? ${local.cost_optimized}
  EOT
}

# Conditional role/policy creation
resource "jamfpro_extension_attribute" "monitoring_enabled" {
  count = local.fully_monitored ? 1 : 0

  name        = "Monitoring Enabled"
  description = "Indicates if monitoring is enabled for high availability devices"
  input_type  = "String"
  value       = local.fully_monitored ? "Yes" : "No"
}
```

---

## ❓ Conditional Expressions

Conditional expressions implement **if/else logic** using the ternary operator pattern.

### 🎯 Basic Conditionals

```hcl
locals {
  environment = "production"
  debug_mode  = false

  # Simple conditionals
  policy_frequency    = local.environment == "production" ? "Once per computer" : "Recurring"
  max_retry_attempts  = local.environment == "production" ? 5 : 2
  backup_enabled      = local.environment == "production" ? true : false

  # String conditionals
  log_level           = local.debug_mode ? "DEBUG" : "INFO"
  domain              = local.environment == "production" ? "example.com" : "dev.example.com"

  # Numeric conditionals
  devices_per_policy  = local.environment == "production" ? 50 : 5
  script_timeout      = local.environment == "production" ? 300 : 60
}

resource "jamfpro_policy" "deploy_app" {
  name      = "Deploy ExampleApp"
  enabled   = true
  frequency = local.policy_frequency
  retry_attempts = local.max_retry_attempts

  scope {
    all_computers  = local.environment == "production" ? true : false
    computer_group = local.environment == "production" ? "Production Devices" : "Dev Devices"
  }

  package {
    name = "ExampleApp.pkg"
  }

  category = local.environment == "production" ? "Production Apps" : "Development Apps"

  self_service {
    use_for_self_service      = true
    self_service_display_name = "Install ExampleApp"
  }

  notes = <<EOT
    Environment: ${local.environment}
    Log Level: ${local.log_level}
    Domain: ${local.domain}
    Devices per policy: ${local.devices_per_policy}
    Script Timeout: ${local.script_timeout} seconds
    Backup Enabled? ${local.backup_enabled ? "Yes" : "No"}
  EOT
}
```

### 🔗 Nested Conditionals

```hcl
locals {
  environment = "staging"
  team_size   = 10

  # Nested conditionals for policy scope
  policy_scope = (
    var.environment == "prod"    ? "All Computers" :
    var.environment == "staging" ? "Staging Computers" :
    "Development Computers"
  )

  # Nested logic for patch management frequency
  patch_frequency = (
    var.environment == "prod"    ? "Weekly" :
    var.environment == "staging" ? "Biweekly" :
    "Monthly"
  )

  # Multi-condition evaluation for monitoring level
  monitoring_level = (
    var.environment == "prod" && local.team_size > 5 ? "Comprehensive" :
    var.environment == "prod"                          ? "Standard" :
    var.environment == "staging"                       ? "Basic" :
    "Minimal"
  )

  # Nested conditionals for configuration profile payload
  security_profile = (
    var.environment == "prod"    ? "High Security" :
    var.environment == "staging" ? "Medium Security" :
    "Low Security"
  )

  # Conditional smart group membership
  smart_group_membership = (
    local.team_size > 10 ? ["IT Team", "Admin Group"] :
    ["IT Team"]
  )
}

# Using nested conditionals in Jamf Pro resources

resource "jamf_policy" "patch_management" {
  name        = "Patch Management"
  enabled     = true
  frequency   = local.patch_frequency
  target_scope = local.policy_scope

  notifications = local.monitoring_level == "Comprehensive" ? true : false
  reboot_required = var.environment == "prod" ? true : false

  tags = {
    Environment     = var.environment
    MonitoringLevel = local.monitoring_level
  }
}

resource "jamf_configuration_profile" "security" {
  name        = "Security Profile"
  description = "Configuration profile applied based on environment"
  payload     = local.security_profile
  scope       = local.policy_scope

  # Conditional enforcement
  enforced = var.environment == "prod" ? true : false
  remediation_action = local.monitoring_level == "Minimal" ? "Notify Only" : "Enforce"
}

resource "jamf_smart_group" "team_groups" {
  name = "Team Smart Group"
  criteria = local.smart_group_membership
}
```

### 📋 Conditionals with Collections

```hcl
locals {
  environment = "production"
  features    = ["auth", "monitoring", "backup"]
  regions     = ["us-west-2", "us-east-1"]

  # Conditional lists: determine scope for policies or profiles
  policy_scope = var.environment == "prod" ? [
    "All Computers",
    "Admin Group",
    "Monitoring Group"
  ] : [
    "Staging Computers"
  ]

  # Conditional maps: tags or metadata for Jamf objects
  policy_tags = var.environment == "prod" ? {
    Environment = "production"
    Backup      = "enabled"
    Monitoring  = "comprehensive"
    Compliance  = "required"
  } : {
    Environment = var.environment
    Backup      = "disabled"
    Monitoring  = "basic"
  }

  # Feature-based conditionals: dynamically create policies or packages
  enabled_policies = [
    "web",
    contains(local.features, "auth")       ? "auth-policy"       : null,
    contains(local.features, "monitoring") ? "monitoring-policy" : null,
    contains(local.features, "backup")     ? "backup-policy"     : null,
  ]

  # Filter out null values
  active_policies = compact(local.enabled_policies)
}

# Using conditionals with for_each to create multiple policies
resource "jamf_policy" "services" {
  for_each = toset(local.active_policies)

  name        = "${each.key}-policy"
  enabled     = true
  target_scope = each.key == "web" ? local.policy_scope : ["Staging Computers"]

  # Conditional enforcement based on policy type
  frequency = each.key == "backup-policy" ? "Daily" : "Weekly"
  notifications = contains(local.features, "monitoring") && each.key == "monitoring-policy" ? true : false

  # Assign dynamic tags / metadata
  tags = merge(local.policy_tags, {
    Service = each.key
  })

  # Example: dynamic scripts (like user_data in AWS)
  script_path = templatefile("${path.module}/scripts/${each.key}.sh", {
    environment = var.environment
    service     = each.key
    features    = join(",", local.features)
  })
}
```

---

## 🔄 For Expressions

For expressions enable **data transformation** and **collection manipulation** with powerful iteration capabilities.

### 📋 List Transformations

```hcl
locals {
  # Source data
  environments = ["dev", "staging", "prod"]
  users        = ["alice", "bob", "charlie", "diana"]

  # Basic list transformations: naming policies per environment
  environment_policies = [
    for env in local.environments : "${var.project}-${env}-policy"
  ]

  # List with conditionals: only staging and production
  active_policies = [
    for env in local.environments : "${var.project}-${env}-policy"
    if env == "prod" || env == "staging"
  ]

  # Numeric transformations: example for port-based policies (if needed)
  https_ports = [
    for port in [80, 443, 8080] : port + 8000
    if port != 80
  ]

  # String transformations: user emails
  user_emails = [
    for user in local.users : "${user}@example.com"
  ]

  # Complex transformations: user configurations
  user_configs = [
    for i, user in local.users : {
      username = user
      user_id  = i + 1000
      email    = "${user}@example.com"
      home_dir = "/Users/${user}"
      groups   = user == "alice" ? ["admin", "staff"] : ["staff"]
    }
  ]
}

# Using transformed lists to create Jamf policies
resource "jamf_policy" "environment_policies" {
  for_each = toset(local.environment_policies)

  name        = each.key
  enabled     = true
  target_scope = ["All Computers"]

  # Example: policy script path based on environment
  script_path = templatefile("${path.module}/scripts/${each.key}.sh", {
    environment = regex("-(\\w+)-policy$", each.key)[0]
  })

  tags = {
    Environment = regex("-(\\w+)-policy$", each.key)[0]
    Purpose     = "environment-management"
  }
}

# Using complex user_configs to create Jamf users
resource "jamf_user" "managed_users" {
  for_each = {
    for config in local.user_configs : config.username => config
  }

  username = each.value.username
  email    = each.value.email
  user_id  = each.value.user_id
  home_dir = each.value.home_dir

  # Assign groups based on conditional logic
  groups = each.value.groups

  # Example tags for tracking
  tags = {
    Email  = each.value.email
    UserID = each.value.user_id
  }
}
```

### 🗺️ Map Transformations

```hcl
locals {
  # Source maps: environments and configuration
  environments = {
    dev = {
      policy_type = "script"
      min_targets = 1
      max_targets = 2
    }
    staging = {
      policy_type = "script"
      min_targets = 2
      max_targets = 4
    }
    prod = {
      policy_type = "script"
      min_targets = 3
      max_targets = 10
    }
  }

  # Transform map values with conditionals
  environment_configs = {
    for env, config in local.environments : env => {
      policy_type     = config.policy_type
      min_targets     = config.min_targets
      max_targets     = config.max_targets
      script_path     = config.policy_type == "script" ? "/scripts/${env}.sh" : null
      backup_enabled  = env == "prod"
    }
  }

  # Filtered environments
  active_configs = {
    for env, config in local.environments : env => config
    if env == "prod" || env == "staging"
  }

  # Map of policy types by environment
  policy_types_by_env = {
    for env, config in local.environments :
    upper(env) => config.policy_type
  }

  # Complex nested map transformations
  detailed_configs = {
    for env, config in local.environments : env => {
      policy_type = config.policy_type
      targets = {
        min = config.min_targets
        max = config.max_targets
        desired = config.min_targets
      }
      features = {
        monitoring  = env == "prod"
        backup      = env != "dev"
        encryption  = env == "prod"
        multi_site  = env == "prod"
      }
      estimated_effort = (
        config.min_targets *
        (config.policy_type == "script" ? 5 : 2)
      )
    }
  }
}

# Using transformed maps to create Jamf policies
resource "jamf_policy" "environment_policies" {
  for_each = local.detailed_configs

  name        = "${each.key}-policy"
  enabled     = true
  target_scope = ["All Computers"]

  # Conditional script assignment
  script_path = each.value.policy_type == "script" ? "/scripts/${each.key}.sh" : null

  monitoring_enabled = each.value.features.monitoring
  backup_enabled     = each.value.features.backup

  tags = {
    Environment     = each.key
    EstimatedEffort = "${each.value.estimated_effort} hours"
    Encryption      = each.value.features.encryption ? "enabled" : "disabled"
  }
}
```

### 🔄 Advanced For Expressions

```hcl
locals {
  # Complex nested data for Jamf applications
  applications = {
    web = {
      environments = ["dev", "staging", "prod"]
      scripts      = ["deploy_web.sh"]
      targets      = { dev = 1, staging = 2, prod = 5 }
    }
    api = {
      environments = ["staging", "prod"]
      scripts      = ["deploy_api.sh"]
      targets      = { staging = 3, prod = 8 }
    }
    worker = {
      environments = ["prod"]
      scripts      = []
      targets      = { prod = 3 }
    }
  }

  # Flatten nested structure for per-environment deployment
  app_instances = flatten([
    for app_name, app_config in local.applications : [
      for env in app_config.environments : {
        app         = app_name
        environment = env
        targets     = app_config.targets[env]
        scripts     = app_config.scripts
        key         = "${app_name}-${env}"
      }
    ]
  ])

  # Convert to map for for_each
  app_instances_map = {
    for instance in local.app_instances : instance.key => instance
  }

  # Group by environment
  instances_by_env = {
    for env in distinct([for instance in local.app_instances : instance.environment]) : env => [
      for instance in local.app_instances : instance if instance.environment == env
    ]
  }

  # Calculate totals
  total_targets = sum([
    for instance in local.app_instances : instance.targets
  ])

  # Environment summaries
  env_summaries = {
    for env, instances in local.instances_by_env : env => {
      total_targets = sum([for instance in instances : instance.targets])
      applications  = length(instances)
      total_scripts = length(distinct(flatten([for instance in instances : instance.scripts])))
    }
  }
}

# Create Jamf policies per application/environment
resource "jamf_policy" "app_instances" {
  for_each = local.app_instances_map

  name        = "${each.value.key}-policy"
  enabled     = true
  target_scope = ["All Computers"]

  # Conditional scripts
  script_path = length(each.value.scripts) > 0 ? each.value.scripts[0] : null

  # Example of conditional deployment logic
  target_count = each.value.targets

  tags = {
    Application = each.value.app
    Environment = each.value.environment
    Targets     = each.value.targets
  }
}

# Outputs for summaries
output "environment_summaries" {
  description = "Summary of targets and applications by environment"
  value       = local.env_summaries
}

output "total_targets" {
  description = "Total number of targets across all environments"
  value       = local.total_targets
}

```

---

## ⭐ Splat Expressions

Splat expressions provide a **concise syntax** for extracting values from collections, serving as shorthand for common for expressions.

### 📋 Basic Splat Operations

```hcl
locals {
  # Sample computer data
  computers = [
    { name = "dev1", ip = "10.0.1.10", type = "mac" },
    { name = "dev2", ip = "10.0.1.11", type = "mac" },
    { name = "ios1", ip = "10.0.2.10", type = "phone" },
    { name = "ios2", ip = "10.0.2.11", type = "phone" }
  ]

  # Splat expressions to extract attributes
  computer_names = local.computers[*].name   # ["dev1", "dev2", "ios1", "ios2"]
  computer_ips   = local.computers[*].ip     # ["10.0.1.10", "10.0.1.11", "10.0.2.10", "10.0.2.11"]
  computer_types = local.computers[*].type   # ["mac", "mac", "phone", "phone"]

  # Equivalent for expressions (more verbose)
  computer_names_verbose = [for c in local.computers : c.name]
  computer_ips_verbose   = [for c in local.computers : c.ip]
}

# Create Jamf policies per computer
resource "jamf_policy" "deploy_scripts" {
  for_each = {
    for comp in local.computers : comp.name => comp
  }

  name        = "${each.value.name}-policy"
  enabled     = true
  target_scope = [each.value.name]  # assign policy to specific computer

  # Conditional script assignment
  script_path = each.value.type == "mac" ? "deploy_mac.sh" : "deploy_phone.sh"

  tags = {
    ComputerName = each.value.name
    Type         = each.value.type
    IPAddress    = each.value.ip
  }
}

# Splat with resource references
output "policy_ids" {
  description = "All Jamf policy IDs"
  value       = values(jamf_policy.deploy_scripts)[*].id
}

output "policy_names" {
  description = "All Jamf policy names"
  value       = values(jamf_policy.deploy_scripts)[*].name
}

```

### 🔄 Advanced Splat Usage

```hcl
locals {
  # Sample Jamf Pro data
  devices = {
    dev = {
      computers = [
        { name = "dev-laptop-01", serial = "ABC123", department = "Engineering" },
        { name = "dev-laptop-02", serial = "ABC124", department = "Design" }
      ]
      policy = { name = "Dev Policy", scope = "All Dev Computers" }
    }
    ios = {
      computers = [
        { name = "ios-ipad-01", serial = "XYZ001", department = "Sales" },
        { name = "ios-ipad-02", serial = "XYZ002", department = "Marketing" },
        { name = "ios-iphone-01", serial = "XYZ003", department = "Support" }
      ]
      policy = { name = "iOS Policy", scope = "All iOS Devices" }
    }
  }

  # Flatten nested structure into individual devices
  jamf_devices = flatten([
    for device_type, device_group in local.devices : [
      for comp in device_group.computers : {
        type       = device_type
        name       = comp.name
        serial     = comp.serial
        department = comp.department
        policy_name = device_group.policy.name
        policy_scope = device_group.policy.scope
        key        = "${device_type}-${comp.serial}"
      }
    ]
  ])

  # Convert flattened devices into map for for_each
  jamf_devices_map = {
    for device in local.jamf_devices : device.key => device
  }

  # Collect all departments
  all_departments = distinct([for d in local.jamf_devices : d.department])
}

# Example: Create Jamf Pro computer records (conceptual resource)
resource "jamf_computer" "devices" {
  for_each = local.jamf_devices_map

  name       = each.value.name
  serial     = each.value.serial
  department = each.value.department
  device_type = each.value.type

  # Assign policy
  policy_name  = each.value.policy_name
  policy_scope = each.value.policy_scope
}

# Output summaries
output "all_device_names" {
  description = "All device names managed in Jamf"
  value       = [for d in local.jamf_devices : d.name]
}

output "all_device_types" {
  description = "All device types"
  value       = distinct([for d in local.jamf_devices : d.type])
}

output "all_departments" {
  description = "All departments represented"
  value       = local.all_departments
}

output "all_policies" {
  description = "All assigned policies"
  value       = distinct([for d in local.jamf_devices : d.policy_name])
}

```

### 🎯 Splat with Conditionals

```hcl
locals {
  # Device configurations in Jamf Pro
  all_devices = [
    { name = "dev-laptop-01", type = "dev", enrolled = true, backup_enabled = false },
    { name = "dev-laptop-02", type = "dev", enrolled = true, backup_enabled = true },
    { name = "db-mac-01", type = "database", enrolled = false, backup_enabled = true },
    { name = "cache-mac-01", type = "cache", enrolled = false, backup_enabled = false },
    { name = "ios-ipad-01", type = "ios", enrolled = true, backup_enabled = true }
  ]

  # Filter enrolled devices
  enrolled_devices = [for device in local.all_devices : device if device.enrolled]
  enrolled_device_names = local.enrolled_devices[*].name

  # Devices with backup enabled
  backup_devices = [for device in local.all_devices : device if device.backup_enabled]
  backup_device_names = local.backup_devices[*].name

  # Group devices by type
  devices_by_type = {
    for t in distinct(local.all_devices[*].type) : t => [
      for device in local.all_devices : device if device.type == t
    ]
  }

  # Extract names by type
  dev_device_names   = local.devices_by_type["dev"][*].name
  database_device_names = local.devices_by_type["database"][*].name
  ios_device_names   = local.devices_by_type["ios"][*].name
}

# Example: Create Jamf Pro device records (conceptual)
resource "jamf_computer" "devices" {
  for_each = local.devices_by_type

  # Iterate through each device in the group
  dynamic "device" {
    for_each = each.value
    content {
      name        = device.value.name
      device_type = device.value.type
      enrolled    = device.value.enrolled
      backup      = device.value.backup_enabled
    }
  }
}

# Outputs using splat expressions
output "jamf_device_summary" {
  description = "Summary of all Jamf-managed devices"
  value = {
    total_devices       = length(local.all_devices)
    enrolled_devices    = local.enrolled_device_names
    backup_enabled      = local.backup_device_names
    dev_devices         = local.dev_device_names
    database_devices    = local.database_device_names
    ios_devices         = local.ios_device_names
    device_types        = distinct(local.all_devices[*].type)
  }
}
```

---

## 🧱 Dynamic Blocks

Dynamic blocks enable **programmatic generation** of nested configuration blocks, making configurations more flexible and maintainable.

### 🔧 Basic Dynamic Blocks

```hcl
# Traditional static configuration (repetitive)
resource "jamf_policy" "dev_static" {
  name        = "dev-static-policy"
  target_type = "computers"

  # Static scope assignments
  scope = [
    "dev-laptop-01",
    "dev-laptop-02"
  ]

  # Static configuration: repetitive
  scripts = [
    { name = "Install Xcode", priority = "high" },
    { name = "Install Homebrew", priority = "medium" },
    { name = "Enable FileVault", priority = "high" }
  ]
}

# Dynamic configuration (flexible)
locals {
  policy_rules = [
    { script_name = "Install Xcode", priority = "high", description = "Dev tools" },
    { script_name = "Install Homebrew", priority = "medium", description = "Package manager" },
    { script_name = "Enable FileVault", priority = "high", description = "Encrypt disk" }
  ]

  target_devices = [
    "dev-laptop-01",
    "dev-laptop-02"
  ]
}

resource "jamf_policy" "dev_dynamic" {
  name        = "dev-dynamic-policy"
  target_type = "computers"

  # Assign dynamically to all target devices
  scope = local.target_devices

  # Use dynamic block to iterate over scripts
  dynamic "script" {
    for_each = local.policy_rules
    content {
      name     = script.value.script_name
      priority = script.value.priority
      note     = script.value.description
    }
  }

  # Tags / metadata
  tags = {
    Name      = "dev-dynamic-policy"
    ScriptCount = length(local.policy_rules)
  }
}
```

### 🎛️ Complex Dynamic Blocks

```hcl
locals {
  # Environment-specific configurations
  environments = {
    dev = {
      scripts = [
        { name = "Install Xcode", priority = "high", description = "Dev tools" },
        { name = "Install Homebrew", priority = "medium", description = "Package manager" }
      ]
      monitoring_enabled = false
    }
    staging = {
      scripts = [
        { name = "Install Xcode", priority = "high", description = "Dev tools" },
        { name = "Install Homebrew", priority = "medium", description = "Package manager" },
        { name = "Enable VPN", priority = "high", description = "Secure access" }
      ]
      monitoring_enabled = true
    }
    prod = {
      scripts = [
        { name = "Install Xcode", priority = "high", description = "Dev tools" },
        { name = "Install Homebrew", priority = "medium", description = "Package manager" },
        { name = "Enable VPN", priority = "high", description = "Secure access" },
        { name = "Enable Disk Encryption", priority = "high", description = "Security" }
      ]
      monitoring_enabled = true
    }
  }
}

# Create Jamf policies dynamically per environment
resource "jamf_policy" "env_policies" {
  for_each = local.environments

  name        = "${each.key}-policy"
  target_type = "computers"

  # Assign scripts dynamically
  dynamic "script" {
    for_each = each.value.scripts
    content {
      name     = script.value.name
      priority = script.value.priority
      note     = script.value.description
    }
  }

  # Optional monitoring assignment
  monitoring_enabled = each.value.monitoring_enabled

  # Tags / metadata
  tags = {
    Name          = "${each.key}-policy"
    ScriptCount   = length(each.value.scripts)
    Monitoring    = each.value.monitoring_enabled ? "enabled" : "disabled"
  }
}

# Output summary using splat expressions
output "environment_policies_summary" {
  description = "Summary of Jamf policies per environment"
  value = {
    dev     = jamf_policy.env_policies["dev"].tags
    staging = jamf_policy.env_policies["staging"].tags
    prod    = jamf_policy.env_policies["prod"].tags
  }
}

```

### 🔄 Nested Dynamic Blocks

```hcl
locals {
  # Complex application configuration mapped to Jamf
  applications = {
    web = {
      environments = ["dev", "staging", "prod"]
      policies = [
        { name = "Install Web App", priority = "high", description = "Deploy web application" },
        { name = "Configure Proxy", priority = "medium", description = "Setup proxy settings" }
      ]
      monitoring_enabled = true
    }
    api = {
      environments = ["staging", "prod"]
      policies = [
        { name = "Install API App", priority = "high", description = "Deploy API service" },
        { name = "Enable Firewall Rules", priority = "high", description = "Secure API ports" }
      ]
      monitoring_enabled = true
    }
  }
}

# Jamf policies for each application
resource "jamf_policy" "app" {
  for_each = local.applications

  name        = "${each.key}-policy"
  target_type = "computers"

  # Dynamic assignment of scripts/policies
  dynamic "script" {
    for_each = each.value.policies
    content {
      name     = script.value.name
      priority = script.value.priority
      note     = script.value.description
    }
  }

  # Monitoring assignment
  monitoring_enabled = each.value.monitoring_enabled

  # Tags / metadata
  tags = {
    Name        = "${each.key}-policy"
    Environment = join(",", each.value.environments)
    PolicyCount = length(each.value.policies)
    Monitoring  = each.value.monitoring_enabled ? "enabled" : "disabled"
  }
}

# Device groups per environment (simulating target groups / ASG)
resource "jamf_device_group" "app_env_group" {
  for_each = {
    for app_name, app in local.applications :
    app_name => app.environments
  }

  name        = "${each.key}-devices"
  description = "Devices for ${each.key} application"

  # Assign devices dynamically (simulated)
  dynamic "device" {
    for_each = each.value
    content {
      name = "device-in-${device.value}"
    }
  }

  # Tags
  tags = {
    Application = each.key
    Environments = join(",", each.value)
  }
}

# Assign policies to device groups dynamically
resource "jamf_policy_assignment" "app_to_group" {
  for_each = local.applications

  policy_id       = jamf_policy.app[each.key].id
  device_group_id = jamf_device_group.app_env_group[each.key].
}
```

---

## Jamf Dynamic Resource Management – Exercises

### Table of Contents

1. [Dynamic Policies](#dynamic-policies)
2. [Environment-Specific Device Groups](#environment-specific-device-groups)
3. [Scripts with Dynamic Parameters](#scripts-with-dynamic-parameters)
4. [Configuration Profiles & Conditional Settings](#configuration-profiles--conditional-settings)
5. [Combined Dynamic Management](#combined-dynamic-management)
6. [Bonus Challenge](#bonus-challenge)

---

### 1. Dynamic Policies

**Concept:** Use locals and dynamic blocks to reduce repetition when creating Jamf policies across multiple apps or environments.

**Example Concept:**

```hcl
locals {
  policies = [
    { name = "Install Antivirus", triggers = ["Recurring Check-in"], enabled = true },
    { name = "Update Chrome", triggers = ["Login"], enabled = true }
  ]
}

resource "jamf_policy" "dynamic" {
  dynamic "policy" {
    for_each = local.policies
    content {
      name    = policy.value.name
      triggers = policy.value.triggers
      enabled = policy.value.enabled
    }
  }
}
```

**Exercises:**

1. Create dynamic policies for `web` and `api` applications with different triggers (`Login`, `Recurring Check-in`, `Custom Event`).
2. Add an optional field for `priority` that only exists for production policies.
3. Create dynamic scripts within each policy to run pre- and post-installation tasks.

---

### 2. Environment-Specific Device Groups

**Concept:** Use nested maps in locals to define device groups for different environments (Dev, Staging, Prod).

**Example Concept:**

```hcl
locals {
  environments = {
    dev     = { description = "Development devices", os_min = "12.0" }
    staging = { description = "Staging devices", os_min = "12.5" }
    prod    = { description = "Production devices", os_min = "13.0" }
  }
}

resource "jamf_device_group" "env_groups" {
  for_each = local.environments

  name        = "${each.key}-devices"
  description = each.value.description
  os_min      = each.value.os_min
}
```

**Exercises:**

1. Create device groups for `web-dev`, `web-staging`, `web-prod`.
2. Add dynamic smart group criteria based on OS version or installed software.
3. Combine device groups with dynamic policies to automatically assign policies per environment.

---

### 3. Scripts with Dynamic Parameters

**Concept:** Use dynamic blocks to define scripts for multiple policies or devices.

**Example Concept:**

```hcl
locals {
  scripts = [
    { name = "Cleanup Temp Files", priority = 1, targets = ["dev", "staging"] },
    { name = "Install Security Patch", priority = 2, targets = ["prod"] }
  ]
}

resource "jamf_script" "dynamic" {
  for_each = local.scripts

  name     = each.value.name
  priority = each.value.priority
  targets  = each.value.targets
}
```

**Exercises:**

1. Define three scripts with different priorities for `web`, `api`, and `db` applications.
2. Make script assignment dynamic so that `prod` only receives critical security patches.
3. Add optional parameters like `timeout` or `logging` that are only included if defined.

---

### 4. Configuration Profiles & Conditional Settings

**Concept:** Use dynamic blocks to define configuration profiles for devices, with optional fields depending on environment.

**Example Concept:**

```hcl
locals {
  profiles = {
    dev = { wifi = "Dev_WiFi", vpn = null }
    prod = { wifi = "Corp_WiFi", vpn = "Corp_VPN" }
  }
}

resource "jamf_configuration_profile" "device_profiles" {
  for_each = local.profiles

  name  = "${each.key}-profile"

  dynamic "wifi_settings" {
    for_each = each.value.wifi != null ? [each.value.wifi] : []
    content {
      ssid = wifi_settings.value
      security_type = "WPA2"
    }
  }

  dynamic "vpn_settings" {
    for_each = each.value.vpn != null ? [each.value.vpn] : []
    content {
      vpn_name = vpn_settings.value
      type     = "IKEv2"
    }
  }
}
```

**Exercises:**

1. Create dynamic profiles for Dev, Staging, and Prod with different WiFi and VPN settings.
2. Add dynamic restrictions that are only applied to Prod devices.
3. Include a dynamic email configuration block that only applies if `each.value.email_config` is defined.

---

### 5. Combined Dynamic Management

**Concept:** Combine policies, scripts, device groups, and profiles using locals and dynamic blocks for full automation.

**Exercises:**

1. Define `web` and `api` applications, each with dev, staging, and prod device groups.
2. Create policies that dynamically assign scripts and configuration profiles based on environment.
3. Implement conditional monitoring or logging in scripts, only enabled for `prod`.
4. Add dynamic tags to all resources for tracking by application and environment.

---

### Bonus Challenge

- Build a Jamf setup where:
  - Every environment automatically gets its device group and policies.
  - Scripts are assigned dynamically with conditional parameters.
  - Profiles include optional WiFi, VPN, and email settings depending on environment.
  - Tags and logging are fully automated for easy tracking.

**🔍 What This Exercise Demonstrates:**

1. **Types and Values**: Complex object and collection type handling
2. **String Templates**: Dynamic string construction with conditionals
3. **Operators**: Mathematical, comparison, and logical operations
4. **Conditional Expressions**: Nested ternary operators and feature flags
5. **For Expressions**: Data transformation and filtering
6. **Splat Expressions**: Efficient collection value extraction
7. **Dynamic Blocks**: Programmatic resource configuration

💡 **Pro Tip**: Expressions are the heart of Terraform's flexibility. Master them to create highly dynamic and maintainable infrastructure configurations!

---

## ✅ Module 9 Summary

**🎯 Learning Objectives Achieved:**

- ✅ Mastered **Terraform data types** including primitives, collections, and structural types
- ✅ Created **dynamic string templates** with interpolation and conditional directives
- ✅ Implemented **conditional logic** using ternary operators and complex nested conditions
- ✅ Built **complex transformations** with for expressions and data manipulation
- ✅ Simplified **iterations** using splat expressions for efficient value extraction
- ✅ Generated **dynamic configurations** with dynamic blocks and programmatic resource creation
- ✅ Applied **mathematical and logical operators** for complex calculations and comparisons

**🔑 Key Concepts Covered:**

- **Data Types**: Primitive (string, number, bool), Collection (list, set, map), Structural (object, tuple)
- **String Templates**: Interpolation with `${}`, conditional directives with `%{if}`, iteration with `%{for}`
- **Operators**: Arithmetic (+, -, \*, /, %), Comparison (==, !=, <, >, <=, >=), Logical (&&, ||, !)
- **Conditional Expressions**: Ternary operators, nested conditionals, feature-based conditions
- **For Expressions**: List transformations, map transformations, filtering, complex nested operations
- **Splat Expressions**: Collection value extraction, nested attribute access, filtering patterns
- **Dynamic Blocks**: Programmatic block generation, conditional block creation, nested dynamic structures

**💼 Professional Skills Developed:**

- **Advanced Configuration Management**: Creating flexible, data-driven infrastructure configurations
- **Template Engineering**: Building dynamic templates with conditional logic and iteration
- **Data Transformation**: Converting and manipulating complex data structures efficiently
- **Pattern Recognition**: Identifying when to use different expression types for optimal solutions
- **Code Optimization**: Writing maintainable and performant Terraform configurations
- **Complex Logic Implementation**: Handling sophisticated business requirements in infrastructure code

**🏗️ Technical Achievements:**

- Built comprehensive multi-environment application with all expression types
- Implemented dynamic security groups with conditional rules based on environment
- Created complex data transformations with nested for expressions and filtering
- Developed template-based user data scripts with conditional feature installation
- Established patterns for cost calculation, resource scaling, and feature management
- Demonstrated advanced splat usage for efficient collection manipulation

**🧮 Advanced Expression Patterns Mastered:**

- **Conditional Resource Creation**: Using expressions to control resource deployment
- **Dynamic Configuration Generation**: Template-based configuration file creation
- **Complex Data Structures**: Multi-level nested objects with computed values
- **Cost Estimation**: Mathematical expressions for infrastructure cost calculations
- **Feature Flag Implementation**: Boolean logic for conditional feature enablement
- **Multi-Environment Scaling**: Expression-based scaling policies across environments

**🎨 Expression Best Practices:**

- **Readability**: Breaking complex expressions into manageable local values
- **Performance**: Using splat expressions for efficient collection operations
- **Maintainability**: Organizing expressions logically with clear naming conventions
- **Flexibility**: Creating reusable expression patterns for common operations
- **Documentation**: Using descriptive variable names and comments for complex logic

**➡️ Next Steps**: Ready to explore **Terraform State Management** where you'll learn about state files, state commands, and state best practices!

---

---

## 🔗 **Next Steps**

Ready to continue your Terraform journey? Proceed to the next module:

**➡️ [Module 12: Terraform State](./module_12_terraform_state.md)**

Master state management, the foundation of Terraform operations.

---
