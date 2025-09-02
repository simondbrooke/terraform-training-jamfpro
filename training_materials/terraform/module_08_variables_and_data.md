
---

## 📊 Module 08: Variables and Data
*Duration: 2.5 hours | Labs: 3*

### 🎯 Learning Objectives
By the end of this module, you will be able to:
- ✅ Master input variables with advanced types and validation
- ✅ Use variable definition files and environment variables
- ✅ Understand variable precedence and loading order
- ✅ Create and use output values effectively
- ✅ Work with local values for computed expressions
- ✅ Use data sources to query existing infrastructure
- ✅ Implement variable validation and sensitive handling
- ✅ Reference named values across configurations

### 📚 Topics Covered

#### 📥 Input Variables

Input variables serve as **parameters** for Terraform configurations, making them flexible and reusable across different environments.

**🎯 Variable Declaration Syntax:**
```hcl
variable "name" {
  description = "Description of the variable"
  type        = string
  default     = "default_value"
  sensitive   = false
  nullable    = true
  
  validation {
    condition     = length(var.name) > 0
    error_message = "Name cannot be empty."
  }
}
```

**📋 Variable Types:**

**🔤 String Variables:**
```hcl
variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
  
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be dev, staging, or prod."
  }
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  
  validation {
    condition     = can(regex("^[a-zA-Z0-9-_]+$", var.project_name))
    error_message = "Project name must contain only alphanumeric characters, hyphens, and underscores."
  }
}
```

**🔢 Number Variables:**
```hcl
variable "instance_count" {
  description = "Number of instances to create"
  type        = number
  default     = 1
  
  validation {
    condition     = var.instance_count >= 1 && var.instance_count <= 10
    error_message = "Instance count must be between 1 and 10."
  }
}

variable "disk_size" {
  description = "Disk size in GB"
  type        = number
  default     = 20
  
  validation {
    condition     = var.disk_size >= 20 && var.disk_size <= 1000
    error_message = "Disk size must be between 20 and 1000 GB."
  }
}
```

**✅ Boolean Variables:**
```hcl
variable "enable_monitoring" {
  description = "Enable monitoring for resources"
  type        = bool
  default     = true
}

variable "public_access" {
  description = "Allow public access"
  type        = bool
  default     = false
}
```

**📋 List Variables:**
```hcl
variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["us-west-2a", "us-west-2b", "us-west-2c"]
  
  validation {
    condition     = length(var.availability_zones) >= 2
    error_message = "At least 2 availability zones must be specified."
  }
}

variable "allowed_ports" {
  description = "List of allowed ports"
  type        = list(number)
  default     = [80, 443, 22]
  
  validation {
    condition = alltrue([
      for port in var.allowed_ports : port >= 1 && port <= 65535
    ])
    error_message = "All ports must be between 1 and 65535."
  }
}
```

**🗺️ Map Variables:**
```hcl
variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default = {
    Environment = "dev"
    Project     = "terraform-demo"
    ManagedBy   = "terraform"
  }
}

variable "instance_types" {
  description = "Instance types per environment"
  type        = map(string)
  default = {
    dev     = "t2.micro"
    staging = "t2.small"
    prod    = "t2.medium"
  }
}
```

**🏗️ Object Variables:**
```hcl
variable "vpc_config" {
  description = "VPC configuration"
  type = object({
    cidr_block           = string
    enable_dns_hostnames = bool
    enable_dns_support   = bool
    tags                 = map(string)
  })
  
  default = {
    cidr_block           = "10.0.0.0/16"
    enable_dns_hostnames = true
    enable_dns_support   = true
    tags = {
      Name = "main-vpc"
    }
  }
}

variable "database_config" {
  description = "Database configuration"
  type = object({
    engine         = string
    engine_version = string
    instance_class = string
    allocated_storage = number
    backup_retention_period = number
    multi_az = bool
  })
  
  validation {
    condition     = contains(["mysql", "postgres"], var.database_config.engine)
    error_message = "Database engine must be mysql or postgres."
  }
}
```

