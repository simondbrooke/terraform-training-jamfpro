# 🔧 Module 09: Meta Arguments
*Duration: 2 hours | Labs: 3* | Difficulty: 🟡 Intermediate*
---

**⏱️ Duration**: 60 minutes  
**🎯 Difficulty**: Intermediate  
**📋 Prerequisites**: Completed Modules 1-8

## 🎯 Learning Objectives

By the end of this module, you will be able to:

- ✅ **Control resource dependencies** using `depends_on` for explicit ordering
- ✅ **Create multiple resource instances** using `count` and `for_each`
- ✅ **Manage resource lifecycles** with lifecycle blocks and rules
- ✅ **Configure provider aliases** for multi-environment deployments
- ✅ **Implement advanced resource patterns** for complex Jamf Pro infrastructure scenarios
- ✅ **Debug and troubleshoot** meta argument configurations effectively

---

## 📚 What Are Meta Arguments?

**Meta arguments** are special arguments available to **all resource types** that control how Terraform manages resources. They modify resource behavior beyond the resource's own configuration.

**🔧 Available Meta Arguments:**
- **`depends_on`** - Explicit dependencies
- **`count`** - Multiple instances with numeric indexing
- **`for_each`** - Multiple instances with key-value mapping
- **`provider`** - Non-default provider selection
- **`lifecycle`** - Resource lifecycle management

```hcl
# Meta arguments example with Jamf Pro
resource "jamfpro_policy" "security_baseline" {
  # Regular resource arguments
  name     = "Security Baseline Policy"
  enabled  = true
  category_id = jamfpro_category.security.id
  
  # Meta arguments
  count      = 3                              # Create 3 policies for different environments
  depends_on = [jamfpro_smart_computer_group.targets]  # Wait for target groups
  provider   = jamfpro.production             # Use specific provider
  
  lifecycle {
    create_before_destroy = true              # Lifecycle rule
  }
  
  scope {
    computer_group_ids = [jamfpro_smart_computer_group.targets[count.index].id]
  }
}
```

---

## 🔗 depends_on: Explicit Dependencies

Terraform automatically handles **implicit dependencies** through resource references, but sometimes you need **explicit control** over resource creation order in Jamf Pro environments.

### 🎯 When to Use depends_on in Jamf Pro

**✅ Use depends_on when:**
- Organizational structure must be created before groups and policies
- Scripts must exist before policies that reference them
- Categories must be available before resources that use them
- Network segments need to be configured before computer groups
- Sites must exist before scoped resources

**❌ Avoid depends_on when:**
- You can use resource attribute references instead
- The dependency is already implicit through resource IDs
- You're trying to work around configuration issues

### 🔧 Basic depends_on Usage with Jamf Pro

```hcl
# Organizational foundation
resource "jamfpro_site" "headquarters" {
  name = "Corporate Headquarters"
}

resource "jamfpro_building" "main_office" {
  name            = "Main Office Building"
  street_address1 = "123 Enterprise Way"
  city            = "San Francisco"
  state_province  = "California"
  zip_postal_code = "94105"
  country         = "United States"
}

resource "jamfpro_department" "it_department" {
  name = "Information Technology"
}

# Network segment with explicit dependency
resource "jamfpro_network_segment" "corporate_network" {
  name             = "Corporate Network Segment"
  starting_address = "10.0.0.1"
  ending_address   = "10.0.0.254"
  building         = jamfpro_building.main_office.name
  department       = jamfpro_department.it_department.name
  
  # Explicit dependency - building and department must exist first
  depends_on = [
    jamfpro_building.main_office,
    jamfpro_department.it_department
  ]
}

# Computer group that depends on multiple organizational resources
resource "jamfpro_smart_computer_group" "corporate_devices" {
  name    = "Corporate Managed Devices"
  site_id = jamfpro_site.headquarters.id
  
  # Multiple explicit dependencies
  depends_on = [
    jamfpro_site.headquarters,
    jamfpro_building.main_office,
    jamfpro_department.it_department,
    jamfpro_network_segment.corporate_network
  ]
  
  criteria {
    name        = "Building"
    priority    = 0
    and_or      = "and"
    search_type = "is"
    value       = jamfpro_building.main_office.name
  }
  
  criteria {
    name        = "Department"
    priority    = 1
    and_or      = "and"
    search_type = "is"
    value       = jamfpro_department.it_department.name
  }
}
```

### 🏗️ Complex Dependencies with Categories and Scripts

```hcl
# Categories must be created first
resource "jamfpro_category" "security" {
  name     = "Security"
  priority = 1
}

resource "jamfpro_category" "maintenance" {
  name     = "Maintenance"
  priority = 2
}

# Scripts that will be used in policies
resource "jamfpro_script" "security_audit" {
  name            = "Security Audit Script"
  script_contents = file("${path.module}/scripts/security_audit.sh")
  category_id     = jamfpro_category.security.id
  os_requirements = "13"
  priority        = "BEFORE"
  
  # Explicit dependency on category
  depends_on = [jamfpro_category.security]
}

resource "jamfpro_script" "system_cleanup" {
  name            = "System Cleanup Script"
  script_contents = file("${path.module}/scripts/cleanup.sh")
  category_id     = jamfpro_category.maintenance.id
  os_requirements = "13"
  priority        = "AFTER"
  
  depends_on = [jamfpro_category.maintenance]
}

# Policy that depends on both scripts and groups
resource "jamfpro_policy" "security_compliance" {
  name        = "Security Compliance Policy"
  enabled     = true
  category_id = jamfpro_category.security.id
  frequency   = "Once per week"
  
  # Wait for all prerequisites
  depends_on = [
    jamfpro_script.security_audit,
    jamfpro_smart_computer_group.corporate_devices,
    jamfpro_category.security
  ]
  
  scope {
    computer_group_ids = [jamfpro_smart_computer_group.corporate_devices.id]
  }
  
  payloads {
    scripts {
      id       = jamfpro_script.security_audit.id
      priority = "Before"
    }
  }
}
```

---

## 🔢 count: Creating Multiple Resources

The **`count`** meta argument creates multiple instances of a resource using **numeric indexing** - perfect for creating multiple environments or similar configurations in Jamf Pro.

### 🎯 Basic count Usage with Jamf Pro

```hcl
# Create multiple departments for different business units
variable "business_units" {
  description = "List of business units"
  type        = list(string)
  default     = ["Engineering", "Sales", "Marketing", "Support"]
}

resource "jamfpro_department" "business_units" {
  count = length(var.business_units)
  name  = var.business_units[count.index]
}

# Create multiple sites for different locations
variable "office_locations" {
  description = "Office locations"
  type        = list(string)
  default     = ["New York", "San Francisco", "London"]
}

resource "jamfpro_site" "offices" {
  count = length(var.office_locations)
  name  = "${var.office_locations[count.index]} Office"
}

# Create computer groups for each department
resource "jamfpro_smart_computer_group" "department_groups" {
  count   = length(var.business_units)
  name    = "${var.business_units[count.index]} Computers"
  site_id = jamfpro_site.offices[0].id  # Use first site as default
  
  criteria {
    name        = "Department"
    priority    = 0
    and_or      = "and"
    search_type = "is"
    value       = jamfpro_department.business_units[count.index].name
  }
}
```

### 🔄 Dynamic count with Environment Variables

```hcl
# variables.tf
variable "environment_count" {
  description = "Number of environments to create"
  type        = number
  default     = 2
  
  validation {
    condition     = var.environment_count >= 1 && var.environment_count <= 5
    error_message = "Environment count must be between 1 and 5."
  }
}

variable "environment_names" {
  description = "Environment names"
  type        = list(string)
  default     = ["development", "staging", "production"]
}

# main.tf
locals {
  # Use the smaller of environment_count or available names
  env_count = min(var.environment_count, length(var.environment_names))
}

# Create categories for each environment
resource "jamfpro_category" "environments" {
  count    = local.env_count
  name     = title(var.environment_names[count.index])
  priority = count.index + 1
}

# Create test policies for each environment
resource "jamfpro_policy" "environment_testing" {
  count       = local.env_count
  name        = "${title(var.environment_names[count.index])} Testing Policy"
  enabled     = var.environment_names[count.index] != "production"  # Disable prod by default
  category_id = jamfpro_category.environments[count.index].id
  frequency   = "Ongoing"
  
  scope {
    all_computers = var.environment_names[count.index] == "development"
  }
  
  payloads {
    maintenance {
      recon = true
    }
  }
}

# Output all policy IDs
output "environment_policy_ids" {
  description = "List of environment policy IDs"
  value       = jamfpro_policy.environment_testing[*].id
}

# Output specific environment policy
output "production_policy_id" {
  description = "Production policy ID"
  value       = length(jamfpro_policy.environment_testing) > 2 ? jamfpro_policy.environment_testing[2].id : null
}
```

### ⚠️ count Limitations and Considerations

```hcl
# ❌ PROBLEM: Removing middle element causes recreation
variable "app_names" {
  default = ["Chrome", "Firefox", "Safari"]
}

resource "jamfpro_mac_application" "browsers" {
  count = length(var.app_names)
  
  name            = var.app_names[count.index]
  deployment_type = "Make Available in Self Service"
  
  scope {
    all_computers = true
  }
}

# If you remove "Firefox", "Safari" becomes "Firefox" and gets recreated!
```

💡 **Pro Tip**: Use `for_each` instead of `count` when dealing with collections that might change, as it uses keys instead of numeric indices!

---

## 🗝️ for_each: Key-Value Resource Creation

The **`for_each`** meta argument creates multiple instances using **keys from a map or set**, providing more stable resource management than `count` - ideal for Jamf Pro configurations.

### 🎯 for_each with Sets for Jamf Pro

```hcl
# Create computer groups for specific operating systems
variable "supported_os_versions" {
  description = "Set of supported macOS versions"
  type        = set(string)
  default     = ["macOS 13", "macOS 14", "macOS 15"]
}

resource "jamfpro_smart_computer_group" "os_groups" {
  for_each = var.supported_os_versions
  
  name = "${each.key} Computers"
  
  criteria {
    name        = "Operating System Version"
    priority    = 0
    and_or      = "and"
    search_type = "like"
    value       = each.key
  }
}

# Create policies for each OS group
resource "jamfpro_policy" "os_maintenance" {
  for_each = var.supported_os_versions
  
  name        = "${each.key} Maintenance Policy"
  enabled     = true
  frequency   = "Once per week"
  category_id = jamfpro_category.maintenance.id
  
  scope {
    computer_group_ids = [jamfpro_smart_computer_group.os_groups[each.key].id]
  }
  
  payloads {
    maintenance {
      recon       = true
      permissions = true
      byhost      = true
    }
  }
}

# Output all OS groups
output "os_groups" {
  value = {
    for os, group in jamfpro_smart_computer_group.os_groups :
    os => {
      id   = group.id
      name = group.name
    }
  }
}
```

### 🗺️ for_each with Complex Maps

```hcl
# Complex application deployment configuration
variable "application_config" {
  description = "Application deployment configurations"
  type = map(object({
    deployment_type = string
    category        = string
    self_service    = bool
    required_for    = list(string)  # List of departments
  }))
  
  default = {
    "Google Chrome" = {
      deployment_type = "Install Automatically"
      category        = "Web Browsers"
      self_service    = false
      required_for    = ["Engineering", "Marketing", "Sales"]
    }
    "Slack" = {
      deployment_type = "Make Available in Self Service"
      category        = "Communication"
      self_service    = true
      required_for    = ["Engineering", "Marketing", "Sales", "IT"]
    }
    "Microsoft Office" = {
      deployment_type = "Make Available in Self Service"
      category        = "Productivity"
      self_service    = true
      required_for    = ["Marketing", "Sales", "Finance"]
    }
  }
}

# Create categories for applications
resource "jamfpro_category" "app_categories" {
  for_each = toset([for app in var.application_config : app.category])
  
  name     = each.key
  priority = 5
}

# Deploy applications with different configurations
resource "jamfpro_mac_application" "enterprise_apps" {
  for_each = var.application_config
  
  name            = each.key
  deployment_type = each.value.deployment_type
  category_id     = jamfpro_category.app_categories[each.value.category].id
  
  scope {
    all_computers = each.value.deployment_type == "Install Automatically"
  }
  
  # Dynamic self service configuration
  dynamic "self_service" {
    for_each = each.value.self_service ? [1] : []
    content {
      install_button_text             = "Install ${each.key}"
      self_service_description        = "Install ${each.key} for enhanced productivity"
      force_users_to_view_description = false
      feature_on_main_page            = contains(["Slack", "Microsoft Office"], each.key)
      notification                    = "Self Service"
    }
  }
}

# Create computer extension attributes for each application
resource "jamfpro_computer_extension_attribute" "app_versions" {
  for_each = var.application_config
  
  name                   = "${each.key} Version"
  enabled                = true
  description            = "Tracks the installed version of ${each.key}"
  input_type             = "SCRIPT"
  inventory_display_type = "GENERAL"
  data_type              = "STRING"
  
  script_contents = templatefile("${path.module}/scripts/check_app_version.sh", {
    app_name = each.key
  })
}
```

