output "environment_variables_test" {
  description = "Test of environment variables"
  value = {
    environment      = var.environment
    department_name  = var.department_name
    team_size       = var.team_size
    department_list = var.department_list
    team_sizes      = var.team_sizes
  }
}
