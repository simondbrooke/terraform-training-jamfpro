# Sensitive API credentials
variable "jamf_client_id" {
  description = "Jamf Pro OAuth2 client ID"
  type        = string
  sensitive   = true
  default     = "your-client-id"
}

variable "jamf_client_secret" {
  description = "Jamf Pro OAuth2 client secret"
  type        = string
  sensitive   = true
  default     = "your-client-secret"
}

# Sensitive service token
variable "vpp_service_token" {
  description = "Apple Business Manager VPP service token"
  type        = string
  sensitive   = true
  default     = "sample-base64-encoded-token"
  
  validation {
    condition     = length(var.vpp_service_token) > 10
    error_message = "VPP service token must be provided."
  }
}