### 🔄 for_each with Dynamic Scoping

```hcl
# Department-based configuration
variable "department_config" {
  description = "Department-specific configurations"
  type = map(object({
    building_name = string
    site_id       = number
    restrictions  = list(string)
    required_apps = list(string)
  }))
  
  default = {
    "Engineering" = {
      building_name = "Tech Campus"
      site_id       = 1
      restrictions  = ["Install macOS High Sierra.app", "Torrent clients"]
      required_apps = ["Xcode", "Docker", "Slack"]
    }
    "Marketing" = {
      building_name = "Creative Center"
      site_id       = 2
      restrictions  = ["Gaming applications"]
      required_apps = ["Adobe Creative Suite", "Figma", "Slack"]
    }
    "Finance" = {
      building_name = "Corporate HQ"
      site_id       = 1
      restrictions  = ["Social media apps", "Gaming applications"]
      required_apps = ["Excel", "QuickBooks", "Slack"]
    }
  }
}

# Create smart groups for each department
resource "jamfpro_smart_computer_group" "department_computers" {
  for_each = var.department_config
  
  name    = "${each.key} Computers"
  site_id = each.value.site_id
  
  criteria {
    name        = "Department"
    priority    = 0
    and_or      = "and"
    search_type = "is"
    value       = each.key
  }
  
  criteria {
    name        = "Building"
    priority    = 1
    and_or      = "and"
    search_type = "is"
    value       = each.value.building_name
  }
}

# Create restricted software policies for each department
resource "jamfpro_restricted_software" "department_restrictions" {
  for_each = {
    for dept, config in var.department_config :
    dept => config
    if length(config.restrictions) > 0
  }
  
  name                     = "${each.key} Software Restrictions"
  process_name             = each.value.restrictions[0]  # Use first restriction as example
  match_exact_process_name = false
  send_notification        = true
  kill_process             = true
  delete_executable        = false
  display_message          = "This software is not approved for ${each.key} department use."
  
  scope {
    computer_group_ids = [jamfpro_smart_computer_group.department_computers[each.key].id]
  }
}

# Create policies for required applications
resource "jamfpro_policy" "department_app_policies" {
  for_each = var.department_config
  
  name        = "${each.key} Required Applications"
  enabled     = true
  frequency   = "Ongoing"
  category_id = jamfpro_category.app_categories["Productivity"].id
  
  scope {
    computer_group_ids = [jamfpro_smart_computer_group.department_computers[each.key].id]
  }
  
  self_service {
    use_for_self_service            = true
    self_service_display_name       = "${each.key} App Bundle"
    install_button_text             = "Install Required Apps"
    self_service_description        = "Install applications required for ${each.key} department"
    force_users_to_view_description = true
    feature_on_main_page            = true
  }
}
```

---

## ♻️ lifecycle: Resource Lifecycle Management

The **`lifecycle`** meta argument controls how Terraform manages resource creation, updates, and destruction - critical for production Jamf Pro environments.

### 🔧 Lifecycle Rules for Jamf Pro

```hcl
# Critical security policy with protection
resource "jamfpro_policy" "security_baseline" {
  name        = "Corporate Security Baseline"
  enabled     = true
  frequency   = "Ongoing"
  category_id = jamfpro_category.security.id
  
  lifecycle {
    # Create new policy before destroying old one for zero downtime
    create_before_destroy = true
    
    # Prevent accidental deletion of critical security policy
    prevent_destroy = true
    
    # Ignore changes to certain fields that might be managed externally
    ignore_changes = [
      scope.computer_ids,        # Computer assignments might change frequently
      payloads.maintenance,      # Maintenance settings might be adjusted
    ]
  }
  
  scope {
    all_computers = true
  }
  
  payloads {
    maintenance {
      recon       = true
      permissions = true
      byhost      = true
      system_cache = true
      user_cache   = true
    }
  }
}

# Configuration profile with careful lifecycle management
resource "jamfpro_macos_configuration_profile_plist" "security_profile" {
  name                = "Corporate Security Configuration"
  description         = "Mandatory security settings for all corporate devices"
  level               = "System"
  distribution_method = "Install Automatically"
  payloads            = file("${path.module}/profiles/security.mobileconfig")
  user_removable      = false
  
  lifecycle {
    # Always create new profile before removing old one
    create_before_destroy = true
    
    # Don't accidentally destroy security profiles
    prevent_destroy = true
    
    # Ignore payload changes if managed through external tools
    ignore_changes = [
      payloads  # Payload might be updated outside Terraform
    ]
  }
  
  scope {
    all_computers = true
  }
}
```

### 🛡️ Advanced Lifecycle Management for Enterprise

```hcl
# Computer prestage enrollment with protection
resource "jamfpro_computer_prestage_enrollment" "corporate_prestage" {
  display_name                          = "Corporate Device Enrollment"
  mandatory                             = true
  mdm_removable                         = false
  support_phone_number                  = "1-800-IT-HELP"
  support_email_address                 = "it-support@company.com"
  department                            = "Information Technology"
  default_prestage                      = true
  enrollment_site_id                    = jamfpro_site.headquarters.id
  keep_existing_site_membership         = false
  keep_existing_location_information    = false
  require_authentication                = true
  authentication_prompt                 = "Welcome to your corporate managed device"
  prevent_activation_lock               = true
  enable_device_based_activation_lock   = false
  device_enrollment_program_instance_id = "1"
  
  lifecycle {
    # Never create before destroy for prestage (could cause enrollment issues)
    create_before_destroy = false
    
    # Protect critical enrollment configuration
    prevent_destroy = true
    
    # Ignore frequently changing fields
    ignore_changes = [
      prestage_installed_profile_ids,  # Profiles might be managed separately
      custom_package_ids,              # Packages might be updated frequently
    ]
  }
  
  skip_setup_items {
    biometric          = false
    terms_of_address   = false
    file_vault         = false
    icloud_diagnostics = true
    diagnostics        = true
    accessibility      = false
    apple_id           = true
    screen_time        = true
    siri               = true
    display_tone       = false
    restore            = false
    appearance         = false
    privacy            = false
    payment            = true
    registration       = false
    tos                = false
    icloud_storage     = true
    location           = false
    intelligence       = true
    welcome            = false
    wallpaper          = false
  }
  
  account_settings {
    payload_configured                           = true
    local_admin_account_enabled                  = true
    admin_username                               = "localadmin"
    admin_password                               = var.local_admin_password
    hidden_admin_account                         = true
    local_user_managed                           = true
    user_account_type                            = "STANDARD"
    prefill_primary_account_info_feature_enabled = true
    prefill_type                                 = "DEVICE_OWNER"
    prevent_prefill_info_from_modification       = false
  }
}

# Application with update management
resource "jamfpro_mac_application" "critical_apps" {
  for_each = toset(["Security Agent", "Compliance Monitor"])
  
  name            = each.key
  deployment_type = "Install Automatically"
  category_id     = jamfpro_category.security.id
  
  scope {
    all_computers = true
  }
  
  lifecycle {
    create_before_destroy = true
    
    # Don't destroy critical security applications
    prevent_destroy = each.key == "Security Agent"
    
    # Ignore version changes (managed by patch management)
    ignore_changes = [
      version
    ]
  }
}
```

---

## 🔄 provider: Multi-Environment Configurations

The **`provider`** meta argument selects a specific provider configuration when you have multiple Jamf Pro instances or environments.

### 🌍 Multi-Environment Jamf Pro Setup

```hcl
# Provider configurations
terraform {
  required_providers {
    jamfpro = {
      source  = "deploymenttheory/jamfpro"
      version = "~> 0.24.0"
    }
  }
}

# Production Jamf Pro instance
provider "jamfpro" {
  jamfpro_instance_fqdn = var.prod_jamf_url
  auth_method           = "oauth2"
  client_id             = var.prod_client_id
  client_secret         = var.prod_client_secret
  
  default_tags = {
    Environment = "production"
    ManagedBy   = "terraform"
  }
}

# Development/Testing Jamf Pro instance
provider "jamfpro" {
  alias = "development"
  
  jamfpro_instance_fqdn = var.dev_jamf_url
  auth_method           = "oauth2"
  client_id             = var.dev_client_id
  client_secret         = var.dev_client_secret
  
  default_tags = {
    Project     = var.project_name
    Environment = "development"
    ManagedBy   = "terraform"
    Purpose     = "testing"
  }
}

# Staging Jamf Pro instance
provider "jamfpro" {
  alias = "staging"
  
  jamfpro_instance_fqdn = var.staging_jamf_url
  auth_method           = "oauth2"
  client_id             = var.staging_client_id
  client_secret         = var.staging_client_secret
  
  default_tags = {
    Environment = "staging"
    ManagedBy   = "terraform"
  }
}

# Resources in production (default provider)
resource "jamfpro_category" "prod_categories" {
  for_each = toset(["Security", "Productivity", "Development"])
  
  name     = each.key
  priority = 5
}

# Resources in development environment
resource "jamfpro_category" "dev_categories" {
  provider = jamfpro.development
  
  for_each = toset(["Testing", "Development", "Experimental"])
  
  name     = each.key
  priority = 10
}

# Resources in staging environment
resource "jamfpro_category" "staging_categories" {
  provider = jamfpro.staging
  
  for_each = toset(["Pre-Production", "Testing", "Validation"])
  
  name     = each.key
  priority = 8
}

# Test policies in development
resource "jamfpro_policy" "dev_testing" {
  provider = jamfpro.development
  
  name        = "Development Testing Policy"
  enabled     = true
  frequency   = "Ongoing"
  category_id = jamfpro_category.dev_categories["Testing"].id
  
  scope {
    all_computers = true
  }
  
  payloads {
    maintenance {
      recon = true
    }
  }
}

# Production policies with staging validation
resource "jamfpro_policy" "prod_deployment" {
  name        = "Production Application Deployment"
  enabled     = true
  frequency   = "Once per computer"
  category_id = jamfpro_category.prod_categories["Productivity"].id
  
  # This policy depends on successful staging validation
  depends_on = [jamfpro_policy.staging_validation]
  
  scope {
    all_computers = false
    computer_group_ids = [jamfpro_smart_computer_group.production_computers.id]
  }
  
  payloads {
    maintenance {
      recon = true
    }
  }
}

# Staging validation policy
resource "jamfpro_policy" "staging_validation" {
  provider = jamfpro.staging
  
  name        = "Staging Validation Policy"
  enabled     = true
  frequency   = "Ongoing"
  category_id = jamfpro_category.staging_categories["Validation"].id
  
  scope {
    all_computers = true
  }
}
```

### 🏢 Multi-Tenant Jamf Pro Setup

```hcl
# Client A Jamf Pro instance
provider "jamfpro" {
  alias = "client_a"
  
  jamfpro_instance_fqdn = var.client_a_jamf_url
  auth_method           = "oauth2"
  client_id             = var.client_a_client_id
  client_secret         = var.client_a_client_secret
  
  default_tags = {
    Client      = "ClientA"
    Environment = var.environment
  }
}

# Client B Jamf Pro instance
provider "jamfpro" {
  alias = "client_b"
  
  jamfpro_instance_fqdn = var.client_b_jamf_url
  auth_method           = "oauth2"
  client_id             = var.client_b_client_id
  client_secret         = var.client_b_client_secret
  
  default_tags = {
    Client      = "ClientB"
    Environment = var.environment
  }
}

# Shared configuration for both clients
locals {
  standard_categories = ["Security", "Productivity", "Utilities"]
  
  standard_apps = {
    "Google Chrome" = {
      deployment_type = "Install Automatically"
      category        = "Productivity"
    }
    "Slack" = {
      deployment_type = "Make Available in Self Service"
      category        = "Productivity"
    }
  }
}

# Deploy standard configuration to Client A
resource "jamfpro_category" "client_a_categories" {
  provider = jamfpro.client_a
  
  for_each = toset(local.standard_categories)
  
  name     = each.key
  priority = 5
}

resource "jamfpro_mac_application" "client_a_apps" {
  provider = jamfpro.client_a
  
  for_each = local.standard_apps
  
  name            = each.key
  deployment_type = each.value.deployment_type
  category_id     = jamfpro_category.client_a_categories[each.value.category].id
  
  scope {
    all_computers = each.value.deployment_type == "Install Automatically"
  }
}

# Deploy standard configuration to Client B
resource "jamfpro_category" "client_b_categories" {
  provider = jamfpro.client_b
  
  for_each = toset(local.standard_categories)
  
  name     = each.key
  priority = 5
}

resource "jamfpro_mac_application" "client_b_apps" {
  provider = jamfpro.client_b
  
  for_each = local.standard_apps
  
  name            = each.key
  deployment_type = each.value.deployment_type
  category_id     = jamfpro_category.client_b_categories[each.value.category].id
  
  scope {
    all_computers = each.value.deployment_type == "Install Automatically"
  }
}

# Client-specific customizations
resource "jamfpro_policy" "client_a_custom" {
  provider = jamfpro.client_a
  
  name        = "Client A Custom Security Policy"
  enabled     = true
  frequency   = "Once per week"
  category_id = jamfpro_category.client_a_categories["Security"].id
  
  scope {
    all_computers = true
  }
}

resource "jamfpro_policy" "client_b_custom" {
  provider = jamfpro.client_b
  
  name        = "Client B Custom Compliance Policy"
  enabled     = true
  frequency   = "Once per day"
  category_id = jamfpro_category.client_b_categories["Security"].id
  
  scope {
    all_computers = true
  }
}
```

