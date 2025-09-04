# This output will be marked as sensitive automatically
output "api_client_id" {
  description = "API client ID (sensitive)"
  value       = var.jamf_client_id
  sensitive   = true
}

# Safe output - doesn't expose sensitive data but references sensitive vars
output "security_status" {
  description = "Security configuration status"
  value = {
    vpp_configured = length(var.vpp_service_token) > 10
    api_configured = length(var.jamf_client_id) > 0
  }
  sensitive = true
}
