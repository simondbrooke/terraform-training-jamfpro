# Random suffix for unique naming
resource "random_string" "suffix" {
  length  = 6
  upper   = false
  special = false
}

# Local values for computed expressions
locals {
  resource_prefix = "test-${random_string.suffix.result}"
}

# Extension attribute that references sensitive data indirectly
resource "jamfpro_computer_extension_attribute" "security_info" {
  name        = "Security-Config-${local.resource_prefix}"
  enabled     = true
  description = "Security configuration status (API: ${length(var.jamf_client_id) > 0 ? "configured" : "not configured"})"
  input_type  = "TEXT"
  inventory_display_type = "GENERAL"
  data_type   = "STRING"
}
