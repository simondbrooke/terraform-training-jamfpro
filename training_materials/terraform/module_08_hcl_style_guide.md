# Module 08: Terraform Style Guide

## 🎯 Learning Objectives
By the end of this module, you will:
- Apply HashiCorp's official Terraform style conventions
- Organize JamfPro infrastructure code using best practices
- Implement consistent naming conventions and formatting
- Structure configuration files for maintainability
- Use automated tools to enforce code quality

## 📚 Overview

This module follows the [official HashiCorp Terraform Style Guide](https://developer.hashicorp.com/terraform/language/expressions/version-constraints) to teach best practices for writing clean, maintainable Terraform configurations for JamfPro infrastructure.

---

## 🎨 Code Formatting

### Indentation and Alignment

**Use two spaces for each nesting level:**
```hcl
resource "jamfpro_category" "security" {
  name     = "Security Tools"
  priority = 10

  # Nested blocks use two additional spaces
  lifecycle {
    prevent_destroy = true
  }
}
```

**Align equals signs for consecutive single-line arguments:**
```hcl
# ✅ Good - Aligned equals signs
resource "jamfpro_computer_group" "mobile_devices" {
  name         = "Mobile Devices"
  is_smart     = true
  site_id      = -1
  criteria_set = "AND"

  criteria {
    name      = "Computer Group"
    priority  = 0
    and_or    = "and"
    search_type = "is"
    value     = "Mobile Computer Group"
  }
}

# ❌ Bad - Unaligned equals signs  
resource "jamfpro_computer_group" "mobile_devices" {
  name = "Mobile Devices"
  is_smart = true
  site_id = -1
  criteria_set = "AND"
}
```

### Blank Lines and Organization

**Use blank lines to separate logical groups:**
```hcl
resource "jamfpro_policy" "security_updates" {
  # Basic policy configuration
  name        = "Security Updates"
  enabled     = true
  trigger_checkin = true
  
  # Frequency settings
  frequency   = "Ongoing"
  retry_event = "none"
  retry_attempts = -1
  
  # Scope configuration
  scope {
    all_computers = false
    
    computer_groups = [
      jamfpro_computer_group.workstations.id,
      jamfpro_computer_group.servers.id
    ]
  }
  
  # Package deployment
  package_configuration {
    packages {
      id     = jamfpro_package.security_patch.id
      action = "Install"
    }
  }
}
```

**Place meta-arguments first:**
```hcl
resource "jamfpro_building" "headquarters" {
  # Meta-arguments first
  count      = var.multi_site ? 1 : 0
  depends_on = [jamfpro_site.primary]
  
  # Regular arguments
  name    = "Headquarters"
  street_address1 = "123 Main St"
  city    = "San Francisco"
  state   = "CA"
  zip_postal_code = "94102"
}
```

---

## 📝 Naming Conventions

### Resource Names

**Use descriptive nouns, avoid including resource type:**
```hcl
# ✅ Good - Descriptive noun
resource "jamfpro_category" "security_tools" {
  name = "Security Tools"
}

# ❌ Bad - Includes resource type
resource "jamfpro_category" "category_security_tools" {
  name = "Security Tools"
}

# ✅ Good - Multiple words with underscores
resource "jamfpro_computer_group" "compliance_workstations" {
  name     = "Compliance Workstations"
  is_smart = true
}

# ❌ Bad - CamelCase or hyphens
resource "jamfpro_computer_group" "ComplianceWorkstations" {
  name = "Compliance Workstations"
}

resource "jamfpro_computer_group" "compliance-workstations" {
  name = "Compliance Workstations"
}
```

### Variable Naming

**Use descriptive names with type and description:**
```hcl
# ✅ Good - Clear description and appropriate type
variable "jamfpro_instance_url" {
  description = "The FQDN of the JamfPro instance"
  type        = string
  validation {
    condition     = can(regex("^https://", var.jamfpro_instance_url))
    error_message = "JamfPro instance URL must start with https://."
  }
}

variable "policy_deployment_schedule" {
  description = "Deployment schedule for policies in cron format"
  type        = string
  default     = "0 2 * * *"  # 2 AM daily
}

variable "computer_group_criteria" {
  description = "Criteria for smart computer groups"
  type = object({
    operating_system = string
    department      = string
    minimum_os      = string
  })
  default = {
    operating_system = "Mac"
    department      = "IT"
    minimum_os      = "13.0"
  }
}

# ❌ Bad - Vague description, missing type
variable "url" {
  description = "URL"
}
```

### Output Naming

**Include clear descriptions for all outputs:**
```hcl
# ✅ Good - Descriptive names and descriptions
output "security_category_id" {
  description = "ID of the security tools category for referencing in policies"
  value       = jamfpro_category.security_tools.id
}

output "workstation_group_membership_count" {
  description = "Number of computers in the workstation group"
  value       = length(jamfpro_computer_group.workstations.computers)
}

output "policy_deployment_summary" {
  description = "Summary of deployed policies including names and IDs"
  value = {
    for policy in [
      jamfpro_policy.security_updates,
      jamfpro_policy.software_installation,
      jamfpro_policy.configuration_profile
    ] : policy.name => {
      id      = policy.id
      enabled = policy.enabled
      scope   = policy.scope
    }
  }
}

# ❌ Bad - Missing descriptions
output "cat_id" {
  value = jamfpro_category.security_tools.id
}
```

---

## 📁 File Organization

### Recommended File Structure

Organize your JamfPro Terraform configuration using this structure:

```
jamfpro-infrastructure/
├── backend.tf              # Backend configuration
├── main.tf                 # Primary resource definitions  
├── variables.tf            # Input variable declarations
├── outputs.tf              # Output value declarations
├── locals.tf               # Local value definitions
├── providers.tf            # Provider configurations
├── terraform.tf            # Terraform and provider versions
├── data.tf                 # Data source declarations
└── versions.tf             # Version constraints (alternative to terraform.tf)
```

### backend.tf
```hcl
# Backend configuration for state management
terraform {
  backend "s3" {
    bucket         = "jamfpro-terraform-state"
    key            = "infrastructure/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "jamfpro-terraform-locks"
    encrypt        = true
  }
}
```

### terraform.tf
```hcl
# Terraform and provider version requirements
terraform {
  required_version = ">= 1.5"
  
  required_providers {
    jamfpro = {
      source  = "deploymenttheory/jamfpro"
      version = "~> 0.24.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.4"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
  }
}
```

### providers.tf
```hcl
# JamfPro provider configuration
provider "jamfpro" {
  jamfpro_instance_fqdn      = var.jamfpro_instance_url
  auth_method                = var.jamfpro_auth_method
  client_id                  = var.jamfpro_client_id
  client_secret              = var.jamfpro_client_secret
  jamfpro_load_balancer_lock = var.enable_load_balancer_lock
}

# Random provider for generating unique identifiers
provider "random" {}

# TLS provider for certificate management
provider "tls" {}
```

### variables.tf
```hcl
# JamfPro instance configuration
variable "jamfpro_instance_url" {
  description = "The FQDN of the JamfPro instance (e.g., https://company.jamfcloud.com)"
  type        = string
  
  validation {
    condition     = can(regex("^https://[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$", var.jamfpro_instance_url))
    error_message = "JamfPro instance URL must be a valid HTTPS URL."
  }
}

variable "jamfpro_auth_method" {
  description = "Authentication method for JamfPro API (oauth2 or basic_auth)"
  type        = string
  default     = "oauth2"
  
  validation {
    condition     = contains(["oauth2", "basic_auth"], var.jamfpro_auth_method)
    error_message = "Auth method must be either 'oauth2' or 'basic_auth'."
  }
}

variable "jamfpro_client_id" {
  description = "Client ID for JamfPro API authentication"
  type        = string
  sensitive   = true
}

variable "jamfpro_client_secret" {
  description = "Client secret for JamfPro API authentication"  
  type        = string
  sensitive   = true
}

variable "enable_load_balancer_lock" {
  description = "Enable load balancer locking for JamfPro API requests"
  type        = bool
  default     = true
}

# Environment configuration
variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be one of: dev, staging, prod."
  }
}

variable "organization_name" {
  description = "Name of the organization for resource naming"
  type        = string
}

# Infrastructure configuration
variable "building_locations" {
  description = "List of building locations to create in JamfPro"
  type = list(object({
    name            = string
    street_address1 = string
    city            = string
    state_province  = string
    zip_postal_code = string
    country         = string
  }))
  default = []
}

variable "department_structure" {
  description = "Organizational departments to create in JamfPro"
  type = list(object({
    name = string
  }))
  default = [
    { name = "IT" },
    { name = "Finance" },
    { name = "HR" },
    { name = "Marketing" },
    { name = "Sales" }
  ]
}
```

### locals.tf
```hcl
# Local values for computed expressions and reusable data
locals {
  # Environment-specific naming prefix
  name_prefix = "${var.organization_name}-${var.environment}"
  
  # Common tags for all resources
  common_tags = {
    Environment   = var.environment
    Organization  = var.organization_name
    ManagedBy    = "terraform"
    Project      = "jamfpro-infrastructure"
    CreatedDate  = timestamp()
  }
  
  # Standard categories for JamfPro organization
  standard_categories = {
    security = {
      name     = "Security Tools"
      priority = 10
    }
    productivity = {
      name     = "Productivity Software"
      priority = 20
    }
    utilities = {
      name     = "System Utilities"
      priority = 30
    }
    development = {
      name     = "Development Tools"
      priority = 40
    }
  }
  
  # Smart group criteria templates
  smart_group_criteria = {
    macos_workstations = {
      name        = "macOS Workstations"
      criteria_set = "AND"
      criteria = [
        {
          name         = "Operating System"
          search_type  = "is"
          value        = "Mac"
          priority     = 0
          and_or       = "and"
        },
        {
          name         = "Computer Group"
          search_type  = "is not"
          value        = "Servers"
          priority     = 1
          and_or       = "and"
        }
      ]
    }
  }
  
  # Policy configuration templates
  policy_defaults = {
    frequency             = "Ongoing"
    trigger_checkin      = true
    trigger_enrollment_complete = true
    retry_event          = "none"
    retry_attempts       = -1
    notify_on_each_failed_retry = false
  }
}
```

### main.tf
```hcl
# Primary JamfPro infrastructure resources

# Random suffix for unique resource naming
resource "random_id" "suffix" {
  byte_length = 4
}

# JamfPro Buildings
resource "jamfpro_building" "locations" {
  count = length(var.building_locations)
  
  name            = var.building_locations[count.index].name
  street_address1 = var.building_locations[count.index].street_address1
  city            = var.building_locations[count.index].city
  state_province  = var.building_locations[count.index].state_province
  zip_postal_code = var.building_locations[count.index].zip_postal_code
  country         = var.building_locations[count.index].country
}

# JamfPro Departments
resource "jamfpro_department" "organizational" {
  count = length(var.department_structure)
  
  name = var.department_structure[count.index].name
}

# JamfPro Categories
resource "jamfpro_category" "standard" {
  for_each = local.standard_categories
  
  name     = "${local.name_prefix}-${each.value.name}"
  priority = each.value.priority
}

# Computer Groups - All Computers
resource "jamfpro_computer_group" "all_managed" {
  name         = "${local.name_prefix}-All Managed Computers"
  is_smart     = false
  site_id      = -1
}

# Smart Computer Groups - macOS Workstations
resource "jamfpro_computer_group" "macos_workstations" {
  name         = "${local.name_prefix}-${local.smart_group_criteria.macos_workstations.name}"
  is_smart     = true
  site_id      = -1
  criteria_set = local.smart_group_criteria.macos_workstations.criteria_set
  
  dynamic "criteria" {
    for_each = local.smart_group_criteria.macos_workstations.criteria
    content {
      name        = criteria.value.name
      search_type = criteria.value.search_type
      value       = criteria.value.value
      priority    = criteria.value.priority
      and_or      = criteria.value.and_or
    }
  }
}

# Security Policy
resource "jamfpro_policy" "security_baseline" {
  name    = "${local.name_prefix}-Security Baseline"
  enabled = true
  
  # Meta-arguments
  depends_on = [
    jamfpro_category.standard,
    jamfpro_computer_group.macos_workstations
  ]
  
  # Policy configuration using defaults
  frequency                      = local.policy_defaults.frequency
  trigger_checkin               = local.policy_defaults.trigger_checkin
  trigger_enrollment_complete   = local.policy_defaults.trigger_enrollment_complete
  retry_event                   = local.policy_defaults.retry_event
  retry_attempts                = local.policy_defaults.retry_attempts
  notify_on_each_failed_retry   = local.policy_defaults.notify_on_each_failed_retry
  
  # Categorization
  category_id = jamfpro_category.standard["security"].id
  
  # Scope
  scope {
    all_computers = false
    
    computer_groups = [
      jamfpro_computer_group.macos_workstations.id
    ]
    
    buildings = [
      for building in jamfpro_building.locations : building.id
    ]
    
    departments = [
      for dept in jamfpro_department.organizational : dept.id
    ]
  }
  
  # General settings
  general {
    name = "${local.name_prefix}-Security Baseline"
    enabled = true
    trigger_checkin = true
    trigger_enrollment_complete = true
    frequency = "Ongoing"
    retry_event = "none"
    retry_attempts = -1
    notify_on_each_failed_retry = false
    category_id = jamfpro_category.standard["security"].id
    
    # Network limitations
    network_limitations {
      minimum_network_connection = "No Minimum"
      any_ip_address = true
    }
  }
}
```

### data.tf
```hcl
# Data sources for existing JamfPro resources

# Retrieve existing site information
data "jamfpro_site" "default" {
  name = "None"
}

# Get current JamfPro version information
data "jamfpro_jamf_pro_version" "current" {}

# Retrieve existing computer groups for reference
data "jamfpro_computer_group" "existing_groups" {
  count = length(var.existing_group_names)
  name  = var.existing_group_names[count.index]
}
```

### outputs.tf
```hcl
# Infrastructure outputs for reference and integration

# Building information
output "building_details" {
  description = "Details of all created buildings including IDs and addresses"
  value = {
    for building in jamfpro_building.locations : building.name => {
      id      = building.id
      name    = building.name
      address = "${building.street_address1}, ${building.city}, ${building.state_province}"
    }
  }
}

# Department information
output "department_ids" {
  description = "Map of department names to their JamfPro IDs"
  value = {
    for dept in jamfpro_department.organizational : dept.name => dept.id
  }
}

# Category information
output "category_mapping" {
  description = "Mapping of category types to their JamfPro IDs for policy assignment"
  value = {
    for key, category in jamfpro_category.standard : key => {
      id       = category.id
      name     = category.name
      priority = category.priority
    }
  }
}

# Computer group information
output "computer_group_summary" {
  description = "Summary of computer groups for inventory and policy targeting"
  value = {
    all_managed = {
      id        = jamfpro_computer_group.all_managed.id
      name      = jamfpro_computer_group.all_managed.name
      is_smart  = jamfpro_computer_group.all_managed.is_smart
    }
    macos_workstations = {
      id        = jamfpro_computer_group.macos_workstations.id
      name      = jamfpro_computer_group.macos_workstations.name
      is_smart  = jamfpro_computer_group.macos_workstations.is_smart
      criteria_count = length(local.smart_group_criteria.macos_workstations.criteria)
    }
  }
}

# Policy information
output "security_policy_details" {
  description = "Details of the security baseline policy for reference"
  value = {
    id              = jamfpro_policy.security_baseline.id
    name            = jamfpro_policy.security_baseline.name
    enabled         = jamfpro_policy.security_baseline.enabled
    category_id     = jamfpro_policy.security_baseline.category_id
    frequency       = jamfpro_policy.security_baseline.frequency
  }
}

# Environment information
output "environment_summary" {
  description = "Summary of the deployed environment configuration"
  value = {
    environment       = var.environment
    organization     = var.organization_name
    name_prefix      = local.name_prefix
    buildings_count  = length(jamfpro_building.locations)
    departments_count = length(jamfpro_department.organizational)
    categories_count = length(jamfpro_category.standard)
    jamfpro_version  = data.jamfpro_jamf_pro_version.current.version
  }
}
```

---

## 🛠 Best Practices

### Resource Dependencies

**Define dependent resources after the resources they reference:**
```hcl
# ✅ Good - Category defined before policy that uses it
resource "jamfpro_category" "security" {
  name     = "Security Tools"
  priority = 10
}

resource "jamfpro_policy" "antivirus_installation" {
  name        = "Install Antivirus"
  enabled     = true
  category_id = jamfpro_category.security.id  # References category above
  
  scope {
    all_computers = true
  }
}

# ❌ Bad - Policy references category defined later
resource "jamfpro_policy" "antivirus_installation" {
  name        = "Install Antivirus" 
  category_id = jamfpro_category.security.id  # Forward reference
}

resource "jamfpro_category" "security" {
  name     = "Security Tools"
  priority = 10
}
```

### Variable Usage

**Avoid overusing variables - use them strategically:**
```hcl
# ✅ Good - Variables for values that change between environments
variable "jamfpro_instance_url" {
  description = "JamfPro instance URL"
  type        = string
}

variable "environment" {
  description = "Environment (dev/staging/prod)"
  type        = string
}

# ✅ Good - Variables for repeated values
variable "default_policy_frequency" {
  description = "Default frequency for policies"
  type        = string
  default     = "Ongoing"
}

# ❌ Bad - Unnecessary variable for static value
variable "antivirus_policy_name" {
  description = "Name of antivirus policy"
  type        = string  
  default     = "Install Antivirus"  # This never changes
}

# Better - Use local or hardcode
resource "jamfpro_policy" "antivirus" {
  name = "Install Antivirus"  # Static value, no variable needed
}
```

### Provider Configuration

**Always include a default provider configuration:**
```hcl
# ✅ Good - Default provider with all required settings
provider "jamfpro" {
  jamfpro_instance_fqdn      = var.jamfpro_instance_url
  auth_method                = var.jamfpro_auth_method
  client_id                  = var.jamfpro_client_id
  client_secret              = var.jamfpro_client_secret
  jamfpro_load_balancer_lock = true
}

# ❌ Bad - Missing configuration
provider "jamfpro" {}
```

### Count and For_Each Usage

**Use count and for_each sparingly and appropriately:**
```hcl
# ✅ Good - for_each with known map structure
resource "jamfpro_category" "standard_categories" {
  for_each = {
    security     = { name = "Security Tools", priority = 10 }
    productivity = { name = "Productivity", priority = 20 }
    utilities    = { name = "Utilities", priority = 30 }
  }
  
  name     = each.value.name
  priority = each.value.priority
}

# ✅ Good - count with conditional creation
resource "jamfpro_building" "headquarters" {
  count = var.create_headquarters ? 1 : 0
  
  name = "Headquarters"
  city = "San Francisco"
}

# ❌ Bad - Overcomplicating simple resources
resource "jamfpro_category" "simple" {
  count = 1
  
  name     = "Security Tools"
  priority = 10
}
```

---

## ⚙️ Automated Code Quality

### Terraform Format and Validation

**Always run these commands before committing:**
```bash
# Format code to follow style conventions
terraform fmt -recursive

# Validate configuration syntax
terraform validate

# Check for potential issues
terraform plan
```

### Pre-commit Hooks

**Example pre-commit configuration for Terraform:**
```yaml
# .pre-commit-config.yaml
repos:
  - repo: https://github.com/antonbabenko/pre-commit-terraform
    rev: v1.83.5
    hooks:
      - id: terraform_fmt
      - id: terraform_validate
      - id: terraform_docs
      - id: terraform_tflint
```

---

## 🧪 Hands-on Exercises

### Exercise 1: Fix Formatting Issues
**Duration**: 5 minutes

**Task**: Fix the formatting in this poorly formatted configuration

**Step 1**: Create a poorly formatted file
```hcl
# Poorly formatted Terraform code - Exercise 1
resource "jamfpro_category"     "security_tools"{
name="Security Tools"
     priority=10
}

resource "jamfpro_computer_group" "workstations" {
name = "Workstations"
is_smart=true
site_id=-1
criteria_set="AND"

criteria {
name="Operating System"
priority=0
and_or="and"
search_type="is"
value="Mac"
}

criteria{
name         =     "Computer Group"
priority     =   1
and_or="and"
search_type="is not"
value="Servers"
}
}

resource "jamfpro_policy" "security_policy"{
depends_on = [jamfpro_category.security_tools]
count=var.enable_policy ? 1:0

name="Security Policy"
enabled=true
trigger_checkin=true

frequency="Ongoing"
retry_event="none"
retry_attempts=-1

category_id=jamfpro_category.security_tools.id
}
```

**Step 2**: Run terraform fmt
```bash
terraform fmt
```
**Expected Output:**
```
poorly_formatted.tf
```

**Step 3**: View the formatted result
```hcl
# Poorly formatted Terraform code - Exercise 1
resource "jamfpro_category" "security_tools" {
  name     = "Security Tools"
  priority = 10
}

resource "jamfpro_computer_group" "workstations" {
  name         = "Workstations"
  is_smart     = true
  site_id      = -1
  criteria_set = "AND"

  criteria {
    name        = "Operating System"
    priority    = 0
    and_or      = "and"
    search_type = "is"
    value       = "Mac"
  }

  criteria {
    name        = "Computer Group"
    priority    = 1
    and_or      = "and"
    search_type = "is not"
    value       = "Servers"
  }
}

resource "jamfpro_policy" "security_policy" {
  depends_on = [jamfpro_category.security_tools]
  count      = var.enable_policy ? 1 : 0

  name            = "Security Policy"
  enabled         = true
  trigger_checkin = true

  frequency      = "Ongoing"
  retry_event    = "none"
  retry_attempts = -1

  category_id = jamfpro_category.security_tools.id
}
```

**Key improvements:**
- ✅ Proper 2-space indentation
- ✅ Aligned equals signs for consecutive arguments
- ✅ Meta-arguments (depends_on, count) appear first
- ✅ Blank lines separate logical argument groups
- ✅ Consistent spacing around operators

---

### Exercise 2: Improve Naming Conventions
**Duration**: 10 minutes  

**Task**: Refactor resource names to follow best practices

**Step 1**: Review bad naming examples
```hcl
# ❌ Bad naming conventions
resource "jamfpro_category" "SecurityCategory" {  # CamelCase
  name     = "Security Tools"
  priority = 10
}

resource "jamfpro_computer_group" "computer_group_workstations" {  # Includes resource type
  name         = "Workstations"
  is_smart     = true
}

resource "jamfpro_policy" "security-policy" {  # Hyphens instead of underscores
  name        = "Security Policy"
  category_id = jamfpro_category.SecurityCategory.id
}

resource "jamfpro_building" "hq" {  # Unclear abbreviation
  name = "Main Office"
  city = "San Francisco"
}

resource "jamfpro_department" "dept1" {  # Too generic
  name = "IT Department"
}
```

**Step 2**: Apply good naming conventions
```hcl
# ✅ Good naming conventions
resource "jamfpro_category" "security_tools" {  # Descriptive noun, underscores
  name     = "Security Tools"
  priority = 10
}

resource "jamfpro_computer_group" "workstations" {  # Descriptive without resource type
  name         = "Workstations"
  is_smart     = true
}

resource "jamfpro_policy" "security_baseline" {  # Underscores, descriptive
  name        = "Security Policy"
  category_id = jamfpro_category.security_tools.id
}

resource "jamfpro_building" "headquarters" {  # Clear, descriptive name
  name = "Main Office"
  city = "San Francisco"
}

resource "jamfpro_department" "information_technology" {  # Specific and clear
  name = "IT Department"
}
```

**Naming Rules Applied:**
- ✅ Use descriptive nouns for resource names
- ✅ Avoid including resource type in the name
- ✅ Use underscores to separate multiple words
- ✅ Avoid abbreviations unless universally understood
- ✅ Maintain consistent naming patterns

---

### Exercise 3: Organize File Structure
**Duration**: 15 minutes

**Task**: Split a monolithic configuration into properly organized files

**Step 1**: Start with monolithic configuration
```hcl
# monolithic_config.tf - Everything in one file
terraform {
  required_version = ">= 1.5"
  required_providers {
    jamfpro = {
      source  = "deploymenttheory/jamfpro"
      version = "~> 0.24.0"
    }
  }
  backend "s3" {
    bucket = "jamfpro-terraform-state"
    key    = "infrastructure/terraform.tfstate"
    region = "us-west-2"
  }
}

provider "jamfpro" {
  jamfpro_instance_fqdn = var.jamfpro_instance_url
  auth_method          = var.jamfpro_auth_method
}

variable "jamfpro_instance_url" {
  description = "The FQDN of the JamfPro instance"
  type        = string
}

locals {
  name_prefix = "${var.organization_name}-${var.environment}"
  common_tags = {
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}

data "jamfpro_site" "default" {
  name = "None"
}

resource "jamfpro_building" "headquarters" {
  name = "${local.name_prefix}-Headquarters"
  city = "San Francisco"
}

output "building_details" {
  description = "Details of created buildings"
  value = {
    id   = jamfpro_building.headquarters.id
    name = jamfpro_building.headquarters.name
  }
}
```

**Step 2**: Create organized file structure
```bash
mkdir organized_config
cd organized_config
```

**terraform.tf**
```hcl
# Terraform and provider version requirements
terraform {
  required_version = ">= 1.5"
  
  required_providers {
    jamfpro = {
      source  = "deploymenttheory/jamfpro"
      version = "~> 0.24.0"
    }
  }
}
```

**backend.tf**
```hcl
# Backend configuration for state management
terraform {
  backend "s3" {
    bucket = "jamfpro-terraform-state"
    key    = "infrastructure/terraform.tfstate"
    region = "us-west-2"
  }
}
```

**providers.tf**
```hcl
# Provider configurations
provider "jamfpro" {
  jamfpro_instance_fqdn = var.jamfpro_instance_url
  auth_method          = var.jamfpro_auth_method
}
```

**variables.tf**
```hcl
# Input variable declarations
variable "jamfpro_instance_url" {
  description = "The FQDN of the JamfPro instance"
  type        = string
}

variable "organization_name" {
  description = "Organization name"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}
```

**locals.tf**
```hcl
# Local value definitions
locals {
  name_prefix = "${var.organization_name}-${var.environment}"
  
  common_tags = {
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}
```

**data.tf**
```hcl
# Data source declarations
data "jamfpro_site" "default" {
  name = "None"
}
```

**main.tf**
```hcl
# Primary resource definitions
resource "jamfpro_building" "headquarters" {
  name = "${local.name_prefix}-Headquarters"
  city = "San Francisco"
}
```

**outputs.tf**
```hcl
# Output value declarations
output "building_details" {
  description = "Details of created buildings"
  value = {
    id   = jamfpro_building.headquarters.id
    name = jamfpro_building.headquarters.name
  }
}
```

**Benefits of organized structure:**
- ✅ Clear separation of concerns
- ✅ Easy to navigate and maintain
- ✅ Consistent with HashiCorp recommendations
- ✅ Better collaboration in teams
- ✅ Easier to find specific configurations

---

### Exercise 4: Implement Local Values
**Duration**: 10 minutes

**Task**: Replace repeated expressions with local values

**Step 1**: Identify repeated expressions
```hcl
# ❌ Bad - Repeated expressions throughout
variable "organization" {
  default = "ACME Corp"
}

variable "environment" {
  default = "production"
}

resource "jamfpro_building" "headquarters" {
  name = "${var.organization}-${var.environment}-Headquarters"
}

resource "jamfpro_building" "branch_office" {
  name = "${var.organization}-${var.environment}-Branch Office"
}

resource "jamfpro_category" "security" {
  name     = "${var.organization}-${var.environment}-Security Tools"
  priority = 10
}

resource "jamfpro_category" "productivity" {
  name     = "${var.organization}-${var.environment}-Productivity Software"
  priority = 20
}

resource "jamfpro_policy" "security_updates" {
  name            = "${var.organization}-${var.environment}-Security Updates"
  enabled         = true
  trigger_checkin = true
  frequency       = "Ongoing"
  retry_event     = "none"
  retry_attempts  = -1
}

resource "jamfpro_policy" "software_installation" {
  name            = "${var.organization}-${var.environment}-Software Installation"
  enabled         = true
  trigger_checkin = true
  frequency       = "Ongoing"
  retry_event     = "none"
  retry_attempts  = -1
}
```

**Step 2**: Implement local values
```hcl
# ✅ Good - Using local values to eliminate repetition
variable "organization" {
  default = "ACME Corp"
}

variable "environment" {
  default = "production"
}

locals {
  name_prefix = "${var.organization}-${var.environment}"
  
  default_policy_settings = {
    frequency       = "Ongoing"
    retry_event     = "none"
    retry_attempts  = -1
    enabled         = true
    trigger_checkin = true
  }
  
  standard_categories = {
    security = {
      name     = "Security Tools"
      priority = 10
    }
    productivity = {
      name     = "Productivity Software"
      priority = 20
    }
  }
}

resource "jamfpro_building" "headquarters" {
  name = "${local.name_prefix}-Headquarters"
}

resource "jamfpro_building" "branch_office" {
  name = "${local.name_prefix}-Branch Office"
}

resource "jamfpro_category" "standard" {
  for_each = local.standard_categories
  
  name     = "${local.name_prefix}-${each.value.name}"
  priority = each.value.priority
}

resource "jamfpro_policy" "security_updates" {
  name            = "${local.name_prefix}-Security Updates"
  enabled         = local.default_policy_settings.enabled
  trigger_checkin = local.default_policy_settings.trigger_checkin
  frequency       = local.default_policy_settings.frequency
  retry_event     = local.default_policy_settings.retry_event
  retry_attempts  = local.default_policy_settings.retry_attempts
}

resource "jamfpro_policy" "software_installation" {
  name            = "${local.name_prefix}-Software Installation"
  enabled         = local.default_policy_settings.enabled
  trigger_checkin = local.default_policy_settings.trigger_checkin
  frequency       = local.default_policy_settings.frequency
  retry_event     = local.default_policy_settings.retry_event
  retry_attempts  = local.default_policy_settings.retry_attempts
}
```

**Benefits of using locals:**
- ✅ Eliminates code duplication
- ✅ Single source of truth for computed values
- ✅ Easier maintenance and updates
- ✅ Improved consistency across resources
- ✅ More readable configuration

---

### Exercise 5: Add Variable Validation
**Duration**: 8 minutes

**Task**: Add proper validation rules to variables

**Step 1**: Variables without validation
```hcl
# ❌ Bad - No validation
variable "jamfpro_instance_url" {
  description = "JamfPro instance URL"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "category_priority" {
  description = "Category priority"
  type        = number
}

variable "admin_email" {
  description = "Administrator email"
  type        = string
}
```

**Step 2**: Add comprehensive validation
```hcl
# ✅ Good - Proper validation rules
variable "jamfpro_instance_url" {
  description = "JamfPro instance URL (must be HTTPS)"
  type        = string
  
  validation {
    condition     = can(regex("^https://[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$", var.jamfpro_instance_url))
    error_message = "JamfPro instance URL must be a valid HTTPS URL (e.g., https://company.jamfcloud.com)."
  }
}

variable "environment" {
  description = "Environment name (development, staging, or production)"
  type        = string
  
  validation {
    condition     = contains(["development", "staging", "production"], var.environment)
    error_message = "Environment must be one of: development, staging, production."
  }
}

variable "category_priority" {
  description = "Category priority (1-20, where 1 is highest priority)"
  type        = number
  
  validation {
    condition     = var.category_priority >= 1 && var.category_priority <= 20
    error_message = "Category priority must be between 1 and 20 (inclusive)."
  }
}

variable "admin_email" {
  description = "Administrator email address"
  type        = string
  
  validation {
    condition     = can(regex("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$", var.admin_email))
    error_message = "Admin email must be a valid email address format."
  }
}

variable "department_names" {
  description = "List of department names (minimum 1, maximum 50)"
  type        = list(string)
  
  validation {
    condition     = length(var.department_names) >= 1 && length(var.department_names) <= 50
    error_message = "Department names list must contain between 1 and 50 departments."
  }
  
  validation {
    condition = alltrue([
      for dept in var.department_names : can(regex("^[a-zA-Z0-9 .-]+$", dept))
    ])
    error_message = "Department names must contain only letters, numbers, spaces, periods, and hyphens."
  }
}
```

**Step 3**: Test validation
```bash
terraform plan -var="environment=invalid"
```
**Expected Output:**
```
╷
│ Error: Invalid value for variable
│ 
│   on variables.tf line 15:
│   15: variable "environment" {
│      ├────────────────
│      │ var.environment is "invalid"
│ 
│ Environment must be one of: development, staging, production.
╵
```

**Validation benefits:**
- ✅ Prevents invalid configurations
- ✅ Provides clear error messages
- ✅ Catches errors early in the workflow
- ✅ Documents acceptable values
- ✅ Improves user experience

---

### Exercise 6: Create Comprehensive Outputs
**Duration**: 7 minutes

**Task**: Add meaningful outputs with descriptions

**Step 1**: Poor output examples
```hcl
# ❌ Bad outputs - No descriptions, unclear names
output "id" {
  value = jamfpro_category.security.id
}

output "cat_name" {
  value = jamfpro_category.security.name
}

output "building" {
  value = jamfpro_building.headquarters
}
```

**Step 2**: Create comprehensive outputs
```hcl
# ✅ Good outputs - Clear descriptions and meaningful names

# Individual resource outputs
output "security_category_id" {
  description = "ID of the security tools category for use in policy assignments"
  value       = jamfpro_category.security.id
}

output "security_category_details" {
  description = "Complete details of the security tools category"
  value = {
    id       = jamfpro_category.security.id
    name     = jamfpro_category.security.name
    priority = jamfpro_category.security.priority
  }
}

# Structured outputs for external systems
output "headquarters_info" {
  description = "Complete headquarters building information for reference"
  value = {
    id      = jamfpro_building.headquarters.id
    name    = jamfpro_building.headquarters.name
    address = {
      city    = jamfpro_building.headquarters.city
      state   = jamfpro_building.headquarters.state
      country = jamfpro_building.headquarters.country
    }
  }
}

# Aggregated outputs for dashboards
output "infrastructure_summary" {
  description = "High-level summary of JamfPro infrastructure for external integrations"
  value = {
    categories_created = length(jamfpro_category.standard)
    buildings_created  = 1
    policies_created   = 2
    
    active_policies = [
      for policy in [
        jamfpro_policy.security_updates,
        jamfpro_policy.software_installation
      ] : {
        id   = policy.id
        name = policy.name
      } if policy.enabled
    ]
  }
}

# Reference outputs for other Terraform configurations
output "resource_references" {
  description = "Resource references for use in other Terraform configurations"
  value = {
    security_category_id     = jamfpro_category.security.id
    headquarters_building_id = jamfpro_building.headquarters.id
    workstations_group_id   = jamfpro_computer_group.workstations.id
  }
}

# JSON formatted output for external APIs
output "policy_summary_json" {
  description = "Policy summary in JSON format for external APIs"
  value = jsonencode({
    policies = [
      {
        id      = jamfpro_policy.security_updates.id
        name    = jamfpro_policy.security_updates.name
        enabled = jamfpro_policy.security_updates.enabled
      }
    ]
    summary = {
      total_policies   = 1
      enabled_policies = 1
      created_at      = timestamp()
    }
  })
}
```

**Step 3**: View outputs
```bash
terraform output
```
**Expected Output:**
```
headquarters_info = {
  "address" = {
    "city" = "San Francisco"
    "country" = "United States"
    "state" = "CA"
  }
  "id" = "12345"
  "name" = "ACME Corp-production-Headquarters"
}
infrastructure_summary = {
  "active_policies" = [
    {
      "id" = "67890"
      "name" = "ACME Corp-production-Security Updates"
    },
  ]
  "buildings_created" = 1
  "categories_created" = 2
  "policies_created" = 2
}
resource_references = {
  "headquarters_building_id" = "12345"
  "security_category_id" = "54321"
  "workstations_group_id" = "98765"
}
```

**Output best practices:**
- ✅ Always include meaningful descriptions
- ✅ Use descriptive output names
- ✅ Structure complex outputs as objects
- ✅ Provide both detailed and summary outputs
- ✅ Format outputs for external consumption when needed

---

## 📋 Style Checklist

Use this checklist to ensure your Terraform code follows best practices:

### Formatting
- [ ] Code uses 2-space indentation
- [ ] Consecutive arguments are aligned
- [ ] Meta-arguments appear first in blocks
- [ ] Blank lines separate logical groups
- [ ] Run `terraform fmt` before committing

### Naming
- [ ] Resource names use descriptive nouns
- [ ] Resource names use underscores (not hyphens or camelCase)
- [ ] Resource names don't include resource type
- [ ] Variables have type and description
- [ ] Outputs have descriptions

### Organization  
- [ ] Files follow recommended structure
- [ ] Related resources are grouped together
- [ ] Dependencies are clearly defined
- [ ] Provider configuration is complete

### Quality
- [ ] Variables aren't overused
- [ ] Local values reduce duplication
- [ ] Validation rules are present where needed
- [ ] Code passes `terraform validate`
- [ ] Code passes linting tools

---

## 🔍 Additional Resources

- **[Official Terraform Style Guide](https://developer.hashicorp.com/terraform/language/style)**
- **[TFLint - Terraform Linting Tool](https://github.com/terraform-linters/tflint)**
- **[Pre-commit Terraform Hooks](https://github.com/antonbabenko/pre-commit-terraform)**
- **[Terraform Best Practices](https://www.terraform-best-practices.com/)**

---

---

## 🔗 **Next Steps**

Ready to continue your Terraform journey? Proceed to the next module:

**➡️ [Module 9: Meta Arguments](./module_09_meta_arguments.md)**

Master variable management, data sources, and configuration flexibility.

---