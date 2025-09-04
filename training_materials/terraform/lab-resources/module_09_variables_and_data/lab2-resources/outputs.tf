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
