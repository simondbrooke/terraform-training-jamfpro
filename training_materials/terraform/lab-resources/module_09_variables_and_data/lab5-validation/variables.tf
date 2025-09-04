variable "department_name" {
  description = "Name of the department"
  type        = string
  default     = "Engineering"
  
  # Simple validation - must not be empty
  validation {
    condition     = length(var.department_name) > 0
    error_message = "Department name cannot be empty."
  }
}

variable "team_size" {
  description = "Number of people in the team"
  type        = number
  default     = 5
  
  # Number range validation
  validation {
    condition     = var.team_size >= 1 && var.team_size <= 100
    error_message = "Team size must be between 1 and 100 people."
  }
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
  
  # Must be one of specific values
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be dev, staging, or prod."
  }
}

variable "attribute_name" {
  description = "Name for the extension attribute"
  type        = string
  default     = "Department"
  
  # Pattern validation with regex
  validation {
    condition     = can(regex("^[A-Za-z0-9 _-]+$", var.attribute_name))
    error_message = "Attribute name can only contain letters, numbers, spaces, hyphens, and underscores."
  }
}