**📋 Complex Nested Types:**
```hcl
variable "subnets" {
  description = "Subnet configurations"
  type = map(object({
    cidr_block        = string
    availability_zone = string
    public           = bool
    tags             = map(string)
  }))
  
  default = {
    public_1 = {
      cidr_block        = "10.0.1.0/24"
      availability_zone = "us-west-2a"
      public           = true
      tags = {
        Name = "public-subnet-1"
        Type = "public"
      }
    }
    private_1 = {
      cidr_block        = "10.0.10.0/24"
      availability_zone = "us-west-2a"
      public           = false
      tags = {
        Name = "private-subnet-1"
        Type = "private"
      }
    }
  }
}
```

#### 🔒 Sensitive Variables

**🛡️ Sensitive Variable Handling:**
```hcl
variable "database_password" {
  description = "Database password"
  type        = string
  sensitive   = true
  
  validation {
    condition     = length(var.database_password) >= 8
    error_message = "Password must be at least 8 characters long."
  }
}

variable "api_keys" {
  description = "API keys for external services"
  type        = map(string)
  sensitive   = true
  default     = {}
}

# Using sensitive variables
resource "aws_db_instance" "main" {
  identifier = "main-database"
  
  engine         = "mysql"
  engine_version = "8.0"
  instance_class = "db.t3.micro"
  
  allocated_storage = 20
  storage_encrypted = true
  
  db_name  = "maindb"
  username = "admin"
  password = var.database_password  # Marked as sensitive
  
  skip_final_snapshot = true
  
  tags = {
    Name = "main-database"
  }
}
```

#### 📂 Variable Definition Files

**📁 terraform.tfvars (Auto-loaded):**
```hcl
# terraform.tfvars
environment    = "production"
instance_count = 3
project_name   = "web-application"

availability_zones = [
  "us-west-2a",
  "us-west-2b",
  "us-west-2c"
]

tags = {
  Environment = "production"
  Project     = "web-application"
  Owner       = "platform-team"
  CostCenter  = "engineering"
}

vpc_config = {
  cidr_block           = "10.1.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "production-vpc"
  }
}
```

**🌍 Environment-Specific Files:**
```hcl
# dev.tfvars
environment    = "dev"
instance_count = 1
instance_types = {
  dev = "t2.micro"
}

# staging.tfvars  
environment    = "staging"
instance_count = 2
instance_types = {
  staging = "t2.small"
}

# prod.tfvars
environment    = "prod"
instance_count = 5
instance_types = {
  prod = "t2.medium"
}
```

**🔄 Variable Loading Precedence (Highest to Lowest):**
1. **Command line flags**: `-var` and `-var-file`
2. **Environment variables**: `TF_VAR_name`
3. **terraform.tfvars.json**
4. **terraform.tfvars**
5. ***.auto.tfvars.json** (alphabetical order)
6. ***.auto.tfvars** (alphabetical order)
7. **Variable defaults** in configuration files

#### 📤 Output Values

Output values expose information about your infrastructure for use by other configurations, scripts, or users.

**🎯 Basic Output Syntax:**
```hcl
output "name" {
  description = "Description of the output"
  value       = expression
  sensitive   = false
  depends_on  = [resource.example]
}
```

**📊 Simple Outputs:**
```hcl
# Basic resource attribute outputs
output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "instance_public_ip" {
  description = "Public IP address of the instance"
  value       = aws_instance.web.public_ip
}

output "database_endpoint" {
  description = "Database connection endpoint"
  value       = aws_db_instance.main.endpoint
  sensitive   = true  # Contains sensitive connection info
}
```

**🗺️ Complex Outputs:**
```hcl
# Object output with multiple attributes
output "vpc_info" {
  description = "Complete VPC information"
  value = {
    id                = aws_vpc.main.id
    cidr_block        = aws_vpc.main.cidr_block
    arn               = aws_vpc.main.arn
    default_route_table_id = aws_vpc.main.default_route_table_id
    dhcp_options_id   = aws_vpc.main.dhcp_options_id
  }
}

# List output with for expression
output "subnet_ids" {
  description = "List of subnet IDs"
  value = [
    for subnet in aws_subnet.private : subnet.id
  ]
}

# Map output with computed values
output "instance_details" {
  description = "Instance details by name"
  value = {
    for name, instance in aws_instance.web : name => {
      id         = instance.id
      public_ip  = instance.public_ip
      private_ip = instance.private_ip
      az         = instance.availability_zone
    }
  }
}
```

