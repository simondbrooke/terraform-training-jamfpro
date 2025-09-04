output "deployment_summary" {
  description = "Complete deployment information"
  value = {
    environment = var.environment
    department  = var.department_name
    team_size   = var.team_size
    active      = var.is_active
    attribute_name = var.attribute_name
    resource_prefix = local.resource_prefix
    department_info = local.department_info
  }
}
