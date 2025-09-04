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
      version = "~> 0.0.1"
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

## 💻 **Exercise 9.1**: Complete Meta Arguments Implementation with Jamf Pro
**Duration**: 45 minutes

Let's build a comprehensive Jamf Pro environment using all meta arguments to demonstrate enterprise device management.

**Step 1: Project Structure**
```bash
mkdir terraform-jamfpro-meta-arguments
cd terraform-jamfpro-meta-arguments

# Create file structure
touch {main,variables,outputs,providers}.tf
mkdir -p {scripts,profiles}
```

**Step 2: Provider Configuration (`providers.tf`)**
```hcl
terraform {
  required_version = ">= 1.0"
  
  required_providers {
    jamfpro = {
      source  = "deploymenttheory/jamfpro"
      version = "~> 0.0.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.4"
    }
  }
}

# Production Jamf Pro provider
provider "jamfpro" {
  jamfpro_instance_fqdn = var.prod_jamf_url
  auth_method           = "oauth2"
  client_id             = var.prod_client_id
  client_secret         = var.prod_client_secret
  
  default_tags = {
    Project     = var.project_name
    Environment = "production"
    ManagedBy   = "terraform"
  }
}

# Development Jamf Pro provider for testing
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

# Random provider for unique naming
provider "random" {}
```

**Step 3: Variables (`variables.tf`)**
```hcl
variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "enterprise-jamf-demo"
}

variable "prod_jamf_url" {
  description = "Production Jamf Pro instance URL"
  type        = string
  sensitive   = true
}

variable "dev_jamf_url" {
  description = "Development Jamf Pro instance URL"
  type        = string
  sensitive   = true
}

variable "prod_client_id" {
  description = "Production Jamf Pro OAuth2 client ID"
  type        = string
  sensitive   = true
}

variable "prod_client_secret" {
  description = "Production Jamf Pro OAuth2 client secret"
  type        = string
  sensitive   = true
}

variable "dev_client_id" {
  description = "Development Jamf Pro OAuth2 client ID"
  type        = string
  sensitive   = true
}

variable "dev_client_secret" {
  description = "Development Jamf Pro OAuth2 client secret"
  type        = string
  sensitive   = true
}

variable "organization_structure" {
  description = "Organization structure configuration"
  type = object({
    sites = list(string)
    buildings = map(object({
      site          = string
      address       = string
      city          = string
      state         = string
      zip           = string
    }))
    departments = list(string)
  })
  
  default = {
    sites = ["Corporate HQ", "West Coast Office"]
    
    buildings = {
      "Main Campus" = {
        site    = "Corporate HQ"
        address = "123 Enterprise Way"
        city    = "San Francisco"
        state   = "California"
        zip     = "94105"
      }
      "Innovation Center" = {
        site    = "West Coast Office"
        address = "456 Tech Boulevard"
        city    = "Seattle"
        state   = "Washington"
        zip     = "98101"
      }
    }
    
    departments = ["Engineering", "Marketing", "Sales", "IT", "Finance"]
  }
}

variable "application_catalog" {
  description = "Enterprise application catalog"
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
    "Xcode" = {
      deployment_type = "Make Available in Self Service"
      category        = "Development"
      self_service    = true
      required_for    = ["Engineering"]
    }
    "Adobe Creative Suite" = {
      deployment_type = "Make Available in Self Service"
      category        = "Creative"
      self_service    = true
      required_for    = ["Marketing"]
    }
  }
}

variable "enable_development_testing" {
  description = "Enable development environment testing"
  type        = bool
  default     = false
}
```

