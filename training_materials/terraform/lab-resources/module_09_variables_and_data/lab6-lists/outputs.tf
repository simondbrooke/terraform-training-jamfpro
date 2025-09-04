# Show all created extension attribute names
output "extension_attribute_names" {
  description = "Names of all created extension attributes"
  value       = jamfpro_computer_extension_attribute.department_attributes[*].name
}

# Show list information
output "list_information" {
  description = "Information about our lists"
  value = {
    departments     = var.department_list
    total_departments = length(var.department_list)
    office_floors   = var.office_floors
    office_locations = var.office_locations
    first_department = var.department_list[0]
    last_floor      = var.office_floors[length(var.office_floors) - 1]
  }
}

# Show extension attribute details
output "extension_attribute_details" {
  description = "Details of all extension attributes"
  value = {
    for i, attr in jamfpro_computer_extension_attribute.department_attributes : 
    var.department_list[i] => {
      id          = attr.id
      name        = attr.name
      description = attr.description
      enabled     = attr.enabled
    }
  }
}
