# This is a simple string variable
variable "department_name" {
  description = "Name of the department"
  type        = string
  default     = "Engineering"
}

# This is a simple number variable  
variable "team_size" {
  description = "Number of people in the team"
  type        = number
  default     = 5
}

# This is a simple boolean variable
variable "is_active" {
  description = "Whether the department is active"
  type        = bool
  default     = true
}

# Variables for creating a Jamf Pro extension attribute
variable "attribute_name" {
  description = "Name for the extension attribute"
  type        = string
  default     = "Department"
}

variable "attribute_description" {
  description = "Description for the extension attribute"
  type        = string
  default     = "Employee department"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}
