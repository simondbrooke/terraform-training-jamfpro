# Random suffix for unique naming
resource "random_string" "suffix" {
  length  = 6
  upper   = false
  special = false
}

# Local values for computed expressions
locals {
  # Simple computed value
  resource_prefix = "${var.environment}-${random_string.suffix.result}"
  
  # Conditional logic
  is_production = var.environment == "prod"
  
  # Calculations with lists and maps
  total_departments = length(var.department_list)
  total_employees   = sum(values(var.team_sizes))
  
  # String manipulation
  department_upper = upper(var.department_name)
  department_lower = lower(var.department_name)
  
  # Complex conditional
  environment_config = local.is_production ? {
    backup_enabled     = true
    monitoring_level   = "detailed"
    retention_days     = 90
  } : {
    backup_enabled     = false
    monitoring_level   = "basic"
    retention_days     = 30
  }
  
  # Common tags that can be reused
  common_tags = {
    Environment   = var.environment
    Department    = var.department_name
    ManagedBy     = "Terraform"
    Project       = "Department-Management"
    CreatedDate   = formatdate("YYYY-MM-DD", timestamp())
  }
}

# Create extension attribute using local values
resource "jamfpro_computer_extension_attribute" "department_info" {
  name        = "DeptInfo-${local.resource_prefix}"
  enabled     = var.is_active
  description = "Department: ${local.department_upper}, Total Depts: ${local.total_departments}, Total Employees: ${local.total_employees}, Production: ${local.is_production}"
  input_type  = "TEXT"
  inventory_display_type = "USER_AND_LOCATION"
  data_type   = "STRING"
}
