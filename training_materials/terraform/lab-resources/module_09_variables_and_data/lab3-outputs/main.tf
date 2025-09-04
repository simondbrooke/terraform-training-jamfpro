# Random suffix for unique naming
resource "random_string" "suffix" {
  length  = 6
  upper   = false
  special = false
}

# Create multiple extension attributes
resource "jamfpro_computer_extension_attribute" "department" {
  name        = "Department-${var.environment}-${random_string.suffix.result}"
  enabled     = var.is_active
  description = "Employee department"
  input_type  = "TEXT"
  inventory_display_type = "USER_AND_LOCATION"
  data_type   = "STRING"
}

resource "jamfpro_computer_extension_attribute" "location" {
  name        = "Location-${var.environment}-${random_string.suffix.result}"
  enabled     = var.is_active
  description = "Office location"
  input_type  = "TEXT"
  inventory_display_type = "USER_AND_LOCATION"
  data_type   = "STRING"
}
