variable "department_name" {
  description = "Name of the department"
  type        = string
  default     = "Engineering"
}

variable "team_size" {
  description = "Number of people in the team"
  type        = number
  default     = 5
}

variable "is_active" {
  description = "Whether the department is active"
  type        = bool
  default     = true
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

# List variables
variable "department_list" {
  description = "List of all departments"
  type        = list(string)
  default     = ["Engineering", "Sales", "Marketing"]
}

variable "office_floors" {
  description = "List of office floor numbers"
  type        = list(number)
  default     = [1, 2, 3, 5]
}

variable "office_locations" {
  description = "List of office locations"
  type        = list(string)
  default     = ["New York", "London", "Tokyo"]
}