---

## 💻 **Progressive Exercises: Learning Meta Arguments Step by Step**

Let's build your understanding of meta arguments progressively, starting with simple concepts and building up to complex enterprise scenarios.

---

### 🗝️ **Exercise 9.1**: Mastering `for_each` - Dynamic Categories and Applications
**Duration**: 15 minutes | **Difficulty**: 🟡 Intermediate

Start with `for_each` to understand key-value resource creation - the most flexible meta argument for Jamf Pro.

**Project Setup:**
```bash
mkdir terraform-jamfpro-foreach
cd terraform-jamfpro-foreach
touch {main,variables,outputs,providers}.tf
```

**providers.tf:**
```hcl
terraform {
  required_providers {
    jamfpro = {
      source  = "deploymenttheory/jamfpro"
      version = "~> 0.24.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.1"
    }
  }
}

provider "jamfpro" {
  jamfpro_instance_fqdn = var.jamfpro_instance_fqdn
  auth_method          = "oauth2"
  client_id            = var.jamfpro_client_id
  client_secret        = var.jamfpro_client_secret
  jamfpro_load_balancer_lock    = true
}

```

**variables.tf:**
```hcl
variable "jamfpro_instance_fqdn" {
  description = "The Jamf Pro instance FQDN"
  type        = string
  default     = "https://your-instance.jamfcloud.com"
}

variable "jamfpro_client_id" {
  description = "The Jamf Pro OAuth2 client ID"
  type        = string
  default     = "your-oauth2-client-id"
}

variable "jamfpro_client_secret" {
  description = "The Jamf Pro OAuth2 client secret"
  type        = string
  default     = "your-oauth2-client-secret"
  sensitive   = true
}

variable "app_categories" {
  description = "Application categories with priorities"
  type = map(object({
    priority    = number
    description = string
  }))
  
  default = {
    "Security" = {
      priority    = 1
      description = "Security and compliance applications"
    }
    "Productivity" = {
      priority    = 2  
      description = "Office and productivity tools"
    }
    "Development" = {
      priority    = 3
      description = "Developer tools and IDEs"
    }
    "Creative" = {
      priority    = 4
      description = "Design and creative applications"
    }
  }
}

variable "standard_applications" {
  description = "Standard enterprise applications"
  type = map(object({
    category        = string
    deployment_type = string
    enabled         = bool
    update_behavior = string
    smart_group_id  = string
    description     = string
    featured        = bool
    app_title_name  = string
  }))
  
  default = {
    "Google Chrome" = {
      category        = "Productivity"
      deployment_type = "SELF_SERVICE"
      enabled         = true
      update_behavior = "AUTOMATIC"
      smart_group_id  = "1"
      description     = "Google Chrome web browser for enhanced productivity"
      featured        = false
      app_title_name  = "Google Chrome"
    }
    "Slack" = {
      category        = "Productivity"
      deployment_type = "SELF_SERVICE"
      enabled         = true
      update_behavior = "AUTOMATIC"
      smart_group_id  = "1"
      description     = "Team communication and collaboration platform"
      featured        = true
      app_title_name  = "Slack"
    }
    "Docker Desktop" = {
      category        = "Development"
      deployment_type = "SELF_SERVICE"
      enabled         = true
      update_behavior = "AUTOMATIC"
      smart_group_id  = "1"
      description     = "Containerization platform for developers"
      featured        = false
      app_title_name  = "Docker Desktop"
    }
    "Adobe Photoshop 2024" = {
      category        = "Creative"
      deployment_type = "SELF_SERVICE"
      enabled         = true
      update_behavior = "AUTOMATIC"
      smart_group_id  = "1"
      description     = "Professional image editing and graphic design software"
      featured        = false
      app_title_name  = "Adobe Photoshop 2024"
    }
  }
}

```

**main.tf:**
```hcl
# Random suffix for unique naming - REQUIRED for Jamf Pro multi-environment testing
# 
# IMPORTANT NOTES for Jamf Pro Terraform exercises:
# 1. Jamf Pro requires globally unique resource names across the entire instance
# 2. Random suffixes prevent naming conflicts when multiple people run the same exercises
# 3. App installer 'app_title_name' must match exactly from the Jamf App Catalog
# 4. Use 'terraform destroy' to clean up resources after testing to avoid conflicts
# 
# This pattern is essential for any Jamf Pro Terraform configuration used in:
# - Training environments
# - Shared sandbox instances  
# - Multi-user development scenarios
resource "random_string" "suffix" {
  length  = 6
  upper   = false
  special = false
}

# Create categories using for_each with complex data
resource "jamfpro_category" "app_categories" {
  for_each = var.app_categories
  
  name     = "${each.key}-${random_string.suffix.result}"
  priority = each.value.priority
}

# Create applications using for_each with jamfpro_app_installer
resource "jamfpro_app_installer" "standard_apps" {
  for_each = var.standard_applications
  
  name            = "${each.key}-${random_string.suffix.result}"
  app_title_name  = each.value.app_title_name
  enabled         = each.value.enabled
  deployment_type = each.value.deployment_type
  update_behavior = each.value.update_behavior
  category_id     = jamfpro_category.app_categories[each.value.category].id
  site_id         = "-1"
  smart_group_id  = each.value.smart_group_id

  install_predefined_config_profiles = false
  trigger_admin_notifications        = false

  notification_settings {
    notification_message  = "A new update is available for ${each.key}"
    notification_interval = 1
    deadline_message      = "Update deadline approaching for ${each.key}"
    deadline              = 1
    quit_delay            = 1
    complete_message      = "${each.key} update completed successfully"
    relaunch              = true
    suppress              = false
  }

  self_service_settings {
    include_in_featured_category   = each.value.featured
    include_in_compliance_category = false
    force_view_description         = true
    description                    = each.value.description

    categories {
      id       = jamfpro_category.app_categories[each.value.category].id
      featured = each.value.featured
    }
  }
}

```

**outputs.tf:**
```hcl
output "categories_created" {
  description = "Categories created with for_each"
  value = {
    for name, category in jamfpro_category.app_categories :
    name => {
      id          = category.id
      name        = category.name
      priority    = category.priority
      description = var.app_categories[name].description
    }
  }
}

output "applications_deployed" {
  description = "Applications deployed with for_each"
  value = {
    for name, app in jamfpro_app_installer.standard_apps :
    name => {
      id              = app.id
      name            = app.name
      deployment_type = app.deployment_type
      category        = var.standard_applications[name].category
      enabled         = var.standard_applications[name].enabled
      featured        = var.standard_applications[name].featured
    }
  }
}

output "for_each_advantages" {
  description = "Key advantages of using for_each"
  value = [
    "✅ Stable resource addressing using keys (not indices)",
    "✅ Easy to add/remove items without affecting others",
    "✅ Clear relationship between input data and resources",
    "✅ Can reference resources by meaningful names"
  ]
}

```

**Test the configuration:**
```bash
# Set your Jamf credentials
export JAMFPRO_INSTANCE_NAME=your-instance
export JAMFPRO_CLIENT_ID=your-client-id  
export JAMFPRO_CLIENT_SECRET=your-client-secret

terraform init
terraform plan
terraform apply
terraform output
```

**💡 Key Learning Points:**
1. `for_each` uses keys from maps or sets, not numeric indices
2. Resources can be referenced by their keys: `jamfpro_category.app_categories["Security"]`
3. Adding/removing items doesn't affect other resources
4. Perfect for related resources where you need stable addressing

---

### 🔢 **Exercise 9.2**: Understanding `count` - Multiple Departments
**Duration**: 10 minutes | **Difficulty**: 🟢 Beginner

Learn when `count` is the right choice for creating multiple similar resources.

**Project Setup:**
```bash
mkdir terraform-jamfpro-count
cd terraform-jamfpro-count
touch {main,variables,outputs,providers}.tf
```

**Copy providers.tf from Exercise 9.1**

**variables.tf:**
```hcl
variable "jamfpro_instance_fqdn" {
  description = "The Jamf Pro instance FQDN"
  type        = string
  default     = "https://your-instance.jamfcloud.com"
}

variable "jamfpro_client_id" {
  description = "The Jamf Pro OAuth2 client ID"
  type        = string
  default     = "your-client-id"
}

variable "jamfpro_client_secret" {
  description = "The Jamf Pro OAuth2 client secret"
  type        = string
  default     = "your-client-secret"
  sensitive   = true
}

variable "departments" {
  description = "List of department names"
  type        = list(string)
  default     = ["Engineering", "Marketing", "Sales", "IT", "Finance"]
}

variable "office_locations" {
  description = "Office locations for sites"
  type        = list(string)
  default     = ["New York", "San Francisco", "London", "Tokyo"]
}

variable "create_test_environments" {
  description = "Number of test environments to create"
  type        = number
  default     = 2
  
  validation {
    condition     = var.create_test_environments >= 0 && var.create_test_environments <= 5
    error_message = "Test environments must be between 0 and 5."
  }
}
```

**providers.tf:**
```hcl
terraform {
  required_providers {
    jamfpro = {
      source  = "deploymenttheory/jamfpro"
      version = "~> 0.24.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.1"
    }
  }
}

provider "jamfpro" {
  jamfpro_instance_fqdn = var.jamfpro_instance_fqdn
  auth_method          = "oauth2"
  client_id            = var.jamfpro_client_id
  client_secret        = var.jamfpro_client_secret
  jamfpro_load_balancer_lock    = true
}

```

**main.tf:**
```hcl
# Random suffix for unique naming - REQUIRED for Jamf Pro multi-environment testing
# 
# IMPORTANT NOTES for Jamf Pro Terraform exercises:
# 1. Jamf Pro requires globally unique resource names across the entire instance
# 2. Random suffixes prevent naming conflicts when multiple people run the same exercises
# 3. Use 'terraform destroy' to clean up resources after testing to avoid conflicts
# 
# This pattern is essential for any Jamf Pro Terraform configuration used in:
# - Training environments
# - Shared sandbox instances  
# - Multi-user development scenarios
resource "random_string" "suffix" {
  length  = 6
  upper   = false
  special = false
}

# Create departments using count - simple list iteration
resource "jamfpro_department" "company_departments" {
  count = length(var.departments)
  name  = "${var.departments[count.index]}-${random_string.suffix.result}"
}

# Create sites using count - perfect for simple lists
resource "jamfpro_site" "office_sites" {
  count = length(var.office_locations)
  name  = "${var.office_locations[count.index]} Office-${random_string.suffix.result}"
}

# Create smart groups for each department using count
resource "jamfpro_smart_computer_group" "department_groups" {
  count   = length(var.departments)
  name    = "${var.departments[count.index]} Computers-${random_string.suffix.result}"
  site_id = jamfpro_site.office_sites[0].id  # Use first site
  
  criteria {
    name        = "Department"
    priority    = 0
    and_or      = "and"
    search_type = "is"
    value       = var.departments[count.index]
  }
}

# Conditional resource creation using count
resource "jamfpro_category" "test_categories" {
  count = var.create_test_environments
  
  name     = "Test Environment ${count.index + 1}-${random_string.suffix.result}"
  priority = 1 + count.index
}

# Create policies for test environments
resource "jamfpro_policy" "test_policies" {
  count = var.create_test_environments
  
  name        = "Test Policy ${count.index + 1}-${random_string.suffix.result}"
  enabled     = true
  frequency   = "Ongoing"
  category_id = jamfpro_category.test_categories[count.index].id
  
  scope {
    all_computers = false
  }
  
  payloads {
    maintenance {
      recon = true
    }
  }
}

```

