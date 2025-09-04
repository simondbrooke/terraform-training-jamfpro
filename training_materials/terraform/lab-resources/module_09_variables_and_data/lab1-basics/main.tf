# We'll use locals to show how variables work
locals {
  department_info = "Department: ${var.department_name}"
  team_info       = "Team Size: ${var.team_size}"
  status_info     = "Active: ${var.is_active}"
}