**🔗 Conditional Outputs:**
```hcl
# Output that depends on conditions
output "load_balancer_dns" {
  description = "Load balancer DNS name (only if created)"
  value       = var.create_load_balancer ? aws_lb.main[0].dns_name : null
}

# Output with conditional sensitivity
output "admin_password" {
  description = "Admin password for the database"
  value       = var.create_database ? aws_db_instance.main[0].password : null
  sensitive   = var.create_database
}
```

#### 🏷️ Local Values

Local values assign names to expressions, making configurations more readable and reducing repetition.

**🔧 Basic Local Values:**
```hcl
locals {
  # Simple computed values
  environment = var.environment
  region      = var.aws_region
  
  # String interpolation
  name_prefix = "${local.environment}-${var.project_name}"
  
  # Conditional logic
  instance_type = local.environment == "prod" ? "t3.large" : "t3.micro"
  
  # Complex expressions
  availability_zones = slice(data.aws_availability_zones.available.names, 0, 3)
}
```

**📋 Advanced Local Values:**
```hcl
locals {
  # Common tags applied to all resources
  common_tags = {
    Environment = local.environment
    Project     = var.project_name
    ManagedBy   = "terraform"
    Owner       = var.owner_email
    CostCenter  = var.cost_center
  }
  
  # Environment-specific configuration
  env_config = {
    dev = {
      instance_type = "t3.micro"
      min_size      = 1
      max_size      = 2
      desired_size  = 1
    }
    staging = {
      instance_type = "t3.small"
      min_size      = 1
      max_size      = 3
      desired_size  = 2
    }
    prod = {
      instance_type = "t3.medium"
      min_size      = 2
      max_size      = 10
      desired_size  = 3
    }
  }
  
  # Current environment configuration
  current_config = local.env_config[local.environment]
  
  # Computed CIDR blocks
  subnet_cidrs = {
    for i, az in local.availability_zones :
    az => cidrsubnet(var.vpc_cidr, 8, i)
  }
  
  # Security group rules
  ingress_rules = {
    http = {
      port        = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
    https = {
      port        = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
    ssh = {
      port        = 22
      protocol    = "tcp"
      cidr_blocks = [var.vpc_cidr]
    }
  }
}
```

#### 📥 Data Sources

Data sources allow Terraform to **query existing infrastructure** and **external systems** to retrieve information for use in your configurations. They are **read-only** and don't create or modify resources.

**🎯 Key Benefits:**
- **🔍 Discover existing resources** without managing them
- **🔗 Reference external infrastructure** in your configurations  
- **📊 Get dynamic information** like current IP addresses or AMI IDs
- **🏗️ Build on existing foundations** without importing resources

**🔍 Basic Data Source Syntax:**
```hcl
data "provider_type" "name" {
  # Configuration arguments
  argument = "value"
  
  # Optional filters
  filter {
    name   = "filter_name"
    values = ["filter_value"]
  }
}

# Reference data source attributes
resource "example_resource" "main" {
  attribute = data.provider_type.name.attribute_name
}
```

### 🟢 Simple Use Cases

**📍 Environment Information:**
```hcl
# Get current AWS region
data "aws_region" "current" {}

# Get current AWS account information
data "aws_caller_identity" "current" {}

# Get current partition (aws, aws-cn, aws-us-gov)
data "aws_partition" "current" {}

# Use in resource tags
resource "aws_s3_bucket" "example" {
  bucket = "my-bucket-${data.aws_caller_identity.current.account_id}"
  
  tags = {
    Region    = data.aws_region.current.name
    AccountId = data.aws_caller_identity.current.account_id
    Partition = data.aws_partition.current.partition
  }
}
```

**🌍 Availability Zones:**
```hcl
# Get all available AZs
data "aws_availability_zones" "available" {
  state = "available"
}

# Get AZs excluding specific ones
data "aws_availability_zones" "filtered" {
  state = "available"
  
  exclude_names = ["us-west-2d"]  # Exclude problematic AZ
}

# Use in subnet creation
resource "aws_subnet" "public" {
  count = length(data.aws_availability_zones.available.names)
  
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.${count.index + 1}.0/24"
  availability_zone = data.aws_availability_zones.available.names[count.index]
  
  map_public_ip_on_launch = true
  
  tags = {
    Name = "public-subnet-${count.index + 1}"
    AZ   = data.aws_availability_zones.available.names[count.index]
  }
}
```