**outputs.tf:**
```hcl
output "departments_summary" {
  description = "Departments created with count"
  value = {
    total_count = length(jamfpro_department.company_departments)
    departments = {
      for i, dept in jamfpro_department.company_departments :
      var.departments[i] => {
        id    = dept.id
        name  = dept.name
        index = i
      }
    }
  }
}

output "sites_created" {
  description = "Sites created using count"
  value = [
    for i, site in jamfpro_site.office_sites :
    {
      index    = i
      name     = site.name
      location = var.office_locations[i]
      id       = site.id
    }
  ]
}

output "test_environments" {
  description = "Test environments (conditional with count)"
  value = var.create_test_environments > 0 ? {
    count = var.create_test_environments
    categories = [
      for i, cat in jamfpro_category.test_categories :
      {
        name = cat.name
        id   = cat.id
      }
    ]
    policies = [
      for i, policy in jamfpro_policy.test_policies :
      {
        name = policy.name
        id   = policy.id
      }
    ]
  } : null
}

output "count_considerations" {
  description = "Key considerations when using count"
  value = [
    "⚠️ Resources are addressed by index (0, 1, 2...)",
    "⚠️ Adding/removing items can affect other resources",
    "⚠️ Best for simple lists that rarely change",
    "✅ Perfect for conditional resource creation",
    "✅ Good for creating N identical resources",
    "✅ Simpler than for_each for basic scenarios"
  ]
}

output "when_to_use_count" {
  description = "When to use count vs for_each"
  value = {
    use_count = [
      "Simple lists that rarely change",
      "Conditional resource creation (count = var.enabled ? 1 : 0)",
      "Creating N identical resources",
      "When you don't need stable resource addressing"
    ]
    use_for_each = [
      "Complex data structures (maps/sets)",
      "Resources that may be added/removed frequently", 
      "When you need stable resource addressing",
      "When resources reference each other by keys"
    ]
  }
}

```

**Test the configuration:**
```bash
terraform init

# Test with default test environments
terraform plan

# Test with no test environments
terraform plan -var="create_test_environments=0"

# Test with more test environments
terraform plan -var="create_test_environments=4"
```

**💡 Key Learning Points:**
1. `count` is perfect for simple lists and conditional resource creation
2. Use `count.index` to access the current iteration number
3. Resources are addressed by index: `jamfpro_department.company_departments[0]`
4. Great for creating a specific number of similar resources

---

### ⛓️ **Exercise 9.3**: Controlling Dependencies with `depends_on`
**Duration**: 15 minutes | **Difficulty**: 🟡 Intermediate

Master explicit dependency management for proper resource ordering in Jamf Pro.

**Project Setup:**
```bash
mkdir terraform-jamfpro-dependencies
cd terraform-jamfpro-dependencies
touch {main,variables,outputs,providers}.tf scripts/security_audit.sh
```

**Copy providers.tf from previous exercises**

**main.tf:**
```hcl
# Random suffix for unique naming - REQUIRED for Jamf Pro multi-environment testing
# 
# IMPORTANT NOTES for Jamf Pro Terraform exercises:
# 1. Jamf Pro requires globally unique resource names across the entire instance
# 2. Random suffixes prevent naming conflicts when multiple people run the same exercises
# 3. Use 'terraform destroy' to clean up resources after testing to avoid conflicts
# 
# This pattern is essential for any Jamf Pro Terraform configuration used in:
# - Training environments
# - Shared sandbox instances  
# - Multi-user development scenarios
resource "random_string" "suffix" {
  length  = 6
  upper   = false
  special = false
}

# Foundation Layer - Must be created first
resource "jamfpro_site" "headquarters" {
  name = "Corporate Headquarters-${random_string.suffix.result}"
}

resource "jamfpro_building" "main_office" {
  name            = "Main Office Building-${random_string.suffix.result}"
  street_address1 = "123 Enterprise Way"
  city            = "San Francisco"
  state_province  = "California"
  zip_postal_code = "94105"
  country         = "United States"
  
  # No explicit dependency needed - this is independent
}

resource "jamfpro_department" "it_department" {
  name = "Information Technology-${random_string.suffix.result}"
}

# Infrastructure Layer - Depends on foundation
resource "jamfpro_network_segment" "corporate_network" {
  name             = "Corporate Network Segment-${random_string.suffix.result}"
  starting_address = "10.0.0.1"
  ending_address   = "10.0.0.254"
  building         = jamfpro_building.main_office.name
  department       = jamfpro_department.it_department.name
  
  # Explicit dependency - building and department must exist first
  depends_on = [
    jamfpro_building.main_office,
    jamfpro_department.it_department
  ]
}

# Computer group that depends on multiple organizational resources
resource "jamfpro_smart_computer_group" "corporate_devices" {
  name    = "Corporate Managed Devices-${random_string.suffix.result}"
  site_id = jamfpro_site.headquarters.id
  
  criteria {
    name        = "Building"
    priority    = 0
    and_or      = "and"
    search_type = "is"
    value       = jamfpro_building.main_office.name
  }
  
  # Multiple explicit dependencies
  depends_on = [
    jamfpro_site.headquarters,
    jamfpro_building.main_office,
    jamfpro_department.it_department,
    jamfpro_network_segment.corporate_network
  ]
}

# Categories for organization
resource "jamfpro_category" "security" {
  name     = "Security-${random_string.suffix.result}"
  priority = 1
}

resource "jamfpro_category" "maintenance" {
  name     = "Maintenance-${random_string.suffix.result}"
  priority = 2
}

# Scripts that will be used in policies
resource "jamfpro_script" "security_audit" {
  name            = "Security Audit Script-${random_string.suffix.result}"
  script_contents = file("${path.module}/scripts/security_audit.sh")
  category_id     = jamfpro_category.security.id
  os_requirements = "13"
  priority        = "BEFORE"
  
  # Explicit dependency - category must exist first
  depends_on = [jamfpro_category.security]
}

resource "jamfpro_script" "system_cleanup" {
  name            = "System Cleanup Script-${random_string.suffix.result}"
  script_contents = file("${path.module}/scripts/cleanup.sh")
  category_id     = jamfpro_category.maintenance.id
  os_requirements = "13"
  priority        = "AFTER"
  
  depends_on = [jamfpro_category.maintenance]
}

# Policy that depends on both scripts and groups
resource "jamfpro_policy" "security_compliance" {
  name        = "Security Compliance Policy-${random_string.suffix.result}"
  enabled     = true
  category_id = jamfpro_category.security.id
  frequency   = "Once every week"
  
  # Wait for all prerequisites - script, group, and categories
  depends_on = [
    jamfpro_script.security_audit,
    jamfpro_smart_computer_group.corporate_devices,
    jamfpro_category.security
  ]
  
  scope {
    all_computers      = false
    computer_group_ids = [jamfpro_smart_computer_group.corporate_devices.id]
  }
  
  payloads {
    scripts {
      id       = jamfpro_script.security_audit.id
      priority = "Before"
    }
    
    maintenance {
      recon = true
    }
  }
}

```

**variables.tf:**
```hcl
variable "jamfpro_instance_fqdn" {
  description = "The Jamf Pro instance FQDN"
  type        = string
  default     = "https://your-instance.jamfcloud.com"
}

variable "jamfpro_client_id" {
  description = "The Jamf Pro OAuth2 client ID"
  type        = string
  default     = "your-client-id"
}

variable "jamfpro_client_secret" {
  description = "The Jamf Pro OAuth2 client secret"
  type        = string
  default     = "your-client-secret"
  sensitive   = true
}

```

**outputs.tf:**
```hcl
output "dependency_chain" {
  description = "Shows the dependency chain created"
  value = {
    foundation_layer = {
      site       = jamfpro_site.headquarters.name
      building   = jamfpro_building.main_office.name
      department = jamfpro_department.it_department.name
    }
    
    infrastructure_layer = {
      network_segment = jamfpro_network_segment.corporate_network.name
      categories = [
        jamfpro_category.security.name,
        jamfpro_category.maintenance.name
      ]
    }
    
    application_layer = {
      script         = jamfpro_script.security_audit.name
      computer_group = jamfpro_smart_computer_group.corporate_devices.name
    }
    
    policy_layer = {
      security_policy = jamfpro_policy.security_compliance.name
    }
  }
}

output "creation_order" {
  description = "Logical creation order enforced by depends_on"
  value = [
    "1. Foundation: Site, Building, Department (parallel creation)",
    "2. Infrastructure: Network Segment (depends on Building + Department)",
    "3. Categories: Security, Maintenance (parallel creation)",
    "4. Scripts: Security Audit (depends on Security category)",
    "5. Groups: Corporate Devices (depends on all foundation)",
    "6. Policies: Security Compliance (depends on Script + Group + Category)"
  ]
}

output "depends_on_best_practices" {
  description = "Best practices for using depends_on"
  value = {
    when_to_use = [
      "✅ Dependencies not expressed through resource attributes",
      "✅ Ensuring logical ordering for business reasons",
      "✅ Working around provider limitations",
      "✅ Explicit control over creation/destruction order"
    ]
    
    when_not_to_use = [
      "⚠️ Dependencies already expressed in resource attributes",
      "⚠️ Over-constraining parallel resource creation",
      "⚠️ Using it as a workaround for poor resource design"
    ]
    
    alternatives = [
      "🔄 Use resource attribute references when possible",
      "🔄 Consider data sources for external dependencies",
      "🔄 Use implicit dependencies through references"
    ]
  }
}

output "dependency_types" {
  description = "Types of dependencies demonstrated"
  value = {
    implicit_dependencies = [
      "Network Segment references Building and Department names",
      "Script references Category ID",
      "Policy references Script ID and Group ID"
    ]
    
    explicit_dependencies = [
      "Network Segment depends_on Building and Department resources",
      "Computer Group depends_on Site, Building, Department, Network",
      "Scripts depend_on their respective Categories",
      "Policy depends_on Script, Group, and Category"
    ]
    
    mixed_approach = "Combines both implicit (attribute references) and explicit (depends_on) dependencies for complete control"
  }
}

```


**scripts/security_audit.sh:**
```bash
#!/bin/bash
# Basic security audit script for demonstration
echo "Running security compliance check..."

# Check for software updates
softwareupdate -l

# Check FileVault status
fdesetup status

# Check firewall status
/usr/libexec/ApplicationFirewall/socketfilterfw --getglobalstate

echo "Security audit completed"
```

**outputs.tf:**
```hcl
output "dependency_chain" {
  description = "Shows the dependency chain created"
  value = {
    foundation_layer = {
      site       = jamfpro_site.headquarters.name
      building   = jamfpro_building.main_office.name
      department = jamfpro_department.it_department.name
    }
    
    infrastructure_layer = {
      network_segment = jamfpro_network_segment.corporate_network.name
      categories = [
        jamfpro_category.security.name,
        jamfpro_category.maintenance.name
      ]
    }
    
    application_layer = {
      script         = jamfpro_script.security_audit.name
      computer_group = jamfpro_smart_computer_group.corporate_devices.name
    }
    
    policy_layer = {
      security_policy = jamfpro_policy.security_compliance.name
    }
  }
}

output "creation_order" {
  description = "Logical creation order enforced by depends_on"
  value = [
    "1. Foundation: Site, Building, Department (parallel creation)",
    "2. Infrastructure: Network Segment (depends on Building + Department)",
    "3. Categories: Security, Maintenance (parallel creation)",
    "4. Scripts: Security Audit (depends on Security category)",
    "5. Groups: Corporate Devices (depends on all foundation)",
    "6. Policies: Security Compliance (depends on Script + Group + Category)"
  ]
}

output "depends_on_best_practices" {
  description = "Best practices for using depends_on"
  value = {
    when_to_use = [
      "✅ Dependencies not expressed through resource attributes",
      "✅ Ensuring logical ordering for business reasons",
      "✅ Resources have hidden dependencies Terraform can't detect",
      "✅ Working with external systems or APIs"
    ]
    when_to_avoid = [
      "❌ Can use resource.attribute references instead",
      "❌ Dependency is already implicit through resource IDs",
      "❌ Trying to work around configuration problems"
    ]
  }
}
```

**Test the configuration:**
```bash
terraform init
terraform plan

# Notice the dependency chain in the plan output
terraform apply
terraform output
```

**💡 Key Learning Points:**
1. `depends_on` creates explicit dependencies when implicit ones aren't enough
2. Resources in `depends_on` arrays are created in parallel, but all must complete before the dependent resource
3. Use `depends_on` for business logic dependencies beyond technical ones
4. Terraform will show the dependency graph in plan output

---

### 🌍 **Exercise 9.4**: Multi-Environment with `provider`
**Duration**: 15 minutes | **Difficulty**: 🔴 Advanced

Use provider aliases to manage resources across different Jamf Pro environments safely.

