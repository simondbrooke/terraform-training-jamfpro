# Random suffix for unique naming
resource "random_string" "suffix" {
  length  = 6
  upper   = false
  special = false
}

# Create extension attributes for each department using for_each with maps
resource "jamfpro_computer_extension_attribute" "department_attributes" {
  for_each = var.department_codes
  
  name        = "${each.value}-${each.key}-${var.environment}-${random_string.suffix.result}"
  enabled     = var.is_active
  description = "Extension attribute for ${each.key} department (${each.value}) - Manager: ${var.department_managers[each.key]}, Team Size: ${var.team_sizes[each.key]}"
  input_type  = "TEXT"
  inventory_display_type = "USER_AND_LOCATION"
  data_type   = "STRING"
}