**🖼️ Latest AMI Images:**
```hcl
# Get latest Ubuntu AMI
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical
  
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Get latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# Get Windows Server AMI
data "aws_ami" "windows" {
  most_recent = true
  owners      = ["amazon"]
  
  filter {
    name   = "name"
    values = ["Windows_Server-2022-English-Full-Base-*"]
  }
  
  filter {
    name   = "platform"
    values = ["windows"]
  }
}

# Use in instance creation
resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  
  tags = {
    Name        = "web-server"
    AMI_Name    = data.aws_ami.ubuntu.name
    AMI_Date    = data.aws_ami.ubuntu.creation_date
    Platform    = data.aws_ami.ubuntu.platform_details
  }
}
```

### 🟡 Medium Use Cases

**🌐 Existing VPC and Networking:**
```hcl
# Find existing VPC by tag
data "aws_vpc" "existing" {
  filter {
    name   = "tag:Name"
    values = ["production-vpc"]
  }
}

# Alternative: Find VPC by CIDR
data "aws_vpc" "by_cidr" {
  cidr_block = "10.0.0.0/16"
}

# Get all subnets in the VPC
data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.existing.id]
  }
  
  filter {
    name   = "tag:Type"
    values = ["private"]
  }
}

# Get public subnets
data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.existing.id]
  }
  
  filter {
    name   = "tag:Type"
    values = ["public"]
  }
}

# Get detailed information for each subnet
data "aws_subnet" "private_details" {
  for_each = toset(data.aws_subnets.private.ids)
  id       = each.value
}

data "aws_subnet" "public_details" {
  for_each = toset(data.aws_subnets.public.ids)
  id       = each.value
}

# Use existing network infrastructure
resource "aws_instance" "app" {
  count = length(data.aws_subnets.private.ids)
  
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.small"
  subnet_id              = data.aws_subnets.private.ids[count.index]
  vpc_security_group_ids = [aws_security_group.app.id]
  
  tags = {
    Name   = "app-server-${count.index + 1}"
    Subnet = data.aws_subnet.private_details[data.aws_subnets.private.ids[count.index]].tags.Name
    AZ     = data.aws_subnet.private_details[data.aws_subnets.private.ids[count.index]].availability_zone
  }
}
```

**🔐 Security Groups and IAM:**
```hcl
# Find existing security group
data "aws_security_group" "database" {
  filter {
    name   = "tag:Name"
    values = ["database-sg"]
  }
  
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.existing.id]
  }
}

# Get existing IAM role
data "aws_iam_role" "ec2_role" {
  name = "EC2-SSM-Role"
}

# Get IAM policy document for assume role
data "aws_iam_policy_document" "ec2_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

# Get existing IAM policy
data "aws_iam_policy" "ssm_managed_instance" {
  name = "AmazonSSMManagedInstanceCore"
}

# Create instance profile using existing role
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2-instance-profile"
  role = data.aws_iam_role.ec2_role.name
}

# Use in EC2 instance
resource "aws_instance" "secure_instance" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.micro"
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name
  vpc_security_group_ids = [data.aws_security_group.database.id]
  
  tags = {
    Name = "secure-instance"
  }
}
```

**📊 External Data and HTTP:**
```hcl
# Get current public IP
data "http" "current_ip" {
  url = "https://ifconfig.me/ip"
  
  request_headers = {
    Accept = "text/plain"
  }
}

# Get configuration from external API
data "http" "service_config" {
  url = "https://api.example.com/config"
  
  request_headers = {
    Authorization = "Bearer ${var.api_token}"
    Accept        = "application/json"
  }
}

# Local file data
data "local_file" "ssh_key" {
  filename = "~/.ssh/id_rsa.pub"
}

# Template file with variables
data "template_file" "user_data" {
  template = file("${path.module}/templates/user_data.sh.tpl")
  
  vars = {
    environment     = var.environment
    region          = data.aws_region.current.name
    config_endpoint = jsondecode(data.http.service_config.response_body).endpoint
  }
}

# Use external data in security group
resource "aws_security_group" "admin_access" {
  name_prefix = "admin-access-"
  vpc_id      = data.aws_vpc.existing.id
  
  ingress {
    description = "SSH from admin IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.current_ip.response_body)}/32"]
  }
  
  tags = {
    Name     = "admin-access-sg"
    AdminIP  = chomp(data.http.current_ip.response_body)
  }
}
```