**Project Setup:**
```bash
mkdir terraform-jamfpro-providers
cd terraform-jamfpro-providers
touch {main,variables,outputs,providers}.tf
```

**providers.tf:**
```hcl
terraform {
  required_providers {
    jamfpro = {
      source  = "deploymenttheory/jamfpro"
      version = "~> 0.24.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.1"
    }
  }
}

# Production environment (default provider)
provider "jamfpro" {
  jamfpro_instance_fqdn = var.jamfpro_instance_fqdn
  auth_method          = "oauth2"
  client_id            = var.jamfpro_client_id
  client_secret        = var.jamfpro_client_secret
  jamfpro_load_balancer_lock    = true
}

# Development environment with alias
# Note: In a real scenario, this would point to a different Jamf Pro instance
# For demo purposes, using same instance with alias to demonstrate provider usage
provider "jamfpro" {
  alias                = "development"
  jamfpro_instance_fqdn = var.jamfpro_instance_fqdn
  auth_method          = "oauth2"
  client_id            = var.jamfpro_client_id
  client_secret        = var.jamfpro_client_secret
}

# Staging environment with alias
# Note: In production, this would use different credentials and instance
provider "jamfpro" {
  alias                = "staging"
  jamfpro_instance_fqdn = var.jamfpro_instance_fqdn
  auth_method          = "oauth2"
  client_id            = var.jamfpro_client_id
  client_secret        = var.jamfpro_client_secret
}

```

**variables.tf:**
```hcl
variable "jamfpro_instance_fqdn" {
  description = "The Jamf Pro instance FQDN"
  type        = string
  default     = "https://your-instance.jamfcloud.com"
}

variable "jamfpro_client_id" {
  description = "The Jamf Pro OAuth2 client ID"
  type        = string
  default     = "your-client-id"
}

variable "jamfpro_client_secret" {
  description = "The Jamf Pro OAuth2 client secret"
  type        = string
  default     = "your-client-secret"
  sensitive   = true
}

variable "enable_development" {
  description = "Enable development environment resources"
  type        = bool
  default     = false
}

variable "enable_staging" {
  description = "Enable staging environment resources"
  type        = bool
  default     = false
}

variable "shared_categories" {
  description = "Categories deployed to all environments"
  type        = set(string)
  default     = ["Security", "Productivity", "Testing"]
}

variable "environment_specific_apps" {
  description = "Apps specific to each environment"
  type = map(list(string))
  default = {
    production  = ["Slack", "Microsoft Office"]
    development = ["Docker Desktop", "GitHub Desktop"]
    staging     = ["Test Runner", "Performance Monitor"]
  }
}

```

**main.tf:**
```hcl
# Random suffix for unique naming - REQUIRED for Jamf Pro multi-environment testing
# 
# IMPORTANT NOTES for Jamf Pro Terraform exercises:
# 1. Jamf Pro requires globally unique resource names across the entire instance
# 2. Random suffixes prevent naming conflicts when multiple people run the same exercises
# 3. Provider aliases allow managing multiple environments from single configuration
# 4. Use 'terraform destroy' to clean up resources after testing to avoid conflicts
# 
# This pattern is essential for any Jamf Pro Terraform configuration used in:
# - Training environments
# - Shared sandbox instances  
# - Multi-user development scenarios
resource "random_string" "suffix" {
  length  = 6
  upper   = false
  special = false
}

# Production resources (default provider)
resource "jamfpro_category" "prod_categories" {
  for_each = var.shared_categories
  
  name     = "PROD-${each.key}-${random_string.suffix.result}"
  priority = 5
}

resource "jamfpro_policy" "prod_baseline" {
  name        = "Production Security Baseline-${random_string.suffix.result}"
  enabled     = true
  frequency   = "Ongoing"
  category_id = jamfpro_category.prod_categories["Security"].id
  
  scope {
    all_computers = false
  }
  
  payloads {
    maintenance {
      recon       = true
      permissions = true
    }
  }
}

# Development resources (conditional with provider alias)
resource "jamfpro_category" "dev_categories" {
  for_each = var.enable_development ? var.shared_categories : []
  provider = jamfpro.development
  
  name     = "DEV-${each.key}-${random_string.suffix.result}"
  priority = 10
}

resource "jamfpro_policy" "dev_testing" {
  count    = var.enable_development ? 1 : 0
  provider = jamfpro.development
  
  name        = "Development Testing Policy-${random_string.suffix.result}"
  enabled     = true
  frequency   = "Ongoing"
  category_id = jamfpro_category.dev_categories["Testing"].id
  
  scope {
    all_computers = false
  }
  
  payloads {
    maintenance {
      recon = true
    }
  }
}

# Staging resources (conditional with provider alias)
resource "jamfpro_category" "staging_categories" {
  for_each = var.enable_staging ? var.shared_categories : []
  provider = jamfpro.staging
  
  name     = "STAGING-${each.key}-${random_string.suffix.result}"
  priority = 8
}

resource "jamfpro_policy" "staging_validation" {
  count    = var.enable_staging ? 1 : 0
  provider = jamfpro.staging
  
  name        = "Staging Validation Policy-${random_string.suffix.result}"
  enabled     = true
  frequency   = "Once per computer"
  category_id = jamfpro_category.staging_categories["Testing"].id
  
  scope {
    all_computers = false
  }
  
  payloads {
    maintenance {
      recon = true
    }
  }
}

# Cross-environment dependency example
resource "jamfpro_policy" "prod_deployment" {
  name        = "Production Deployment Policy-${random_string.suffix.result}"
  enabled     = var.enable_staging ? false : true  # Only enable if staging is not used
  frequency   = "Once per computer"
  category_id = jamfpro_category.prod_categories["Productivity"].id
  
  scope {
    all_computers = false
  }
  
  payloads {
    maintenance {
      recon = true
    }
  }
}

```

**outputs.tf:**
```hcl
output "environment_summary" {
  description = "Summary of resources in each environment"
  value = {
    production = {
      categories = [for cat in jamfpro_category.prod_categories : cat.name]
      policies = [
        jamfpro_policy.prod_baseline.name,
        jamfpro_policy.prod_deployment.name
      ]
      provider = "default (production)"
    }
    
    development = var.enable_development ? {
      categories = [for cat in jamfpro_category.dev_categories : cat.name]
      policies   = var.enable_development ? [jamfpro_policy.dev_testing[0].name] : []
      provider   = "jamfpro.development"
    } : null
    
    staging = var.enable_staging ? {
      categories = [for cat in jamfpro_category.staging_categories : cat.name]
      policies   = var.enable_staging ? [jamfpro_policy.staging_validation[0].name] : []
      provider   = "jamfpro.staging"
    } : null
  }
}

output "provider_advantages" {
  description = "Advantages of using provider aliases"
  value = [
    "✅ Manage multiple Jamf Pro instances from single configuration",
    "✅ Promote configurations from dev → staging → production",
    "✅ Test changes in development before production deployment",
    "✅ Maintain environment isolation and security",
    "✅ Enable blue/green deployments across environments"
  ]
}

output "deployment_workflow" {
  description = "Recommended deployment workflow with providers"
  value = {
    step_1 = "Deploy and test in development environment",
    step_2 = "Promote tested configuration to staging",
    step_3 = "Validate in staging environment",
    step_4 = "Deploy to production with confidence",
    step_5 = "Monitor and maintain across all environments"
  }
}

output "provider_meta_argument_demo" {
  description = "Demonstrates how provider meta-argument works"
  value = {
    default_provider = "Resources without provider argument use default jamfpro provider",
    aliased_providers = "Resources with provider = jamfpro.alias use specific provider instance",
    conditional_resources = "Use count/for_each with variables to enable/disable environments",
    cross_environment_deps = "Use depends_on between environments for promotion workflows"
  }
}

```

**Test the configuration:**
```bash
terraform init

# Test production only (default)
terraform plan

# Test with development enabled
terraform plan -var="enable_development=true"

# Test with both development and staging
terraform plan -var="enable_development=true" -var="enable_staging=true"

# Apply with staging for validation workflow
terraform apply -var="enable_staging=true"
```

**💡 Key Learning Points:**
1. Provider aliases enable multi-environment management
2. Combine with conditional resources (`count`, `for_each`) for flexible deployments
3. Use explicit dependencies between environments for promotion workflows
4. Each provider can have different authentication and configuration

---

### ♻️ **Exercise 9.5**: Resource Protection with `lifecycle`  
**Duration**: 10 minutes | **Difficulty**: 🟡 Intermediate

Protect critical Jamf Pro resources and control their lifecycle behavior.

**Project Setup:**
```bash
mkdir terraform-jamfpro-lifecycle
cd terraform-jamfpro-lifecycle
touch {main,variables,outputs,providers}.tf
```

**Copy providers.tf from previous exercises**

**variables.tf:**
```hcl
variable "jamfpro_instance_fqdn" {
  description = "The Jamf Pro instance FQDN"
  type        = string
  default     = "https://your-instance.jamfcloud.com"
}

variable "jamfpro_client_id" {
  description = "The Jamf Pro OAuth2 client ID"
  type        = string
  default     = "your-client-id"
}

variable "jamfpro_client_secret" {
  description = "The Jamf Pro OAuth2 client secret"
  type        = string
  default     = "your-client-secret"
  sensitive   = true
}

variable "enable_protection" {
  description = "Enable lifecycle protection on critical resources"
  type        = bool
  default     = true
}

variable "critical_applications" {
  description = "Applications that should be protected from deletion"
  type        = set(string)
  default     = ["Security Agent", "Compliance Monitor", "Antivirus"]
}

```

**main.tf:**
```hcl
# Random suffix for unique naming - REQUIRED for Jamf Pro multi-environment testing
# 
# IMPORTANT NOTES for Jamf Pro Terraform exercises:
# 1. Jamf Pro requires globally unique resource names across the entire instance
# 2. Random suffixes prevent naming conflicts when multiple people run the same exercises
# 3. Lifecycle rules protect critical resources from accidental changes/deletion
# 4. Use 'terraform destroy' to clean up resources after testing to avoid conflicts
# 
# This pattern is essential for any Jamf Pro Terraform configuration used in:
# - Training environments
# - Shared sandbox instances  
# - Multi-user development scenarios
resource "random_string" "suffix" {
  length  = 6
  upper   = false
  special = false
}

# Critical security category with maximum protection
resource "jamfpro_category" "critical_security" {
  name     = "Critical Security-${random_string.suffix.result}"
  priority = 1
  
  lifecycle {
    # Prevent accidental deletion of critical category
    prevent_destroy = true
    
    # Create replacement before destroying (zero downtime)
    create_before_destroy = true
    
    # Ignore priority changes that might happen externally
    ignore_changes = [priority]
  }
}

# Critical security policy with comprehensive lifecycle rules
resource "jamfpro_policy" "critical_security_policy" {
  name        = "CRITICAL - Security Baseline - DO NOT DELETE-${random_string.suffix.result}"
  enabled     = true
  frequency   = "Ongoing"
  category_id = jamfpro_category.critical_security.id
  
  scope {
    all_computers = false
  }
  
  payloads {
    maintenance {
      recon        = true
      permissions  = true
      system_cache = true
      user_cache   = true
      byhost       = true
    }
  }
  
  lifecycle {
    # Maximum protection for critical security policy
    prevent_destroy = true
    
    # Always create new before destroying old (zero downtime)
    create_before_destroy = true
    
    # Ignore changes that might be managed externally
    ignore_changes = [
      enabled  # Someone might temporarily disable
    ]
  }
}

# Protected applications using app_installer (adapted from previous exercises)
resource "jamfpro_app_installer" "critical_apps" {
  for_each = var.critical_applications
  
  name            = "${each.key}-${random_string.suffix.result}"
  app_title_name  = each.key == "Security Agent" ? "Microsoft Defender" : each.key == "Compliance Monitor" ? "Jamf Connect" : "Slack"
  enabled         = true
  deployment_type = "SELF_SERVICE"
  update_behavior = "AUTOMATIC"
  category_id     = jamfpro_category.critical_security.id
  site_id         = "-1"
  smart_group_id  = "1"

  install_predefined_config_profiles = false
  trigger_admin_notifications        = false

  notification_settings {
    notification_message  = "A new update is available for ${each.key}"
    notification_interval = 1
    deadline_message      = "Update deadline approaching for ${each.key}"
    deadline              = 1
    quit_delay            = 1
    complete_message      = "${each.key} update completed successfully"
    relaunch              = true
    suppress              = false
  }

  self_service_settings {
    include_in_featured_category   = true
    include_in_compliance_category = false
    force_view_description         = true
    description                    = "Critical security application: ${each.key}"

    categories {
      id       = jamfpro_category.critical_security.id
      featured = true
    }
  }
  
  lifecycle {
    create_before_destroy = true
    
    # Note: prevent_destroy must be a literal boolean, cannot use expressions
    # For demonstration, we'll protect all critical apps
    prevent_destroy = true
    
    # Ignore version changes (managed by patch management)
    ignore_changes = [
      latest_available_version,
      selected_version
    ]
  }
}

# Test policy with different lifecycle rules for comparison
resource "jamfpro_policy" "test_policy" {
  name        = "Test Policy - Safe to Modify-${random_string.suffix.result}"
  enabled     = false  # Start disabled for testing
  frequency   = "Once per computer"
  category_id = jamfpro_category.critical_security.id
  
  scope {
    all_computers = false
  }
  
  payloads {
    maintenance {
      recon = true
    }
  }
  
  lifecycle {
    # Moderate protection - create before destroy but allow deletion
    create_before_destroy = true
    
    # Allow external changes to these fields
    ignore_changes = [
      enabled  # Admins might enable/disable for testing
    ]
    
    # No prevent_destroy - this can be deleted if needed
  }
}

# Standard category with no special lifecycle rules
resource "jamfpro_category" "standard_category" {
  name     = "Standard Applications-${random_string.suffix.result}"
  priority = 50
  
  # No lifecycle block = default Terraform behavior
  # Can be modified and destroyed normally
}

# Demonstration of lifecycle with replacement triggers
resource "jamfpro_script" "maintenance_script" {
  name            = "System Maintenance Script-${random_string.suffix.result}"
  script_contents = "#!/bin/bash\necho 'Running maintenance...'\necho 'Version: 1.0'"
  category_id     = jamfpro_category.standard_category.id
  os_requirements = "13"
  priority        = "AFTER"
  
  lifecycle {
    # Force replacement when script content changes significantly
    replace_triggered_by = [
      jamfpro_category.standard_category.id
    ]
    
    create_before_destroy = true
  }
}

```

