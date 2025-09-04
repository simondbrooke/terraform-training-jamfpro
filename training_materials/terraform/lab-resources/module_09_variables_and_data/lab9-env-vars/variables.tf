variable "environment" {
  description = "Environment name"
  type        = string
  default     = "default"
}

variable "department_name" {
  description = "Name of the department"
  type        = string
  default     = "Default Department"
}

variable "team_size" {
  description = "Number of people in the team"
  type        = number
  default     = 5
}

variable "department_list" {
  description = "List of all departments"
  type        = list(string)
  default     = ["Engineering", "Sales", "Marketing"]
}

variable "team_sizes" {
  description = "Team sizes by department"
  type        = map(number)
  default = {
    engineering = 10
    sales       = 6
    marketing   = 4
  }
}
