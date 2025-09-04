output "department_name" {
  description = "The department name from our variable"
  value       = var.department_name
}

output "team_size" {
  description = "The team size from our variable"
  value       = var.team_size
}

output "is_active" {
  description = "Whether the department is active"
  value       = var.is_active
}

output "combined_info" {
  description = "All information combined"
  value = {
    department = var.department_name
    size       = var.team_size
    active     = var.is_active
  }
}