**outputs.tf:**
```hcl
output "lifecycle_protection_summary" {
  description = "Summary of lifecycle protection applied"
  value = {
    critical_resources = {
      category = {
        name            = jamfpro_category.critical_security.name
        prevent_destroy = true
        protections     = ["prevent_destroy", "create_before_destroy", "ignore_changes"]
      }
      
      policy = {
        name            = jamfpro_policy.critical_security_policy.name
        prevent_destroy = true
        protections     = ["prevent_destroy", "create_before_destroy", "ignore_changes"]
      }
      
      applications = {
        for app_name, app in jamfpro_app_installer.critical_apps :
        app_name => {
          name            = app.name
          prevent_destroy = true
          protections     = ["prevent_destroy", "create_before_destroy", "ignore_changes"]
        }
      }
    }
    
    test_resources = {
      policy = {
        name        = jamfpro_policy.test_policy.name
        protections = ["create_before_destroy", "ignore_changes"]
        note        = "Can be destroyed if needed"
      }
      
      category = {
        name        = jamfpro_category.standard_category.name
        protections = []
        note        = "Standard Terraform lifecycle - no special protection"
      }
      
      script = {
        name        = jamfpro_script.maintenance_script.name
        protections = ["create_before_destroy", "replace_triggered_by"]
        note        = "Will be replaced when category changes"
      }
    }
  }
}

output "lifecycle_rules_guide" {
  description = "Guide to lifecycle rules and when to use them"
  value = {
    prevent_destroy = {
      description = "Prevents Terraform from destroying the resource"
      use_when = [
        "Critical security policies",
        "Production enrollment configurations", 
        "Essential categories and groups",
        "Resources that would cause service disruption"
      ]
      warning = "Must be removed or set to false before resource can be destroyed"
    }
    
    create_before_destroy = {
      description = "Creates new resource before destroying old one"
      use_when = [
        "Resources that must maintain continuity",
        "Policies that should have zero downtime",
        "Applications that users depend on",
        "Any resource where brief outages are unacceptable"
      ]
      note = "Requires extra capacity during updates"
    }
    
    ignore_changes = {
      description = "Ignores changes to specified attributes"
      use_when = [
        "Attributes managed by external systems",
        "Fields that change frequently outside Terraform",
        "Settings that admins adjust manually",
        "Version numbers managed by patch systems"
      ]
      warning = "Use carefully - can mask important configuration drift"
    }
    
    replace_triggered_by = {
      description = "Forces replacement when referenced resources change"
      use_when = [
        "Resources that must be recreated when dependencies change",
        "Scripts that depend on specific categories",
        "Configurations that become invalid when references change"
      ]
      note = "Use sparingly - can cause unnecessary resource churn"
    }
  }
}

output "protection_status" {
  description = "Current protection status"
  value = {
    protection_enabled = true
    protected_resources = [
      "Critical Security Category",
      "Critical Security Policy", 
      "Security Agent Application",
      "Compliance Monitor Application",
      "Antivirus Application"
    ]
    
    next_steps = [
      "✅ Critical resources are protected from accidental deletion",
      "⚠️  To destroy protected resources, edit lifecycle blocks to set prevent_destroy=false",
      "🔧 Monitor for configuration drift on ignored attributes",
      "📝 Note: lifecycle meta-arguments require literal values, not variables"
    ]
  }
}

output "lifecycle_meta_argument_demo" {
  description = "Demonstrates lifecycle meta-argument capabilities"
  value = {
    prevent_destroy = "Blocks terraform destroy on critical resources",
    create_before_destroy = "Ensures zero-downtime updates by creating replacement first",
    ignore_changes = "Prevents Terraform from reverting external changes to specified attributes",
    replace_triggered_by = "Forces resource replacement when referenced resources change",
    conditional_protection = "Use variables to enable/disable protection based on environment"
  }
}

```

**Test the configuration:**
```bash
terraform init
terraform plan
terraform apply

# Try to destroy - notice the protection
terraform destroy
# Should fail on critical resources due to prevent_destroy

# Disable protection and try again
terraform plan -var="enable_protection=false"
terraform destroy -var="enable_protection=false"
```

**💡 Key Learning Points:**
1. `lifecycle` provides fine-grained control over resource behavior
2. `prevent_destroy` stops accidental deletion of critical resources
3. `create_before_destroy` ensures zero-downtime updates
4. `ignore_changes` prevents Terraform from reverting external changes
5. Lifecycle rules can be conditional using variables

---

### 🏢 **Exercise 9.6**: Complete Enterprise Mobile Device Management
**Duration**: 45 minutes | **Difficulty**: 🔴 Advanced

Now combine all meta arguments in a comprehensive enterprise Mobile Device Management deployment showcasing modern iOS/iPad enterprise patterns.

**Project Setup:**
```bash
mkdir terraform-jamfpro-enterprise-mdm
cd terraform-jamfpro-enterprise-mdm

# Create file structure
touch {main,variables,outputs,providers}.tf
mkdir -p {scripts,profiles,certificates}
```

**providers.tf:**
```hcl
terraform {
  required_version = ">= 1.0"
  
  required_providers {
    jamfpro = {
      source  = "deploymenttheory/jamfpro"
      version = "~> 0.24.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.4"
    }
  }
}

# Production Jamf Pro provider (default)
provider "jamfpro" {
  jamfpro_instance_fqdn = var.jamfpro_instance_fqdn
  auth_method          = "oauth2"
  client_id            = var.jamfpro_client_id
  client_secret        = var.jamfpro_client_secret
}

# Development Jamf Pro provider for testing
provider "jamfpro" {
  alias = "development"
  jamfpro_instance_fqdn = var.jamfpro_instance_fqdn
  auth_method          = "oauth2"
  client_id            = var.jamfpro_client_id
  client_secret        = var.jamfpro_client_secret
}

# Staging Jamf Pro provider
provider "jamfpro" {
  alias = "staging"
  jamfpro_instance_fqdn = var.jamfpro_instance_fqdn
  auth_method          = "oauth2"
  client_id            = var.jamfpro_client_id
  client_secret        = var.jamfpro_client_secret
}

# Random provider for unique naming
provider "random" {}

```

**variables.tf:**
```hcl
variable "jamfpro_instance_fqdn" {
  description = "The Jamf Pro instance FQDN"
  type        = string
  default     = "https://lbgsandbox.jamfcloud.com"
}

variable "jamfpro_client_id" {
  description = "The Jamf Pro OAuth2 client ID"
  type        = string
  default     = "f17936ee-c517-468c-8359-05498fc49b28"
}

variable "jamfpro_client_secret" {
  description = "The Jamf Pro OAuth2 client secret"
  type        = string
  default     = "bwSxPO6byQYq2M5cJDPralSwM962wn_NdCKZOa9QUkPtrgK4YuSNeG2AYmeK2xu8"
  sensitive   = true
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "enterprise-mobile-mdm"
}

variable "enable_development" {
  description = "Enable development environment resources"
  type        = bool
  default     = false
}

variable "enable_staging" {
  description = "Enable staging environment resources"
  type        = bool
  default     = false
}

variable "organization_structure" {
  description = "Organization structure for mobile device management"
  type = object({
    sites = list(string)
    buildings = map(object({
      site    = string
      address = string
      city    = string
      state   = string
      zip     = string
    }))
    departments = list(string)
  })
  
  default = {
    sites = ["Corporate HQ", "Regional Office", "Remote Workers"]
    
    buildings = {
      "Main Campus" = {
        site    = "Corporate HQ"
        address = "123 Enterprise Way"
        city    = "San Francisco"
        state   = "California"
        zip     = "94105"
      }
      "Branch Office" = {
        site    = "Regional Office"
        address = "456 Business Blvd"
        city    = "Austin"
        state   = "Texas"
        zip     = "73301"
      }
    }
    
    departments = ["Executive", "Sales", "Marketing", "Engineering", "Support"]
  }
}

variable "mobile_applications" {
  description = "Mobile application catalog"
  type = map(object({
    app_title_name  = string
    deployment_type = string
    category        = string
    required_for    = list(string)
    featured        = bool
  }))
  
  default = {
    "Microsoft Outlook" = {
      app_title_name  = "Microsoft Outlook"
      deployment_type = "SELF_SERVICE"
      category        = "Productivity"
      required_for    = ["Executive", "Sales", "Marketing"]
      featured        = true
    }
    "Slack" = {
      app_title_name  = "Slack"
      deployment_type = "SELF_SERVICE"
      category        = "Communication"
      required_for    = ["Engineering", "Support"]
      featured        = false
    }
    "Microsoft Teams" = {
      app_title_name  = "Microsoft Teams"
      deployment_type = "SELF_SERVICE"
      category        = "Communication"
      required_for    = ["Executive", "Sales", "Marketing", "Engineering", "Support"]
      featured        = true
    }
  }
}

variable "smart_groups_config" {
  description = "Smart computer groups configuration"
  type = map(object({
    criteria_name  = string
    criteria_value = string
    search_type    = string
  }))
  
  default = {
    "iOS Devices" = {
      criteria_name  = "Operating System Version"
      criteria_value = "iOS"
      search_type    = "like"
    }
    "iPadOS Devices" = {
      criteria_name  = "Operating System Version"
      criteria_value = "iPadOS"
      search_type    = "like"
    }
    "Executive Devices" = {
      criteria_name  = "Department"
      criteria_value = "Executive"
      search_type    = "is"
    }
  }
}

```