**Step 4: Main Configuration (`main.tf`)**
```hcl
# Random suffix for unique naming
resource "random_id" "suffix" {
  byte_length = 4
}

# Organizational Foundation - Sites
resource "jamfpro_site" "organization_sites" {
  for_each = toset(var.organization_structure.sites)
  
  name = each.key
}

# Buildings with explicit dependencies
resource "jamfpro_building" "organization_buildings" {
  for_each = var.organization_structure.buildings
  
  name            = each.key
  street_address1 = each.value.address
  city            = each.value.city
  state_province  = each.value.state
  zip_postal_code = each.value.zip
  country         = "United States"
  
  # Explicit dependency on sites
  depends_on = [jamfpro_site.organization_sites]
}

# Departments
resource "jamfpro_department" "organization_departments" {
  count = length(var.organization_structure.departments)
  
  name = var.organization_structure.departments[count.index]
}

# Categories for applications using for_each
locals {
  app_categories = toset([for app in var.application_catalog : app.category])
}

resource "jamfpro_category" "app_categories" {
  for_each = local.app_categories
  
  name     = each.key
  priority = 5
}

# Smart computer groups for each department using count
resource "jamfpro_smart_computer_group" "department_groups" {
  count = length(var.organization_structure.departments)
  
  name    = "${var.organization_structure.departments[count.index]} Computers"
  site_id = jamfpro_site.organization_sites[var.organization_structure.sites[0]].id
  
  # Explicit dependencies on organizational structure
  depends_on = [
    jamfpro_site.organization_sites,
    jamfpro_department.organization_departments
  ]
  
  criteria {
    name        = "Department"
    priority    = 0
    and_or      = "and"
    search_type = "is"
    value       = var.organization_structure.departments[count.index]
  }
}

# Computer extension attributes for application tracking
resource "jamfpro_computer_extension_attribute" "app_tracking" {
  for_each = var.application_catalog
  
  name                   = "${each.key} Installation Status"
  enabled                = true
  description            = "Tracks installation status of ${each.key}"
  input_type             = "SCRIPT"
  inventory_display_type = "GENERAL"
  data_type              = "STRING"
  
  script_contents = templatefile("${path.module}/scripts/check_app.sh", {
    app_name = each.key
  })
}

# Enterprise applications using for_each
resource "jamfpro_mac_application" "enterprise_apps" {
  for_each = var.application_catalog
  
  name            = each.key
  deployment_type = each.value.deployment_type
  category_id     = jamfpro_category.app_categories[each.value.category].id
  
  scope {
    all_computers = each.value.deployment_type == "Install Automatically"
    
    # Scope to specific departments if not automatically installed
    computer_group_ids = each.value.deployment_type != "Install Automatically" ? [
      for i, dept in var.organization_structure.departments :
      jamfpro_smart_computer_group.department_groups[i].id
      if contains(each.value.required_for, dept)
    ] : []
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
  
  lifecycle {
    create_before_destroy = true
    # Protect critical applications
    prevent_destroy = contains(["Google Chrome", "Slack"], each.key)
  }
}

# Security baseline policy with lifecycle protection
resource "jamfpro_policy" "security_baseline" {
  name        = "Corporate Security Baseline"
  enabled     = true
  frequency   = "Ongoing"
  category_id = jamfpro_category.app_categories["Security"].id
  
  # Explicit dependencies on foundational resources
  depends_on = [
    jamfpro_smart_computer_group.department_groups,
    jamfpro_category.app_categories
  ]
  
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
  
  lifecycle {
    create_before_destroy = true
    prevent_destroy       = true
    ignore_changes       = [
      scope.computer_ids,  # Computer assignments might change
    ]
  }
}

# Department-specific policies using for_each
resource "jamfpro_policy" "department_policies" {
  for_each = {
    for i, dept in var.organization_structure.departments :
    dept => i
  }
  
  name        = "${each.key} Department Policy"
  enabled     = true
  frequency   = "Once per week"
  category_id = jamfpro_category.app_categories["Productivity"].id
  
  scope {
    computer_group_ids = [jamfpro_smart_computer_group.department_groups[each.value].id]
  }
  
  payloads {
    maintenance {
      recon = true
    }
  }
  
  self_service {
    use_for_self_service            = true
    self_service_display_name       = "${each.key} Maintenance"
    install_button_text             = "Run Maintenance"
    self_service_description        = "Run maintenance tasks for ${each.key} department computers"
    force_users_to_view_description = false
    feature_on_main_page            = false
  }
  
  lifecycle {
    create_before_destroy = true
  }
}

# Development environment testing (conditional)
resource "jamfpro_category" "dev_testing" {
  count    = var.enable_development_testing ? 1 : 0
  provider = jamfpro.development
  
  name     = "Development Testing"
  priority = 10
}

resource "jamfpro_policy" "dev_test_policy" {
  count    = var.enable_development_testing ? 1 : 0
  provider = jamfpro.development
  
  name        = "Development Test Policy"
  enabled     = true
  frequency   = "Ongoing"
  category_id = jamfpro_category.dev_testing[0].id
  
  scope {
    all_computers = true
  }
  
  payloads {
    maintenance {
      recon = true
    }
  }
  
  lifecycle {
    prevent_destroy = false  # Allow destruction in dev environment
  }
}

# Network segments for each building
resource "jamfpro_network_segment" "building_networks" {
  for_each = var.organization_structure.buildings
  
  name             = "${each.key} Network"
  starting_address = "10.${index(keys(var.organization_structure.buildings), each.key) + 1}.0.1"
  ending_address   = "10.${index(keys(var.organization_structure.buildings), each.key) + 1}.0.254"
  building         = each.key
  
  # Explicit dependency on buildings
  depends_on = [jamfpro_building.organization_buildings]
}
```