### 🔴 Complex Use Cases

**🏗️ Multi-Tier Architecture Discovery:**
```hcl
# Complex VPC discovery with multiple criteria
data "aws_vpcs" "production" {
  filter {
    name   = "tag:Environment"
    values = ["production"]
  }
  
  filter {
    name   = "tag:Project"
    values = [var.project_name]
  }
  
  filter {
    name   = "state"
    values = ["available"]
  }
}

# Get detailed information for each production VPC
data "aws_vpc" "production_details" {
  for_each = toset(data.aws_vpcs.production.ids)
  id       = each.value
}

# Find the "main" production VPC based on tags
locals {
  main_vpc_id = [
    for vpc_id, vpc in data.aws_vpc.production_details :
    vpc_id if lookup(vpc.tags, "Type", "") == "main"
  ][0]
  
  main_vpc = data.aws_vpc.production_details[local.main_vpc_id]
}

# Get all route tables in the main VPC
data "aws_route_tables" "main_vpc" {
  vpc_id = local.main_vpc_id
}

# Get detailed route table information
data "aws_route_table" "main_vpc_details" {
  for_each         = toset(data.aws_route_tables.main_vpc.ids)
  route_table_id   = each.value
}

# Categorize subnets by type and tier
data "aws_subnets" "web_tier" {
  filter {
    name   = "vpc-id"
    values = [local.main_vpc_id]
  }
  
  filter {
    name   = "tag:Tier"
    values = ["web"]
  }
  
  filter {
    name   = "tag:Type"
    values = ["public"]
  }
}

data "aws_subnets" "app_tier" {
  filter {
    name   = "vpc-id"
    values = [local.main_vpc_id]
  }
  
  filter {
    name   = "tag:Tier"
    values = ["application"]
  }
  
  filter {
    name   = "tag:Type"
    values = ["private"]
  }
}

data "aws_subnets" "db_tier" {
  filter {
    name   = "vpc-id"
    values = [local.main_vpc_id]
  }
  
  filter {
    name   = "tag:Tier"
    values = ["database"]
  }
  
  filter {
    name   = "tag:Type"
    values = ["private"]
  }
}

# Get subnet details for each tier
data "aws_subnet" "web_tier_details" {
  for_each = toset(data.aws_subnets.web_tier.ids)
  id       = each.value
}

data "aws_subnet" "app_tier_details" {
  for_each = toset(data.aws_subnets.app_tier.ids)
  id       = each.value
}

data "aws_subnet" "db_tier_details" {
  for_each = toset(data.aws_subnets.db_tier.ids)
  id       = each.value
}

# Create locals for organized subnet information
locals {
  web_subnets = {
    for id, subnet in data.aws_subnet.web_tier_details : 
    subnet.availability_zone => {
      id         = subnet.id
      cidr_block = subnet.cidr_block
      az         = subnet.availability_zone
    }
  }
  
  app_subnets = {
    for id, subnet in data.aws_subnet.app_tier_details : 
    subnet.availability_zone => {
      id         = subnet.id
      cidr_block = subnet.cidr_block
      az         = subnet.availability_zone
    }
  }
  
  db_subnets = {
    for id, subnet in data.aws_subnet.db_tier_details : 
    subnet.availability_zone => {
      id         = subnet.id
      cidr_block = subnet.cidr_block
      az         = subnet.availability_zone
    }
  }
}
```