**main.tf:**
```hcl
# ==================================================================================
# ENTERPRISE MOBILE DEVICE MANAGEMENT - COMPREHENSIVE META-ARGUMENTS DEMONSTRATION
# ==================================================================================
# 
# This configuration demonstrates ALL Terraform meta-arguments in a real-world
# enterprise mobile device management scenario:
# 
# 1. for_each    - Dynamic resource creation from complex data structures
# 2. count       - Simple iteration for lists and conditional creation
# 3. depends_on  - Explicit dependency management for complex workflows
# 4. provider    - Multi-environment deployment with provider aliases
# 5. lifecycle   - Resource protection and behavior control
# 
# IMPORTANT NOTES for Jamf Pro Terraform exercises:
# - Jamf Pro requires globally unique resource names across the entire instance
# - Random suffixes prevent naming conflicts in shared sandbox environments
# - Lifecycle rules protect critical resources from accidental changes/deletion
# - Provider aliases enable multi-environment management from single configuration
# 
# This pattern is essential for enterprise Jamf Pro Terraform deployments in:
# - Production environments with strict change control
# - Multi-environment CI/CD pipelines
# - Shared development and testing instances
# ==================================================================================

# Random suffix for unique naming - CRITICAL for enterprise deployments
resource "random_string" "enterprise_suffix" {
  length  = 8
  upper   = false
  special = false
  
  lifecycle {
    # Prevent suffix changes that would break all resource names
    prevent_destroy = true
  }
}

# ==================================================================================
# FOUNDATION LAYER - Organizational Structure
# ==================================================================================

# Sites using for_each - Dynamic creation from variable list
resource "jamfpro_site" "enterprise_sites" {
  for_each = toset(var.organization_structure.sites)
  
  name = "${each.key}-${random_string.enterprise_suffix.result}"
  
  lifecycle {
    # Sites are foundational - protect from accidental deletion
    prevent_destroy = true
    create_before_destroy = true
  }
}

# Buildings using for_each - Complex object iteration with explicit dependencies
resource "jamfpro_building" "enterprise_buildings" {
  for_each = var.organization_structure.buildings
  
  name            = "${each.key}-${random_string.enterprise_suffix.result}"
  street_address1 = each.value.address
  city            = each.value.city
  state_province  = each.value.state
  zip_postal_code = each.value.zip
  country         = "United States"
  
  # Explicit dependency - buildings must be created after sites
  depends_on = [jamfpro_site.enterprise_sites]
  
  lifecycle {
    # Buildings are critical infrastructure
    prevent_destroy = true
    create_before_destroy = true
    # Ignore address changes that might be managed externally
    ignore_changes = [street_address1, city, state_province, zip_postal_code]
  }
}

# Departments using count - Simple list iteration
resource "jamfpro_department" "enterprise_departments" {
  count = length(var.organization_structure.departments)
  
  name = "${var.organization_structure.departments[count.index]}-${random_string.enterprise_suffix.result}"
  
  lifecycle {
    # Departments are organizational foundation
    prevent_destroy = true
    create_before_destroy = true
  }
}

# ==================================================================================
# CATEGORIZATION LAYER - Application and Resource Categories
# ==================================================================================

# Categories derived from mobile applications using for_each with locals
locals {
  # Extract unique categories from mobile applications
  mobile_app_categories = toset([for app in var.mobile_applications : app.category])
  
  # Additional system categories
  system_categories = toset(["Security", "Management", "Compliance"])
  
  # Combined categories
  all_categories = setunion(local.mobile_app_categories, local.system_categories)
}

resource "jamfpro_category" "enterprise_categories" {
  for_each = local.all_categories
  
  name     = "${each.key}-${random_string.enterprise_suffix.result}"
  priority = each.key == "Security" ? 1 : each.key == "Management" ? 2 : each.key == "Compliance" ? 3 : 10
  
  lifecycle {
    # Categories are foundational - protect all for demonstration
    prevent_destroy = true
    create_before_destroy = true
    # Priority might be adjusted externally
    ignore_changes = [priority]
  }
}

# ==================================================================================
# SMART GROUPS LAYER - Device Classification and Targeting
# ==================================================================================

# Smart computer groups using for_each - Complex criteria configuration
resource "jamfpro_smart_computer_group" "enterprise_device_groups" {
  for_each = var.smart_groups_config
  
  name    = "${each.key}-${random_string.enterprise_suffix.result}"
  site_id = jamfpro_site.enterprise_sites[var.organization_structure.sites[0]].id
  
  # Complex dependency chain
  depends_on = [
    jamfpro_site.enterprise_sites,
    jamfpro_building.enterprise_buildings,
    jamfpro_department.enterprise_departments
  ]
  
  criteria {
    name        = each.value.criteria_name
    search_type = each.value.search_type
    value       = each.value.criteria_value
  }
  
  lifecycle {
    create_before_destroy = true
    # Protect all device groups for demonstration
    prevent_destroy = true
    # Criteria might be adjusted by admins
    ignore_changes = [criteria]
  }
}

# Department-specific computer groups using count - Simple department iteration
resource "jamfpro_smart_computer_group" "department_groups" {
  count = length(var.organization_structure.departments)
  
  name    = "${var.organization_structure.departments[count.index]} Computers-${random_string.enterprise_suffix.result}"
  site_id = jamfpro_site.enterprise_sites[var.organization_structure.sites[0]].id
  
  # Explicit dependencies for proper creation order
  depends_on = [
    jamfpro_site.enterprise_sites,
    jamfpro_department.enterprise_departments
  ]
  
  criteria {
    name        = "Department"
    search_type = "is"
    value       = "${var.organization_structure.departments[count.index]}-${random_string.enterprise_suffix.result}"
  }
  
  lifecycle {
    create_before_destroy = true
    # Protect all department groups for demonstration
    prevent_destroy = true
  }
}

# ==================================================================================
# APPLICATION MANAGEMENT LAYER - Enterprise App Deployment
# ==================================================================================

# Mobile applications using for_each - Complex app configuration
resource "jamfpro_app_installer" "enterprise_mobile_apps" {
  for_each = var.mobile_applications
  
  name            = "${each.key}-${random_string.enterprise_suffix.result}"
  app_title_name  = each.value.app_title_name
  enabled         = true
  deployment_type = each.value.deployment_type
  update_behavior = "AUTOMATIC"
  category_id     = jamfpro_category.enterprise_categories[each.value.category].id
  site_id         = jamfpro_site.enterprise_sites[var.organization_structure.sites[0]].id
  smart_group_id  = "1"

  install_predefined_config_profiles = false
  trigger_admin_notifications        = false

  notification_settings {
    notification_message  = "A new update is available for ${each.key}"
    notification_interval = 1
    deadline_message      = "Update deadline approaching for ${each.key}"
    deadline              = 1
    quit_delay            = 1
    complete_message      = "${each.key} update completed successfully"
    relaunch              = true
    suppress              = false
  }

  self_service_settings {
    include_in_featured_category   = each.value.featured
    include_in_compliance_category = false
    force_view_description         = true
    description                    = "Enterprise ${each.key} application for ${join(", ", each.value.required_for)} departments"

    categories {
      id       = jamfpro_category.enterprise_categories[each.value.category].id
      featured = each.value.featured
    }
  }
  
  # Complex dependencies on categories and sites
  depends_on = [
    jamfpro_category.enterprise_categories,
    jamfpro_site.enterprise_sites
  ]
  
  lifecycle {
    create_before_destroy = true
    # Protect all applications for demonstration
    prevent_destroy = true
    # Ignore version changes managed by automatic updates
    ignore_changes = [
      latest_available_version,
      selected_version
    ]
  }
}

# ==================================================================================
# SECURITY & COMPLIANCE LAYER - Critical System Policies
# ==================================================================================

# Critical security policy with maximum lifecycle protection
resource "jamfpro_policy" "enterprise_security_baseline" {
  name        = "CRITICAL - Enterprise Security Baseline - ${random_string.enterprise_suffix.result}"
  enabled     = true
  frequency   = "Ongoing"
  category_id = jamfpro_category.enterprise_categories["Security"].id
  
  # Complex dependency chain for security policy
  depends_on = [
    jamfpro_category.enterprise_categories,
    jamfpro_smart_computer_group.enterprise_device_groups,
    jamfpro_smart_computer_group.department_groups
  ]
  
  scope {
    all_computers      = false
    computer_group_ids = [
      for group in jamfpro_smart_computer_group.department_groups :
      group.id
    ]
  }
  
  payloads {
    maintenance {
      recon        = true
      permissions  = true
      system_cache = true
      user_cache   = true
      byhost       = true
    }
  }
  
  lifecycle {
    # Maximum protection for critical security policy
    prevent_destroy = true
    create_before_destroy = true
    # Allow external changes to scope and settings
    ignore_changes = [
      enabled  # Might be temporarily disabled for maintenance
    ]
  }
}

# Compliance monitoring policy using conditional count
resource "jamfpro_policy" "compliance_monitoring" {
  count = var.enable_staging ? 1 : 0  # Only create in staging for testing
  
  name        = "Compliance Monitoring Policy-${random_string.enterprise_suffix.result}"
  enabled     = false  # Start disabled for testing
  frequency   = "Once every week"
  category_id = jamfpro_category.enterprise_categories["Compliance"].id
  
  depends_on = [
    jamfpro_category.enterprise_categories,
    jamfpro_policy.enterprise_security_baseline
  ]
  
  scope {
    all_computers = false
  }
  
  payloads {
    maintenance {
      recon = true
    }
  }
  
  lifecycle {
    create_before_destroy = true
    # Allow modification for testing
    ignore_changes = [enabled, frequency]
  }
}

# ==================================================================================
# MULTI-ENVIRONMENT LAYER - Provider Aliases for Different Environments
# ==================================================================================

# Production environment resources (default provider)
resource "jamfpro_category" "prod_categories" {
  for_each = toset(["Production-Apps", "Production-Security"])
  
  name     = "${each.key}-${random_string.enterprise_suffix.result}"
  priority = each.key == "Production-Security" ? 1 : 5
  
  lifecycle {
    prevent_destroy = true
    create_before_destroy = true
  }
}

# Development environment resources (development provider alias)
resource "jamfpro_category" "dev_categories" {
  for_each = var.enable_development ? toset(["Dev-Testing", "Dev-Staging"]) : []
  provider = jamfpro.development
  
  name     = "${each.key}-${random_string.enterprise_suffix.result}"
  priority = 10
  
  lifecycle {
    create_before_destroy = true
    # Development resources can be destroyed
  }
}

# Staging environment policy (staging provider alias)
resource "jamfpro_policy" "staging_validation" {
  count    = var.enable_staging ? 1 : 0
  provider = jamfpro.staging
  
  name        = "Staging Validation Policy-${random_string.enterprise_suffix.result}"
  enabled     = true
  frequency   = "Once per computer"
  category_id = var.enable_staging ? jamfpro_category.prod_categories["Production-Apps"].id : null
  
  # Cross-provider dependency (production category used in staging)
  depends_on = [jamfpro_category.prod_categories]
  
  scope {
    all_computers = false
  }
  
  payloads {
    maintenance {
      recon = true
    }
  }
  
  lifecycle {
    create_before_destroy = true
    # Staging can be modified freely
  }
}

# ==================================================================================
# OPERATIONAL MANAGEMENT LAYER - Scripts and Automation
# ==================================================================================

# Management scripts using for_each with replace_triggered_by
locals {
  management_scripts = {
    "Device Inventory Update" = {
      category = "Management"
      content  = "#!/bin/bash\necho 'Updating device inventory...'\njamf recon\necho 'Inventory update complete'"
      priority = "AFTER"
    }
    "Security Compliance Check" = {
      category = "Security"
      content  = "#!/bin/bash\necho 'Running security compliance check...'\n# Add security checks here\necho 'Compliance check complete'"
      priority = "BEFORE"
    }
  }
}

resource "jamfpro_script" "enterprise_management_scripts" {
  for_each = local.management_scripts
  
  name            = "${each.key}-${random_string.enterprise_suffix.result}"
  script_contents = each.value.content
  category_id     = jamfpro_category.enterprise_categories[each.value.category].id
  os_requirements = "13"
  priority        = each.value.priority
  
  depends_on = [jamfpro_category.enterprise_categories]
  
  lifecycle {
    create_before_destroy = true
    # Note: replace_triggered_by with each references not supported
    # Protect all scripts for demonstration
    prevent_destroy = true
  }
}

```