**Step 5: Create Application Check Script (`scripts/check_app.sh`)**
```bash
#!/bin/bash

# Check if application is installed
APP_NAME="${app_name}"
APP_PATH="/Applications/$APP_NAME.app"

if [ -d "$APP_PATH" ]; then
    # Get version if available
    VERSION=$(defaults read "$APP_PATH/Contents/Info.plist" CFBundleShortVersionString 2>/dev/null)
    if [ -n "$VERSION" ]; then
        echo "Installed - Version $VERSION"
    else
        echo "Installed - Version Unknown"
    fi
else
    echo "Not Installed"
fi
```

**Step 6: Outputs (`outputs.tf`)**
```hcl
output "organizational_structure" {
  description = "Created organizational structure"
  value = {
    sites = {
      for site_name, site in jamfpro_site.organization_sites :
      site_name => {
        id   = site.id
        name = site.name
      }
    }
    
    buildings = {
      for building_name, building in jamfpro_building.organization_buildings :
      building_name => {
        id   = building.id
        name = building.name
      }
    }
    
    departments = {
      for i, dept in jamfpro_department.organization_departments :
      var.organization_structure.departments[i] => {
        id   = dept.id
        name = dept.name
      }
    }
  }
}

output "computer_groups" {
  description = "Created computer groups"
  value = {
    for i, group in jamfpro_smart_computer_group.department_groups :
    var.organization_structure.departments[i] => {
      id   = group.id
      name = group.name
    }
  }
}

output "enterprise_applications" {
  description = "Deployed enterprise applications"
  value = {
    for app_name, app in jamfpro_mac_application.enterprise_apps :
    app_name => {
      id              = app.id
      name            = app.name
      deployment_type = app.deployment_type
      category_id     = app.category_id
    }
  }
}

output "policies" {
  description = "Created policies"
  value = {
    security_baseline = {
      id   = jamfpro_policy.security_baseline.id
      name = jamfpro_policy.security_baseline.name
    }
    
    department_policies = {
      for dept, policy in jamfpro_policy.department_policies :
      dept => {
        id   = policy.id
        name = policy.name
      }
    }
  }
}

output "network_segments" {
  description = "Created network segments"
  value = {
    for building, segment in jamfpro_network_segment.building_networks :
    building => {
      id               = segment.id
      name             = segment.name
      starting_address = segment.starting_address
      ending_address   = segment.ending_address
    }
  }
}

output "development_resources" {
  description = "Development environment resources (if enabled)"
  value = var.enable_development_testing ? {
    test_category = {
      id   = jamfpro_category.dev_testing[0].id
      name = jamfpro_category.dev_testing[0].name
    }
    test_policy = {
      id   = jamfpro_policy.dev_test_policy[0].id
      name = jamfpro_policy.dev_test_policy[0].name
    }
  } : null
}
```

**Step 7: Deploy and Test**

First, set up the required environment variables for the Jamf Pro provider:

```bash
# Set Jamf Pro credentials via environment variables
export JAMFPRO_INSTANCE_NAME=your-instance-name
export JAMFPRO_CLIENT_ID=your-client-id
export JAMFPRO_CLIENT_SECRET=your-client-secret
```

**Initialize Terraform:**
```bash
terraform init
```

**Expected Output:**
```
Initializing the backend...
Initializing provider plugins...
- Finding deploymenttheory/jamfpro versions matching "~> 0.0.1"...
- Finding hashicorp/random versions matching "~> 3.4"...
- Installing hashicorp/random v3.7.2...
- Installed hashicorp/random v3.7.2 (signed by HashiCorp)
- Installing deploymenttheory/jamfpro v0.0.58...
- Installed deploymenttheory/jamfpro v0.0.58 (self-signed, key ID DB95CA76A94A208C)

Terraform has been successfully initialized!
```

