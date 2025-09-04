# Random suffix for unique naming
resource "random_string" "suffix" {
  length  = 6
  upper   = false
  special = false
}

# Local values
locals {
  resource_prefix = "${var.environment}-${random_string.suffix.result}"
  department_info = "Department: ${var.department_name}, Size: ${var.team_size}, Active: ${var.is_active}"
}