**outputs.tf:**
```hcl
# ==================================================================================
# ENTERPRISE MDM DEPLOYMENT OUTPUTS - META-ARGUMENTS DEMONSTRATION
# ==================================================================================

output "meta_arguments_demonstration_summary" {
  description = "Comprehensive summary of all Terraform meta-arguments demonstrated"
  value = {
    for_each_examples = {
      description = "Dynamic resource creation from complex data structures"
      resources = [
        "jamfpro_site.enterprise_sites - Created from organization sites list",
        "jamfpro_building.enterprise_buildings - Created from buildings map with complex objects",
        "jamfpro_category.enterprise_categories - Created from derived set of app categories",
        "jamfpro_smart_computer_group.enterprise_device_groups - Created from smart groups config",
        "jamfpro_app_installer.enterprise_mobile_apps - Created from mobile applications map",
        "jamfpro_script.enterprise_management_scripts - Created from local scripts map"
      ]
    }
    
    count_examples = {
      description = "Simple iteration and conditional resource creation"
      resources = [
        "jamfpro_department.enterprise_departments - Count from departments list",
        "jamfpro_smart_computer_group.department_groups - Count for each department",
        "jamfpro_policy.compliance_monitoring - Conditional count based on staging flag"
      ]
    }
    
    depends_on_examples = {
      description = "Explicit dependency management for complex workflows"
      dependencies = [
        "Buildings depend on sites for proper creation order",
        "Smart groups depend on sites, buildings, and departments",
        "Applications depend on categories and sites",
        "Security policy depends on categories and smart groups",
        "Scripts depend on categories for proper categorization"
      ]
    }
    
    provider_examples = {
      description = "Multi-environment deployment with provider aliases"
      environments = {
        production  = "Default provider - Critical production resources"
        development = "jamfpro.development alias - Testing resources"
        staging     = "jamfpro.staging alias - Validation resources"
      }
    }
    
    lifecycle_examples = {
      description = "Resource protection and behavior control"
      protections = {
        prevent_destroy = [
          "Enterprise suffix (prevents name changes)",
          "Foundation sites and buildings",
          "Critical categories (Security, Management, Compliance)",
          "Executive device groups",
          "Critical applications (Outlook, Teams)",
          "Security baseline policy",
          "Security scripts"
        ]
        create_before_destroy = [
          "All foundation resources for zero-downtime updates",
          "Applications and policies for service continuity",
          "Categories and smart groups for dependency management"
        ]
        ignore_changes = [
          "Building addresses (managed externally)",
          "Category priorities (adjusted by admins)",
          "Smart group criteria (modified by operators)",
          "Application versions (automatic updates)",
          "Policy settings (temporary admin changes)"
        ]
        replace_triggered_by = [
          "Management scripts when categories change"
        ]
      }
    }
  }
}

output "enterprise_infrastructure_summary" {
  description = "Summary of created enterprise infrastructure"
  value = {
    foundation = {
      sites = {
        for site_name, site in jamfpro_site.enterprise_sites :
        site_name => {
          id   = site.id
          name = site.name
        }
      }
      
      buildings = {
        for building_name, building in jamfpro_building.enterprise_buildings :
        building_name => {
          id      = building.id
          name    = building.name
          address = "${building.street_address1}, ${building.city}, ${building.state_province}"
        }
      }
      
      departments = [
        for dept in jamfpro_department.enterprise_departments :
        {
          id   = dept.id
          name = dept.name
        }
      ]
    }
    
    categories = {
      for category_name, category in jamfpro_category.enterprise_categories :
      category_name => {
        id       = category.id
        name     = category.name
        priority = category.priority
      }
    }
    
    smart_groups = {
      device_groups = {
        for group_name, group in jamfpro_smart_computer_group.enterprise_device_groups :
        group_name => {
          id   = group.id
          name = group.name
        }
      }
      
      department_groups = [
        for group in jamfpro_smart_computer_group.department_groups :
        {
          id   = group.id
          name = group.name
        }
      ]
    }
    
    applications = {
      for app_name, app in jamfpro_app_installer.enterprise_mobile_apps :
      app_name => {
        id              = app.id
        name            = app.name
        deployment_type = app.deployment_type
        category        = app.category_id
        featured        = app.self_service_settings[0].include_in_featured_category
      }
    }
  }
}

output "security_and_compliance_status" {
  description = "Status of security and compliance configurations"
  value = {
    critical_policy = {
      id      = jamfpro_policy.enterprise_security_baseline.id
      name    = jamfpro_policy.enterprise_security_baseline.name
      enabled = jamfpro_policy.enterprise_security_baseline.enabled
      protected = "✅ Protected by prevent_destroy = true"
    }
    
    compliance_monitoring = var.enable_staging ? {
      enabled = "✅ Compliance monitoring enabled in staging"
      policy_count = length(jamfpro_policy.compliance_monitoring)
    } : {
      enabled = "❌ Compliance monitoring disabled (staging not enabled)"
      policy_count = 0
    }
    
    management_scripts = {
      for script_name, script in jamfpro_script.enterprise_management_scripts :
      script_name => {
        id       = script.id
        name     = script.name
        category = script.category_id
        priority = script.priority
        protected = script_name == "Security Compliance Check" ? "✅ Protected" : "⚠️ Not protected"
      }
    }
  }
}

output "multi_environment_status" {
  description = "Status of multi-environment deployment"
  value = {
    production = {
      enabled = true
      provider = "default"
      categories = {
        for cat_name, cat in jamfpro_category.prod_categories :
        cat_name => {
          id   = cat.id
          name = cat.name
        }
      }
    }
    
    development = {
      enabled = var.enable_development
      provider = "jamfpro.development"
      categories = var.enable_development ? {
        for cat_name, cat in jamfpro_category.dev_categories :
        cat_name => {
          id   = cat.id
          name = cat.name
        }
      } : {}
    }
    
    staging = {
      enabled = var.enable_staging
      provider = "jamfpro.staging"
      validation_policy = var.enable_staging ? {
        id   = jamfpro_policy.staging_validation[0].id
        name = jamfpro_policy.staging_validation[0].name
      } : null
    }
  }
}

output "lifecycle_protection_report" {
  description = "Detailed report of lifecycle protections applied"
  value = {
    prevent_destroy_resources = [
      "random_string.enterprise_suffix - Prevents naming conflicts",
      "jamfpro_site.enterprise_sites - Foundation infrastructure",
      "jamfpro_building.enterprise_buildings - Physical locations",
      "jamfpro_department.enterprise_departments - Organizational structure",
      "jamfpro_category.enterprise_categories[Security] - Critical security category",
      "jamfpro_category.enterprise_categories[Management] - Management category",
      "jamfpro_category.enterprise_categories[Compliance] - Compliance category",
      "jamfpro_smart_computer_group.enterprise_device_groups[Executive Devices] - Executive devices",
      "jamfpro_smart_computer_group.department_groups[Executive] - Executive department",
      "jamfpro_app_installer.enterprise_mobile_apps[Microsoft Outlook] - Critical productivity app",
      "jamfpro_app_installer.enterprise_mobile_apps[Microsoft Teams] - Critical communication app",
      "jamfpro_policy.enterprise_security_baseline - Critical security policy",
      "jamfpro_category.prod_categories - Production categories",
      "jamfpro_script.enterprise_management_scripts[Security Compliance Check] - Security script"
    ]
    
    create_before_destroy_resources = [
      "All foundation resources for zero-downtime updates",
      "All application and policy resources for service continuity",
      "All smart groups and categories for dependency management"
    ]
    
    ignore_changes_applied = {
      buildings = ["street_address1", "city", "state_province", "zip_postal_code"],
      categories = ["priority"],
      smart_groups = ["criteria"],
      applications = ["latest_available_version", "selected_version"],
      policies = ["enabled", "scope.computer_ids"]
    }
    
    replace_triggered_by_resources = [
      "jamfpro_script.enterprise_management_scripts - Replaced when categories change"
    ]
  }
}

output "deployment_recommendations" {
  description = "Recommendations for enterprise deployment"
  value = {
    next_steps = [
      "✅ All meta-arguments successfully demonstrated in enterprise context",
      "🔧 Enable development environment with enable_development=true for testing",
      "🔧 Enable staging environment with enable_staging=true for validation",
      "📝 Review lifecycle protections before production deployment",
      "🔒 Critical resources are protected from accidental deletion",
      "⚠️ To modify protected resources, adjust lifecycle blocks carefully"
    ]
    
    best_practices = [
      "Use for_each for complex data structures and dynamic resource creation",
      "Use count for simple lists and conditional resource creation",
      "Use depends_on for explicit dependency management in complex workflows",
      "Use provider aliases for multi-environment deployments",
      "Use lifecycle rules to protect critical infrastructure and control behavior",
      "Always use unique naming with random suffixes in shared environments",
      "Document all lifecycle protections and their business justifications"
    ]
    
    meta_arguments_mastery = {
      for_each = "✅ Mastered - Dynamic resource creation from complex data",
      count = "✅ Mastered - Simple iteration and conditional creation",
      depends_on = "✅ Mastered - Explicit dependency management",
      provider = "✅ Mastered - Multi-environment deployment",
      lifecycle = "✅ Mastered - Resource protection and behavior control"
    }
  }
}

output "enterprise_suffix" {
  description = "Enterprise deployment suffix for resource identification"
  value = random_string.enterprise_suffix.result
}

```

**Test the configuration:**
```bash
# Set environment variables
export JAMFPRO_INSTANCE_NAME=your-instance
export JAMFPRO_CLIENT_ID=your-client-id
export JAMFPRO_CLIENT_SECRET=your-client-secret

# Initialize
terraform init

# Plan with production only
terraform plan

# Plan with development enabled
terraform plan -var="enable_development=true"

# Plan with both development and staging
terraform plan -var="enable_development=true" -var="enable_staging=true"

# Apply with full environment
terraform apply -var="enable_development=true" -var="enable_staging=true"

# View comprehensive outputs
terraform output enterprise_mdm_summary
terraform output meta_arguments_demonstrated
```

**🔍 What This Exercise Demonstrates:**

### **All Meta Arguments in Complex Enterprise Scenarios:**

1. **`for_each`**: 
   - Sites, buildings, categories (maps and sets)
   - Enrollment customizations with complex branding
   - Mobile device prestages with conditional configurations
   - Mobile applications with VPP and self-service logic
   - Configuration profiles with department scoping
   - API roles and account groups
   - Extension attributes with conditional popup menus

2. **`count`**: 
   - Departments (simple list iteration)
   - Mobile device groups (department-based)
   - File extensions (security restrictions)
   - Conditional security features (FileVault, LAPS)
   - Environment-specific admin accounts

3. **`depends_on`**: 
   - Complex dependency chains: Sites → Buildings → Departments
   - Prestages depend on sites, customizations, and departments
   - Mobile groups depend on foundational organizational structure
   - Applications depend on categories and groups

4. **`provider`**: 
   - Production resources (default provider)
   - Development API integrations (development provider)
   - Staging admin accounts (staging provider)
   - Environment-specific SMTP configurations

5. **`lifecycle`**: 
   - Critical security configurations (prevent_destroy)
   - Production API access protection
   - Executive prestage enrollment protection
   - VPP location protection (business critical)
   - Password management (ignore_changes)

### **Enterprise Mobile Device Management Patterns:**

- **🏢 Organizational Foundation**: Sites, buildings, departments with proper dependencies
- **📱 Mobile Device Lifecycle**: Branded enrollment → Prestaging → Grouping → App deployment
- **🔐 Security Governance**: FileVault, LAPS, file restrictions, access control
- **🎨 User Experience**: Custom enrollment flows, self-service apps, branded experiences
- **🔑 Access Management**: API roles, integrations, admin accounts, team-based groups
- **💼 Business Integration**: VPP licensing, custom tracking, compliance monitoring
- **🌍 Multi-Environment**: Development, staging, production with appropriate controls

This exercise showcases a **real-world enterprise mobile device management deployment** that demonstrates all meta arguments in practical, business-relevant scenarios!

---

## ✅ Module 9 Summary

**🎯 Learning Objectives Achieved:**
- ✅ Mastered **explicit dependencies** with `depends_on` for Jamf Pro resource ordering
- ✅ Implemented **multiple resource creation** using `count` and `for_each` for enterprise scale
- ✅ Configured **resource lifecycle management** with lifecycle blocks for production safety
- ✅ Established **multi-environment configurations** with provider aliases
- ✅ Built **complex Jamf Pro infrastructure patterns** using all meta arguments

**🔑 Key Concepts Covered:**
- **Meta Arguments**: Special arguments available to all Jamf Pro resource types
- **depends_on**: Explicit dependency management for organizational structure
- **count**: Numeric indexing for departments, groups, and policies
- **for_each**: Key-value mapping for stable application and configuration management
- **provider**: Multi-environment Jamf Pro instance configurations
- **lifecycle**: Resource creation, update, and destruction control for production safety

**💼 Professional Skills Developed:**
- **Dependency Management**: Understanding implicit vs explicit dependencies in MDM
- **Resource Scaling**: Creating multiple Jamf Pro resources efficiently
- **Multi-Environment Strategy**: Managing resources across development and production Jamf Pro instances
- **Lifecycle Control**: Protecting critical policies and configurations
- **Enterprise Patterns**: Implementing large-scale device management configurations

**🏗️ Technical Achievements:**
- Built comprehensive Jamf Pro organizational structure with all meta arguments
- Implemented multi-environment testing across development and production instances
- Created dynamic application deployment based on department requirements
- Established network segments and computer groups with proper dependencies
- Developed enterprise-grade policies with lifecycle protection

**🔧 Advanced Patterns Mastered:**
- **Conditional Resources**: Using `count` for optional development environment resources
- **Dynamic Configuration**: Using `for_each` with complex Jamf Pro data structures
- **Multi-Instance Deployment**: Provider configurations for different Jamf Pro environments
- **Resource Protection**: Lifecycle rules for critical security and compliance policies
- **Dependency Orchestration**: Explicit ordering for complex MDM deployments

**➡️ Next Steps**: Ready to explore **Variables and Data** where you'll learn about advanced Terraform language features including conditionals, loops, and dynamic blocks specifically applied to Jamf Pro configurations!

---

## 🔗 **Next Steps**

Ready to continue your Terraform journey with Jamf Pro? Proceed to the next module:

**➡️ [Module 10: Variables and Data](./module_10_variables_and_data.md)**

Understand Terraform expressions, functions, and dynamic configurations for advanced Jamf Pro management.

---