**Plan with development testing disabled:**
```bash
terraform plan
```

**Expected Output (showing key resources):**
```
Terraform will perform the following actions:

  # jamfpro_building.organization_buildings["Innovation Center"] will be created
  + resource "jamfpro_building" "organization_buildings" {
      + city            = "Seattle"
      + country         = "United States"
      + id              = (known after apply)
      + name            = "Innovation Center"
      + state_province  = "Washington"
      + street_address1 = "456 Tech Boulevard"
      + zip_postal_code = "98101"
    }

  # jamfpro_building.organization_buildings["Main Campus"] will be created
  + resource "jamfpro_building" "organization_buildings" {
      + city            = "San Francisco"
      + country         = "United States"
      + id              = (known after apply)
      + name            = "Main Campus"
      + state_province  = "California"
      + street_address1 = "123 Enterprise Way"
      + zip_postal_code = "94105"
    }

  # jamfpro_department.organization_departments[0] will be created
  + resource "jamfpro_department" "organization_departments" {
      + id   = (known after apply)
      + name = "Engineering"
    }

  # jamfpro_department.organization_departments[1] will be created
  + resource "jamfpro_department" "organization_departments" {
      + id   = (known after apply)
      + name = "Marketing"
    }

  # jamfpro_policy.department_policies["Engineering"] will be created
  + resource "jamfpro_policy" "department_policies" {
      + enabled     = true
      + frequency   = "Once every week"
      + name        = "Engineering Department Policy"
      + scope {
          + all_computers      = false
          + computer_group_ids = (known after apply)
        }
    }

Plan: 28 to add, 0 to change, 0 to destroy.
```

**Test with development environment enabled:**
```bash
terraform plan -var="enable_development_testing=true"
```

**Expected Output:**
```
Plan: 30 to add, 0 to change, 0 to destroy.

Changes to Outputs:
+ development_resources = {
    + test_category = {
        + id   = (known after apply)
        + name = "Development Testing"
      }
    + test_policy = {
        + id   = (known after apply)
        + name = "Development Test Policy"
      }
  }
```

Notice how enabling development testing increases the resource count from 28 to 30, demonstrating conditional resource creation with `count`.

**Apply the configuration:**
```bash
terraform apply
```

**View all outputs:**
```bash
terraform output
```

**Expected Output:**
```
application_categories = {
  "Communication" = {
    "id" = 123
    "name" = "Communication"
    "priority" = 5
  }
  "Development" = {
    "id" = 124
    "name" = "Development"
    "priority" = 5
  }
  # ... more categories
}

computer_groups = {
  "Engineering" = {
    "id" = 456
    "name" = "Engineering Computers"
  }
  "Finance" = {
    "id" = 457
    "name" = "Finance Computers"
  }
  # ... more groups
}

organizational_structure = {
  "buildings" = {
    "Innovation Center" = {
      "id" = 789
      "name" = "Innovation Center"
    }
    "Main Campus" = {
      "id" = 790
      "name" = "Main Campus"
    }
  }
  "departments" = {
    "Engineering" = {
      "id" = 101
      "name" = "Engineering"
    }
    # ... more departments
  }
  "sites" = {
    "Corporate HQ" = {
      "id" = 1
      "name" = "Corporate HQ"
    }
    "West Coast Office" = {
      "id" = 2
      "name" = "West Coast Office"
    }
  }
}
```

**Clean up resources when done:**
```bash
terraform destroy
```

**🔍 What This Exercise Demonstrates:**

1. **`depends_on`**: Explicit dependencies between organizational structure, groups, and policies
2. **`count`**: Creating multiple departments and groups with numeric indexing
3. **`for_each`**: Dynamic creation of sites, applications, and department-specific resources
4. **`provider`**: Multi-environment deployment with production and development instances
5. **`lifecycle`**: Resource protection for critical policies and applications

💡 **Pro Tip**: This exercise demonstrates real-world Jamf Pro patterns used in enterprise environments. The meta arguments ensure proper resource ordering, stable management, and protection of critical configurations!

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