**🔍 Service Discovery and Integration:**
```hcl
# Discover existing RDS instances
data "aws_db_instances" "existing" {}

# Get details for specific database
data "aws_db_instance" "main_db" {
  db_instance_identifier = "production-main-db"
}

# Find load balancers
data "aws_lb" "main_alb" {
  name = "production-main-alb"
}

# Get load balancer listeners
data "aws_lb_listener" "main_alb_https" {
  load_balancer_arn = data.aws_lb.main_alb.arn
  port              = 443
}

# Discover ECS cluster
data "aws_ecs_cluster" "main" {
  cluster_name = "production-cluster"
}

# Get ECS services in cluster
data "aws_ecs_service" "web_service" {
  service_name = "web-service"
  cluster_arn  = data.aws_ecs_cluster.main.arn
}

# Find existing S3 buckets
data "aws_s3_bucket" "static_assets" {
  bucket = "production-static-assets-${data.aws_caller_identity.current.account_id}"
}

data "aws_s3_bucket" "logs" {
  bucket = "production-logs-${data.aws_caller_identity.current.account_id}"
}

# Get CloudFront distribution
data "aws_cloudfront_distribution" "main" {
  id = var.cloudfront_distribution_id
}

# Complex integration using discovered services
resource "aws_ecs_service" "api_service" {
  name            = "api-service"
  cluster         = data.aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.api.arn
  desired_count   = 3
  
  load_balancer {
    target_group_arn = aws_lb_target_group.api.arn
    container_name   = "api"
    container_port   = 8080
  }
  
  network_configuration {
    subnets         = [for subnet in local.app_subnets : subnet.id]
    security_groups = [aws_security_group.api_service.id]
  }
  
  depends_on = [data.aws_lb_listener.main_alb_https]
}

# Create target group that integrates with existing ALB
resource "aws_lb_target_group" "api" {
  name     = "api-service-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = local.main_vpc_id
  
  health_check {
    enabled             = true
    healthy_threshold   = 2
    interval            = 30
    matcher             = "200"
    path                = "/health"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
  }
  
  tags = {
    Name = "api-service-target-group"
  }
}

# Add listener rule to existing ALB
resource "aws_lb_listener_rule" "api_service" {
  listener_arn = data.aws_lb_listener.main_alb_https.arn
  priority     = 100
  
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.api.arn
  }
  
  condition {
    path_pattern {
      values = ["/api/*"]
    }
  }
}
```

**💻 Exercise 7.2**: Data Source Integration
**Duration**: 25 minutes

Let's practice using data sources to integrate with existing infrastructure.

**Step 1: Create Data Source Configuration**

Create `data_sources.tf`:
```hcl
# Environment discovery
data "aws_region" "current" {}
data "aws_caller_identity" "current" {}
data "aws_availability_zones" "available" {
  state = "available"
}

# Network discovery
data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

data "aws_subnet" "default_details" {
  for_each = toset(data.aws_subnets.default.ids)
  id       = each.value
}

# AMI discovery
data "aws_ami" "latest_ubuntu" {
  most_recent = true
  owners      = ["099720109477"]
  
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# External IP discovery
data "http" "current_ip" {
  url = "https://ifconfig.me/ip"
}

# Local configuration
data "local_file" "config" {
  filename = "${path.module}/config.json"
}

# Create config.json file
resource "local_file" "config" {
  filename = "${path.module}/config.json"
  content = jsonencode({
    environment = var.environment
    region      = data.aws_region.current.name
    vpc_id      = data.aws_vpc.default.id
    timestamp   = timestamp()
  })
}
```

**Step 2: Use Data Sources in Resources**

Create `main.tf`:
```hcl
# Security group using discovered information
resource "aws_security_group" "web" {
  name_prefix = "web-sg-"
  vpc_id      = data.aws_vpc.default.id
  description = "Security group for web servers"
  
  # Allow HTTP from anywhere
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  # Allow SSH from current IP only
  ingress {
    description = "SSH from current IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.current_ip.response_body)}/32"]
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = {
    Name      = "web-security-group"
    VPC       = data.aws_vpc.default.tags.Name
    Region    = data.aws_region.current.name
    CreatedBy = "terraform-data-sources-demo"
  }
}

# EC2 instances using data sources
resource "aws_instance" "web" {
  count = min(length(data.aws_subnets.default.ids), 2) # Max 2 instances
  
  ami                    = data.aws_ami.latest_ubuntu.id
  instance_type          = "t2.micro"
  subnet_id              = data.aws_subnets.default.ids[count.index]
  vpc_security_group_ids = [aws_security_group.web.id]
  
  user_data = base64encode(templatefile("${path.module}/user_data.sh", {
    instance_number = count.index + 1
    region         = data.aws_region.current.name
    account_id     = data.aws_caller_identity.current.account_id
    vpc_id         = data.aws_vpc.default.id
    subnet_id      = data.aws_subnets.default.ids[count.index]
    config_data    = data.local_file.config.content
  }))
  
  tags = {
    Name = "web-server-${count.index + 1}"
    AZ   = data.aws_subnet.default_details[data.aws_subnets.default.ids[count.index]].availability_zone
    AMI  = data.aws_ami.latest_ubuntu.name
  }
}
```

