# Show all created extension attribute names by department
output "extension_attributes_by_department" {
  description = "Extension attributes organized by department"
  value = {
    for dept, attr in jamfpro_computer_extension_attribute.department_attributes : 
    dept => {
      id          = attr.id
      name        = attr.name
      code        = var.department_codes[dept]
      manager     = var.department_managers[dept]
      team_size   = var.team_sizes[dept]
    }
  }
}

# Show map information
output "map_information" {
  description = "Information about our maps"
  value = {
    department_codes    = var.department_codes
    department_keys     = keys(var.department_codes)
    department_values   = values(var.department_codes)
    total_departments   = length(var.department_codes)
    engineering_code    = var.department_codes["engineering"]
    sales_team_size     = var.team_sizes["sales"]
    hr_manager          = var.department_managers["hr"]
  }
}

# Show extension attribute names as a list
output "all_extension_attribute_names" {
  description = "List of all extension attribute names"
  value       = [for attr in jamfpro_computer_extension_attribute.department_attributes : attr.name]
}
