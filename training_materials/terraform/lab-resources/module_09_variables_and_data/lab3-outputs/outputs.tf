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
