# Random suffix for unique naming
resource "random_string" "suffix" {
  length  = 6
  upper   = false
  special = false
}

# Create extension attributes for each department using count
resource "jamfpro_computer_extension_attribute" "department_attributes" {
  count       = length(var.department_list)
  name        = "${var.department_list[count.index]}-${var.environment}-${random_string.suffix.result}"
  enabled     = var.is_active
  description = "Extension attribute for ${var.department_list[count.index]} department"
  input_type  = "POPUP_MENU"
  inventory_display_type = "USER_AND_LOCATION"
  data_type   = "STRING"
  
  # Use office locations as popup menu choices
  popup_menu_choices = var.office_locations
}
