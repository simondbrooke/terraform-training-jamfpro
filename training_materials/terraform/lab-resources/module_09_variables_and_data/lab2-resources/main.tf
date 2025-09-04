# Random suffix for unique naming (required for Jamf Pro)
resource "random_string" "suffix" {
  length  = 6
  upper   = false
  special = false
}

# Create an extension attribute using our variables
resource "jamfpro_computer_extension_attribute" "department" {
  name        = "${var.attribute_name}-${var.environment}-${random_string.suffix.result}"
  enabled     = var.is_active
  description = "${var.attribute_description} for ${var.department_name} team"
  input_type  = "TEXT"
  inventory_display_type = "USER_AND_LOCATION"
  data_type   = "STRING"
}
