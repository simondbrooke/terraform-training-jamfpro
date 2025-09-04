output "validation_summary" {
  description = "Summary of validated variables"
  value = {
    department_name = var.department_name
    team_size      = var.team_size
    environment    = var.environment
    attribute_name = var.attribute_name
    validation_info = local.validation_info
  }
}