**Step 3: Create User Data Script**

Create `user_data.sh`:
```bash
#!/bin/bash
# Update system
apt-get update
apt-get upgrade -y

# Install nginx
apt-get install -y nginx

# Create custom index page with discovered information
cat > /var/www/html/index.html << EOF
<!DOCTYPE html>
<html>
<head>
    <title>Data Sources Demo</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; }
        .info { background: #f0f8ff; padding: 20px; border-radius: 5px; margin: 10px 0; }
        .highlight { color: #7B42BC; font-weight: bold; }
    </style>
</head>
<body>
    <h1>🔍 Terraform Data Sources Demo</h1>
    
    <div class="info">
        <h2>Instance Information</h2>
        <p><strong>Instance Number:</strong> <span class="highlight">${instance_number}</span></p>
        <p><strong>Region:</strong> <span class="highlight">${region}</span></p>
        <p><strong>Account ID:</strong> <span class="highlight">${account_id}</span></p>
        <p><strong>VPC ID:</strong> <span class="highlight">${vpc_id}</span></p>
        <p><strong>Subnet ID:</strong> <span class="highlight">${subnet_id}</span></p>
    </div>
    
    <div class="info">
        <h2>Configuration Data</h2>
        <pre>${config_data}</pre>
    </div>
    
    <p>This server was provisioned using Terraform data sources to discover existing infrastructure!</p>
</body>
</html>
EOF

# Start nginx
systemctl start nginx
systemctl enable nginx

# Log deployment information
echo "$(date): Instance ${instance_number} deployed in ${region}" >> /var/log/terraform-deployment.log
```

**Step 4: Test Data Source Integration**
```bash
# Initialize and apply
terraform init
terraform plan
terraform apply

# View discovered information
terraform output

# Test web servers
curl $(terraform output -raw instance_public_ips | jq -r '.[0]')

# Clean up
terraform destroy
```

💡 **Pro Tip**: Data sources are perfect for integrating new resources with existing infrastructure without needing to import or manage existing resources!

---

## ✅ Module 7 Summary

**🎯 Learning Objectives Achieved:**
- ✅ Mastered **input variables** with all data types and validation
- ✅ Understood **variable definition files** and loading precedence
- ✅ Implemented **output values** for information sharing
- ✅ Created **local values** to reduce repetition and improve maintainability
- ✅ Leveraged **data sources** for infrastructure discovery and integration

**🔑 Key Concepts Covered:**
- **Variable Types**: string, number, bool, list, map, object, complex nested types
- **Validation Rules**: Custom validation with conditions and error messages
- **Sensitive Variables**: Protecting confidential information in configurations
- **Variable Files**: `.tfvars`, `.auto.tfvars`, `.tfvars.json` formats
- **Loading Precedence**: Understanding how Terraform resolves variable values
- **Data Sources**: Simple, medium, and complex use cases for infrastructure discovery

**💼 Professional Skills Developed:**
- **Configuration Management**: Organizing variables and outputs effectively
- **Security Best Practices**: Handling sensitive data appropriately
- **Infrastructure Integration**: Using data sources to build on existing resources
- **Code Organization**: Structuring configurations for maintainability
- **Dynamic Configuration**: Creating flexible, reusable Terraform modules

**🏗️ Technical Achievements:**
- Built complete AWS infrastructure with variables, locals, and data sources
- Implemented advanced data source queries for multi-tier architecture discovery
- Created dynamic security groups with external IP integration
- Developed template-based configurations with variable substitution
- Established patterns for infrastructure discovery and integration

**➡️ Next Steps**: Ready to explore **Meta Arguments** where you'll learn to control resource behavior with `depends_on`, `count`, `for_each`, and lifecycle management!

---

---

## 🔗 **Next Steps**

Ready to continue your Terraform journey? Proceed to the next module:

**➡️ [Module 9: Meta Arguments](./module_09_meta_arguments.md)**

Learn powerful meta-arguments like count, for_each, and lifecycle rules.

---
