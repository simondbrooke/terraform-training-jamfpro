# Show all local values
output "local_values" {
  description = "All computed local values"
  value = {
    resource_prefix     = local.resource_prefix
    is_production      = local.is_production
    total_departments  = local.total_departments
    total_employees    = local.total_employees
    department_upper   = local.department_upper
    department_lower   = local.department_lower
    environment_config = local.environment_config
    common_tags        = local.common_tags
  }
}

# Show extension attribute information
output "extension_attribute_info" {
  description = "Information about the created extension attribute"
  value = {
    id          = jamfpro_computer_extension_attribute.department_info.id
    name        = jamfpro_computer_extension_attribute.department_info.name
    description = jamfpro_computer_extension_attribute.department_info.description
    enabled     = jamfpro_computer_extension_attribute.department_info.enabled
  }
}

# Show environment-specific configuration
output "environment_specific_config" {
  description = "Configuration based on environment"
  value = {
    environment        = var.environment
    is_production     = local.is_production
    backup_enabled    = local.environment_config.backup_enabled
    monitoring_level  = local.environment_config.monitoring_level
    retention_days    = local.environment_config.retention_days
  }
}
