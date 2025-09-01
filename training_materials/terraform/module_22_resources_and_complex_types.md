## ⚡ Module 22: Resources and Complex Types
*Duration: 2.5 hours | Labs: 4*

### 🎯 Learning Objectives
By the end of this module, you will be able to:
- ✅ Understand resource configuration syntax and structure
- ✅ Configure resource timeouts and special nested blocks
- ✅ Master complex type system: Collection vs Structural types
- ✅ Implement Collection Types: list, map, set with proper access patterns
- ✅ Implement Structural Types: object, tuple with schema definitions
- ✅ Use type constructors and shorthand keyword versions
- ✅ Apply complex types in real Terraform configurations
- ✅ Debug and validate complex type definitions

### 📚 Topics Covered

#### 🏗️ Understanding Terraform Resources

The transcript begins our exploration: *"resources in configuration files represent infrastructure objects such as virtual machines databases virtual Network components and storage"*

**🔑 Resource Block Anatomy:**
```hcl
resource "resource_type" "resource_name" {
  # Configuration arguments
  argument1 = "value1"
  argument2 = "value2"
  
  # Nested blocks
  nested_block {
    nested_argument = "value"
  }
}
```

**📋 Resource Type Determination:**
From the transcript: *"a resource type is determines the kind of infrastructure object it is so here it says AWS instance and this would represent an AC AWS ec2 instance this is all defined within the providers documentation"*

```hcl
# AWS EC2 instance example
resource "aws_instance" "web_server" {
  ami           = "ami-0c02fb55956c7d316"
  instance_type = "t2.micro"
  
  tags = {
    Name        = "Web Server"
    Environment = "production"
  }
}

# Azure virtual machine example  
resource "azurerm_linux_virtual_machine" "web_server" {
  name                = "web-vm"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  size                = "Standard_F2"
  
  # Resource-specific configuration...
}
```

**⏱️ Special Timeout Nested Blocks:**
The transcript specifically mentions: *"special timeout nested blocks within resources so some resource types provide a special time on asset block argument that allows you to customize how long certain operations are allowed to take before being considered to have failed"*

```hcl
resource "aws_db_instance" "database" {
  identifier = "production-db"
  engine     = "mysql"
  
  # Custom timeouts for different operations
  timeouts {
    create = "60m"    # 60 minutes for creation
    update = "40m"    # 40 minutes for updates
    delete = "30m"    # 30 minutes for deletion
  }
  
  # Other configuration...
}

resource "azurerm_virtual_machine" "example" {
  name = "example-vm"
  
  # Different timeout granularity
  timeouts {
    create = "45m"
    read   = "5m"
    update = "45m" 
    delete = "45m"
  }
}
```

#### 🔄 Complex Types Overview

The transcript introduces complex types: *"a complex type is a type that groups multiple values into a single value and complex types are represented by type Constructors but several of them are have shorthand keyword versions"*

**🎯 Two Main Categories:**

```mermaid
flowchart TD
    A[Complex Types] --> B[Collection Types]
    A --> C[Structural Types]
    
    B --> D["List (Array-like)"]
    B --> E["Map (Key-Value)"] 
    B --> F["Set (Unique Values)"]
    
    C --> G["Object (Typed Map)"]
    C --> H["Tuple (Typed Array)"]
    
    D --> I["Same Type Elements"]
    E --> I
    F --> I
    
    G --> J["Mixed Type Elements"]
    H --> J
    
    style A fill:#e1f5fe
    style B fill:#f3e5f5
    style C fill:#e8f5e8
    style I fill:#fff3e0
    style J fill:#fce4ec
```

From transcript: *"there are two categories of complex types we have collection types for grouping similar values so list map set and structural types for grouping potentially to similar values so Tuple an object"*

#### 📦 Collection Types Deep Dive

**🔑 Core Principle:**
*"a collection type allows multiple values of one other type to be grouped together as a single value and the type of value within a collection is called its element type"*

##### 📋 List Type

Lists are array-like structures with indexed access.

**📝 Basic List Syntax:**
```hcl
variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["us-west-2a", "us-west-2b", "us-west-2c"]
}

variable "instance_ports" {
  description = "List of ports to open"
  type        = list(number)
  default     = [80, 443, 8080]
}

# Accessing list elements (0-indexed)
resource "aws_subnet" "public" {
  count             = length(var.availability_zones)
  availability_zone = var.availability_zones[count.index]  # [0], [1], [2]
  cidr_block        = "10.0.${count.index + 1}.0/24"
}
```

From transcript: *"we are setting ourselves something that looks kind of like an array and it's these list type here and what we can do is use our index so the indices 0 to reference the first element which is Mars"*

**🔧 List Operations:**
```hcl
locals {
  # List concatenation
  all_ports = concat(var.instance_ports, [22, 3306])
  
  # List filtering
  secure_ports = [for port in var.instance_ports : port if port > 443]
  
  # List transformation
  port_strings = [for port in var.instance_ports : tostring(port)]
}
```

##### 🗺️ Map Type

Maps store key-value pairs for structured data.

**📝 Basic Map Syntax:**
```hcl
variable "environment_configs" {
  description = "Environment-specific configurations"
  type        = map(string)
  default = {
    dev     = "t2.micro"
    staging = "t2.small"
    prod    = "t2.medium"
  }
}

variable "resource_tags" {
  description = "Common resource tags"
  type        = map(string)
  default = {
    Environment = "production"
    Team        = "platform"
    Project     = "web-app"
  }
}

# Accessing map values by key
resource "aws_instance" "web" {
  instance_type = var.environment_configs["prod"]  # "t2.medium"
  
  tags = merge(var.resource_tags, {
    Name = "web-server"
  })
}
```

From transcript: *"for a map it's very similar to a ruby hash or singleness to Json object and the idea here is that it's very similar to the first except now we're doing a key and value and then we access it by based on the key name so plan B is going to return 50 USD"*

**🔧 Map Operations:**
```hcl
locals {
  # Map merging
  complete_tags = merge(var.resource_tags, {
    CreatedBy = "terraform"
    Date      = timestamp()
  })
  
  # Map filtering
  prod_configs = {
    for env, size in var.environment_configs : 
    env => size if env == "prod"
  }
  
  # Map transformation
  config_with_memory = {
    for env, size in var.environment_configs :
    env => "${size}-optimized"
  }
}
```

##### 🎯 Set Type

Sets contain unique values without preserved ordering.

**📝 Basic Set Syntax:**
```hcl
variable "allowed_cidr_blocks" {
  description = "Set of allowed CIDR blocks"
  type        = set(string)
  default = [
    "10.0.0.0/16",
    "172.16.0.0/12", 
    "192.168.0.0/16"
  ]
}

variable "required_tags" {
  description = "Set of required tag keys"
  type        = set(string)
  default     = ["Environment", "Team", "Project"]
}

# Using sets with for_each
resource "aws_security_group_rule" "ingress" {
  for_each = var.allowed_cidr_blocks
  
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = [each.value]
  security_group_id = aws_security_group.web.id
}
```

From transcript: *"we have set it is similar to a list but has no secondary index or preserved ordering all values must be of the same type and will be cast to match the first element"*

**⚠️ Set Characteristics:**
- **No Indexing**: Cannot access by index like `set[0]`
- **Unique Values**: Duplicates automatically removed
- **No Ordering**: Order not guaranteed to be preserved
- **Type Consistency**: All elements must be same type

#### 🏗️ Structural Types Deep Dive

**🔑 Core Principle:**
*"a structural type allows multiple values of several distinct types to be grouped together with a single value structural types require a schema as an argument to specify which types are allowed for which elements"*

##### 📋 Object Type

Objects are like maps but with enforced schemas and mixed types.

**📝 Object Schema Definition:**
```hcl
variable "database_config" {
  description = "Database configuration object"
  type = object({
    engine         = string
    engine_version = string
    instance_class = string
    allocated_storage = number
    multi_az       = bool
    backup_retention = number
    
    # Optional field (if supported)
    # monitoring_interval = optional(number)
  })
  
  default = {
    engine            = "mysql"
    engine_version    = "8.0"
    instance_class    = "db.t3.micro"
    allocated_storage = 20
    multi_az          = false
    backup_retention  = 7
  }
}

# Using object in resource configuration
resource "aws_db_instance" "main" {
  identifier = "production-db"
  
  engine               = var.database_config.engine
  engine_version       = var.database_config.engine_version
  instance_class       = var.database_config.instance_class
  allocated_storage    = var.database_config.allocated_storage
  multi_az             = var.database_config.multi_az
  backup_retention_period = var.database_config.backup_retention
  
  # Schema enforcement ensures all required fields exist
}
```

From transcript: *"object is a map with more explicit keying so this example we'd have name for string age for number and so that's what it would expect the data structure to be"*

**🔧 Complex Object Examples:**
```hcl
variable "application_config" {
  description = "Complex application configuration"
  type = object({
    name    = string
    version = string
    
    # Nested object
    database = object({
      host     = string
      port     = number
      username = string
    })
    
    # List within object
    allowed_ips = list(string)
    
    # Map within object  
    environment_vars = map(string)
    
    # Boolean flags
    enable_monitoring = bool
    enable_backups    = bool
  })
  
  default = {
    name    = "web-application"
    version = "1.2.3"
    
    database = {
      host     = "localhost"
      port     = 3306
      username = "app_user"
    }
    
    allowed_ips = ["10.0.0.0/8", "172.16.0.0/12"]
    
    environment_vars = {
      LOG_LEVEL = "info"
      DEBUG     = "false"
    }
    
    enable_monitoring = true
    enable_backups    = true
  }
}
```

##### 🎯 Tuple Type

Tuples are like lists but with enforced schemas for each position.

**📝 Tuple Schema Definition:**
```hcl
variable "server_specification" {
  description = "Server specification as tuple [name, cpu_cores, memory_gb, storage_gb, gpu_enabled]"
  type        = tuple([string, number, number, number, bool])
  default     = ["web-server", 4, 16, 100, false]
}

variable "network_configuration" {
  description = "Network config tuple [vpc_cidr, public_subnets, private_subnets]"
  type = tuple([
    string,           # VPC CIDR
    list(string),     # Public subnet CIDRs
    list(string)      # Private subnet CIDRs
  ])
  
  default = [
    "10.0.0.0/16",
    ["10.0.1.0/24", "10.0.2.0/24"],
    ["10.0.10.0/24", "10.0.20.0/24"]
  ]
}

# Accessing tuple elements by index
locals {
  server_name    = var.server_specification[0]  # "web-server"
  cpu_cores      = var.server_specification[1]  # 4
  memory_gb      = var.server_specification[2]  # 16
  storage_gb     = var.server_specification[3]  # 100
  gpu_enabled    = var.server_specification[4]  # false
  
  vpc_cidr       = var.network_configuration[0]  # "10.0.0.0/16"
  public_subnets = var.network_configuration[1]  # ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = var.network_configuration[2] # ["10.0.10.0/24", "10.0.20.0/24"]
}
```

From transcript: *"for Tuple multiple return types with a parameter so we can have string number or Boolean so so this is where we'd have a as a string 15 or true as a Boolean"*

**🔧 Tuple Use Cases:**
```hcl
# Database connection tuple: [host, port, database_name, ssl_enabled]
variable "database_connections" {
  description = "List of database connection tuples"
  type = list(tuple([string, number, string, bool]))
  
  default = [
    ["primary-db.example.com", 5432, "app_db", true],
    ["replica-db.example.com", 5432, "app_db", true],
    ["cache-db.example.com", 6379, "cache", false]
  ]
}

# Load balancer configuration: [protocol, port, health_check_path]
variable "load_balancer_listeners" {
  description = "Load balancer listener configurations"
  type = list(tuple([string, number, string]))
  
  default = [
    ["HTTP", 80, "/health"],
    ["HTTPS", 443, "/health"],
    ["TCP", 3306, ""]  # Database port, no health check path
  ]
}
```

#### 🧪 Complex Types in Practice

**🔧 Type Constructor Patterns:**
From the transcript, we learn about *"type Constructors but several of them are have shorthand keyword versions"*:

```hcl
# Shorthand versions
variable "simple_list" {
  type = list(string)
}

variable "simple_map" {
  type = map(number)
}

# Type constructor versions (more explicit)
variable "explicit_list" {
  type = list(string)  # Same as shorthand
}

variable "complex_nested" {
  type = map(object({
    servers = list(string)
    config  = map(string)
    enabled = bool
  }))
}
```

**🎯 Validation and Constraints:**
```hcl
variable "environment_config" {
  description = "Environment configuration with validation"
  type = object({
    name         = string
    instance_count = number
    environment  = string
  })
  
  validation {
    condition = contains(["dev", "staging", "prod"], var.environment_config.environment)
    error_message = "Environment must be one of: dev, staging, prod."
  }
  
  validation {
    condition = var.environment_config.instance_count >= 1 && var.environment_config.instance_count <= 10
    error_message = "Instance count must be between 1 and 10."
  }
}

variable "network_cidr" {
  description = "Network CIDR block"
  type        = string
  
  validation {
    condition = can(cidrhost(var.network_cidr, 0))
    error_message = "Must be a valid IPv4 CIDR block."
  }
}
```

### 💻 **Exercise 22.1**: Resource Configuration & Timeouts
**Duration**: 25 minutes

Learn resource structure and timeout configuration.

**Step 1: Setup Project Structure**
```bash
mkdir ~/terraform-resources-complex-types
cd ~/terraform-resources-complex-types
mkdir lab1-resources-timeouts
cd lab1-resources-timeouts
code .
```

**Step 2: Create Resource with Timeouts**

Create `main.tf`:
```hcl
terraform {
  required_version = ">= 1.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

# RDS instance with custom timeouts
resource "aws_db_instance" "example" {
  identifier = "complex-types-demo-${random_id.suffix.hex}"
  
  # Engine configuration
  engine         = "mysql"
  engine_version = "8.0"
  instance_class = "db.t3.micro"
  
  # Storage configuration  
  allocated_storage     = 20
  max_allocated_storage = 100
  storage_type          = "gp2"
  storage_encrypted     = true
  
  # Database configuration
  db_name  = "demodb"
  username = "admin"
  password = "changeme123!"  # In production, use AWS Secrets Manager
  
  # Network configuration
  publicly_accessible = false
  skip_final_snapshot = true  # For demo only
  deletion_protection = false # For demo only
  
  # Custom timeouts - this is what the transcript mentioned
  timeouts {
    create = "40m"  # 40 minutes for creation
    update = "80m"  # 80 minutes for updates  
    delete = "40m"  # 40 minutes for deletion
  }
  
  tags = {
    Name        = "Complex Types Demo DB"
    Environment = "learning"
    Purpose     = "timeout-demonstration"
  }
}

# EC2 instance with custom timeouts
resource "aws_instance" "web" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"
  
  # User data that takes some time to execute
  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd
    systemctl start httpd
    systemctl enable httpd
    
    # Simulate long-running setup
    sleep 120  # 2 minute delay
    
    echo "<h1>Resource Timeout Demo</h1>" > /var/www/html/index.html
    echo "<p>Instance launched at: $(date)</p>" >> /var/www/html/index.html
  EOF
  
  # Custom timeouts
  timeouts {
    create = "10m"  # Allow extra time for user data
    update = "10m"
    delete = "5m"
  }
  
  tags = {
    Name        = "Timeout Demo Instance"
    Environment = "learning"
  }
}

# Data source for Amazon Linux AMI
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "random_id" "suffix" {
  byte_length = 4
}
```

Create `outputs.tf`:
```hcl
output "database_endpoint" {
  description = "RDS instance endpoint"
  value       = aws_db_instance.example.endpoint
}

output "database_port" {
  description = "RDS instance port"
  value       = aws_db_instance.example.port
}

output "instance_id" {
  description = "EC2 instance ID"
  value       = aws_instance.web.id
}

output "instance_public_ip" {
  description = "EC2 instance public IP"
  value       = aws_instance.web.public_ip
}

# Demonstrate resource attributes
output "resource_attributes" {
  description = "Various resource attributes"
  value = {
    db_arn              = aws_db_instance.example.arn
    db_resource_id      = aws_db_instance.example.resource_id
    instance_arn        = aws_instance.web.arn
    instance_public_dns = aws_instance.web.public_dns
  }
}
```

**Step 3: Test Resource Creation with Timeouts**
```bash
terraform init
terraform plan

# Apply and observe timeout behavior
terraform apply -auto-approve

# Watch for timeout messages in output
# The RDS instance creation will take several minutes
```

**Step 4: Test Timeout Scenarios**

Create a resource with very short timeout to see failure:
```hcl
# Add to main.tf - this will likely timeout
resource "aws_db_instance" "quick_timeout" {
  identifier = "quick-timeout-${random_id.suffix.hex}"
  
  engine         = "mysql"
  engine_version = "8.0" 
  instance_class = "db.t3.micro"
  allocated_storage = 20
  
  db_name  = "quickdb"
  username = "admin"
  password = "changeme123!"
  
  skip_final_snapshot = true
  deletion_protection = false
  
  # Very short timeout - will likely fail
  timeouts {
    create = "2m"  # Only 2 minutes - too short for RDS
  }
  
  tags = {
    Name = "Quick Timeout Test"
  }
}
```

```bash
# Apply to see timeout behavior
terraform apply -auto-approve

# This should fail with timeout error, demonstrating the feature
```

**Step 5: Clean Up**
```bash
terraform destroy -auto-approve
```

### 💻 **Exercise 22.2**: Collection Types Implementation
**Duration**: 30 minutes

Implement and test list, map, and set collection types.

**Step 1: Setup Collection Types Project**
```bash
cd ~/terraform-resources-complex-types
mkdir lab2-collection-types
cd lab2-collection-types
```

**Step 2: Create Collection Type Variables**

Create `variables.tf`:
```hcl
# LIST TYPES
variable "availability_zones" {
  description = "List of availability zones for subnets"
  type        = list(string)
  default     = ["us-west-2a", "us-west-2b", "us-west-2c"]
}

variable "instance_ports" {
  description = "List of ports to open in security group"
  type        = list(number)
  default     = [22, 80, 443, 8080]
}

variable "backup_schedules" {
  description = "List of backup schedule expressions"
  type        = list(string)
  default = [
    "cron(0 2 * * ? *)",    # Daily at 2 AM
    "cron(0 14 ? * SUN *)", # Weekly on Sunday at 2 PM  
    "cron(0 1 1 * ? *)"     # Monthly on 1st at 1 AM
  ]
}

# MAP TYPES  
variable "environment_configs" {
  description = "Map of environment to instance type"
  type        = map(string)
  default = {
    dev     = "t2.micro"
    staging = "t2.small"
    prod    = "t2.medium"
  }
}

variable "common_tags" {
  description = "Map of common resource tags"
  type        = map(string)
  default = {
    Project     = "terraform-training"
    Environment = "learning"
    Owner       = "platform-team"
    ManagedBy   = "terraform"
  }
}

variable "region_amis" {
  description = "Map of region to AMI ID"
  type        = map(string)
  default = {
    "us-west-2" = "ami-0c02fb55956c7d316"
    "us-east-1" = "ami-0abcdef1234567890"
    "eu-west-1" = "ami-0987654321fedcba0"
  }
}

# SET TYPES
variable "allowed_cidr_blocks" {
  description = "Set of allowed CIDR blocks for security group"
  type        = set(string)
  default = [
    "10.0.0.0/8",
    "172.16.0.0/12",
    "192.168.0.0/16"
  ]
}

variable "required_tags" {
  description = "Set of required tag keys"
  type        = set(string)
  default = ["Environment", "Project", "Owner"]
}

variable "monitoring_metrics" {
  description = "Set of CloudWatch metrics to monitor"
  type        = set(string)
  default = [
    "CPUUtilization",
    "NetworkIn", 
    "NetworkOut",
    "DiskReadOps",
    "DiskWriteOps"
  ]
}

# Current environment selection
variable "current_environment" {
  description = "Current deployment environment"
  type        = string
  default     = "dev"
  
  validation {
    condition     = contains(keys(var.environment_configs), var.current_environment)
    error_message = "Environment must be one of: ${join(", ", keys(var.environment_configs))}."
  }
}
```

Create `main.tf`:
```hcl
terraform {
  required_version = ">= 1.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

# VPC for our collection types demo
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  
  tags = merge(var.common_tags, {
    Name = "Collection Types Demo VPC"
  })
}

# Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  
  tags = merge(var.common_tags, {
    Name = "Collection Types Demo IGW"
  })
}

# DEMONSTRATING LISTS - Create subnets using list indices
resource "aws_subnet" "public" {
  count = length(var.availability_zones)
  
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.${count.index + 1}.0/24"
  availability_zone = var.availability_zones[count.index]  # List access by index
  
  map_public_ip_on_launch = true
  
  tags = merge(var.common_tags, {
    Name = "Public Subnet ${count.index + 1} - ${var.availability_zones[count.index]}"
    Type = "public"
    AZ   = var.availability_zones[count.index]
  })
}

# Route table for public subnets
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
  
  tags = merge(var.common_tags, {
    Name = "Public Route Table"
  })
}

# Route table associations using list
resource "aws_route_table_association" "public" {
  count = length(aws_subnet.public)
  
  subnet_id      = aws_subnet.public[count.index].id  # List access
  route_table_id = aws_route_table.public.id
}

# DEMONSTRATING MAPS - Security group using map access
resource "aws_security_group" "web" {
  name_prefix = "web-sg-"
  vpc_id      = aws_vpc.main.id
  description = "Security group demonstrating map and set access"
  
  tags = merge(var.common_tags, {
    Name = "Web Security Group"
  })
}

# Security group rules using list of ports
resource "aws_security_group_rule" "ingress_ports" {
  count = length(var.instance_ports)
  
  type              = "ingress"
  from_port         = var.instance_ports[count.index]  # List access
  to_port           = var.instance_ports[count.index]
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.web.id
  
  description = "Allow port ${var.instance_ports[count.index]}"
}

# DEMONSTRATING SETS - Security group rules using for_each with set
resource "aws_security_group_rule" "ingress_cidrs" {
  for_each = var.allowed_cidr_blocks  # Set iteration
  
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = [each.value]    # Set value access
  security_group_id = aws_security_group.web.id
  
  description = "Allow HTTPS from ${each.value}"
}

# Egress rule
resource "aws_security_group_rule" "egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.web.id
}

# DEMONSTRATING MAP ACCESS - Instance using environment config
resource "aws_instance" "web" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.environment_configs[var.current_environment]  # Map access
  subnet_id     = aws_subnet.public[0].id
  
  vpc_security_group_ids = [aws_security_group.web.id]
  
  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd
    systemctl start httpd
    systemctl enable httpd
    
    cat > /var/www/html/index.html << 'HTML'
    <h1>Collection Types Demo</h1>
    <h2>Environment: ${var.current_environment}</h2>
    <h2>Instance Type: ${var.environment_configs[var.current_environment]}</h2>
    <h3>Available Zones:</h3>
    <ul>
    %{for az in var.availability_zones~}
      <li>${az}</li>
    %{endfor~}
    </ul>
    <h3>Allowed CIDR Blocks:</h3>
    <ul>
    %{for cidr in var.allowed_cidr_blocks~}
      <li>${cidr}</li>
    %{endfor~}
    </ul>
    HTML
  EOF
  
  tags = merge(var.common_tags, {
    Name        = "Web Server - ${title(var.current_environment)}"
    Environment = var.current_environment
    InstanceType = var.environment_configs[var.current_environment]
  })
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}
```

Create `outputs.tf`:
```hcl
# LIST OUTPUTS - Demonstrating list access and functions
output "availability_zones_info" {
  description = "Information about availability zones list"
  value = {
    all_zones    = var.availability_zones
    first_zone   = var.availability_zones[0]
    last_zone    = var.availability_zones[length(var.availability_zones) - 1]
    zone_count   = length(var.availability_zones)
    zones_joined = join(", ", var.availability_zones)
  }
}

output "subnet_details" {
  description = "Subnet details showing list operations"
  value = {
    subnet_ids = aws_subnet.public[*].id
    subnet_azs = aws_subnet.public[*].availability_zone
    cidr_blocks = aws_subnet.public[*].cidr_block
  }
}

# MAP OUTPUTS - Demonstrating map access and functions  
output "environment_config_info" {
  description = "Environment configuration map information"
  value = {
    all_configs        = var.environment_configs
    current_env        = var.current_environment
    current_instance   = var.environment_configs[var.current_environment]
    available_envs     = keys(var.environment_configs)
    instance_types     = values(var.environment_configs)
  }
}

output "tags_demonstration" {
  description = "Tag map operations"
  value = {
    common_tags     = var.common_tags
    tag_keys        = keys(var.common_tags)
    tag_values      = values(var.common_tags)
    project_tag     = var.common_tags["Project"]
  }
}

# SET OUTPUTS - Demonstrating set characteristics
output "set_demonstrations" {
  description = "Set type characteristics and operations"
  value = {
    cidr_blocks_set     = var.allowed_cidr_blocks
    cidr_blocks_list    = tolist(var.allowed_cidr_blocks)  # Convert set to list
    set_length          = length(var.allowed_cidr_blocks)
    required_tags_set   = var.required_tags
    metrics_set         = var.monitoring_metrics
  }
}

# COLLECTION OPERATIONS
output "collection_operations" {
  description = "Various collection type operations"
  value = {
    # List operations
    port_range = range(length(var.instance_ports))
    reversed_zones = reverse(var.availability_zones)
    sorted_ports = sort(var.instance_ports)
    
    # Map operations  
    env_upper = {
      for env, type in var.environment_configs :
      upper(env) => type
    }
    
    # Set operations
    cidr_contains_10 = contains(var.allowed_cidr_blocks, "10.0.0.0/8")
    union_example = setunion(var.required_tags, ["CreatedBy", "LastModified"])
  }
}

output "instance_info" {
  description = "Instance information"
  value = {
    instance_id     = aws_instance.web.id
    public_ip       = aws_instance.web.public_ip
    instance_type   = aws_instance.web.instance_type
    environment     = var.current_environment
  }
}
```

**Step 3: Test Collection Types**
```bash
terraform init
terraform plan
terraform apply -auto-approve

# Examine outputs to see collection type behavior
terraform output availability_zones_info
terraform output environment_config_info
terraform output set_demonstrations
```

**Step 4: Test Different Environments**
```bash
# Test with different environment
terraform apply -var="current_environment=prod" -auto-approve
terraform output instance_info

# Test with staging
terraform apply -var="current_environment=staging" -auto-approve
terraform output instance_info
```

**Step 5: Test Web Server**
```bash
# Get instance IP and test web server
INSTANCE_IP=$(terraform output -raw instance_info | jq -r '.public_ip')
echo "Testing web server at: http://$INSTANCE_IP"
curl "http://$INSTANCE_IP"
```

**Step 6: Clean Up**
```bash
terraform destroy -auto-approve
```

### 💻 **Exercise 22.3**: Structural Types with Schemas
**Duration**: 35 minutes

Create object and tuple types with schema validation.

**Step 1: Setup Structural Types Project**
```bash
cd ~/terraform-resources-complex-types
mkdir lab3-structural-types
cd lab3-structural-types
```

**Step 2: Create Structural Type Variables**

Create `variables.tf`:
```hcl
# OBJECT TYPES - Complex schemas
variable "database_config" {
  description = "Database configuration object with schema"
  type = object({
    engine            = string
    engine_version    = string
    instance_class    = string
    allocated_storage = number
    max_allocated_storage = number
    multi_az          = bool
    backup_retention  = number
    monitoring_interval = number
    
    # Nested object
    maintenance_window = object({
      day        = string
      start_time = string  
      duration   = string
    })
    
    # List within object
    parameter_group_parameters = list(object({
      name  = string
      value = string
    }))
  })
  
  default = {
    engine            = "mysql"
    engine_version    = "8.0"
    instance_class    = "db.t3.micro"
    allocated_storage = 20
    max_allocated_storage = 100
    multi_az          = false
    backup_retention  = 7
    monitoring_interval = 60
    
    maintenance_window = {
      day        = "sun"
      start_time = "03:00"
      duration   = "01:00"
    }
    
    parameter_group_parameters = [
      {
        name  = "innodb_buffer_pool_size"
        value = "134217728"  # 128MB
      },
      {
        name  = "max_connections"
        value = "100"
      }
    ]
  }
}

variable "application_stack" {
  description = "Complete application stack configuration"
  type = object({
    name    = string
    version = string
    
    # Infrastructure configuration
    infrastructure = object({
      vpc_cidr    = string
      region      = string
      
      # Nested list of objects
      subnets = list(object({
        name       = string
        cidr_block = string
        az_suffix  = string
        public     = bool
      }))
      
      # Map within object
      security_groups = map(object({
        description = string
        ingress_rules = list(object({
          from_port = number
          to_port   = number
          protocol  = string
          cidrs     = list(string)
        }))
      }))
    })
    
    # Application configuration
    application = object({
      min_instances = number
      max_instances = number
      desired_instances = number
      instance_type = string
      
      # Environment variables as map
      environment_variables = map(string)
      
      # Feature flags
      features = object({
        enable_auto_scaling = bool
        enable_logging      = bool
        enable_metrics      = bool
        enable_tracing      = bool
      })
    })
  })
  
  default = {
    name    = "web-application"
    version = "2.1.0"
    
    infrastructure = {
      vpc_cidr = "10.0.0.0/16"
      region   = "us-west-2"
      
      subnets = [
        {
          name       = "public-1"
          cidr_block = "10.0.1.0/24"
          az_suffix  = "a"
          public     = true
        },
        {
          name       = "public-2"
          cidr_block = "10.0.2.0/24"
          az_suffix  = "b"
          public     = true
        },
        {
          name       = "private-1"
          cidr_block = "10.0.10.0/24"
          az_suffix  = "a"
          public     = false
        },
        {
          name       = "private-2"
          cidr_block = "10.0.20.0/24"
          az_suffix  = "b"
          public     = false
        }
      ]
      
      security_groups = {
        web = {
          description = "Web tier security group"
          ingress_rules = [
            {
              from_port = 80
              to_port   = 80
              protocol  = "tcp"
              cidrs     = ["0.0.0.0/0"]
            },
            {
              from_port = 443
              to_port   = 443
              protocol  = "tcp"
              cidrs     = ["0.0.0.0/0"]
            }
          ]
        },
        app = {
          description = "Application tier security group"
          ingress_rules = [
            {
              from_port = 8080
              to_port   = 8080
              protocol  = "tcp"
              cidrs     = ["10.0.0.0/16"]
            }
          ]
        }
      }
    }
    
    application = {
      min_instances     = 2
      max_instances     = 10
      desired_instances = 3
      instance_type     = "t3.medium"
      
      environment_variables = {
        NODE_ENV     = "production"
        LOG_LEVEL    = "info"
        DATABASE_URL = "mysql://user:pass@localhost/app"
        REDIS_URL    = "redis://localhost:6379"
      }
      
      features = {
        enable_auto_scaling = true
        enable_logging      = true
        enable_metrics      = true
        enable_tracing      = false
      }
    }
  }
}

# TUPLE TYPES - Ordered, mixed-type data
variable "server_specifications" {
  description = "Server specifications as tuples [name, cpu_cores, memory_gb, storage_gb, gpu_enabled]"
  type = list(tuple([string, number, number, number, bool]))
  
  default = [
    ["web-server-1", 2, 4, 50, false],
    ["web-server-2", 2, 4, 50, false], 
    ["app-server-1", 4, 8, 100, false],
    ["db-server-1", 8, 32, 500, false],
    ["ml-server-1", 16, 64, 1000, true]
  ]
}

variable "load_balancer_config" {
  description = "Load balancer listener configuration [protocol, port, ssl_cert_arn, health_check_path]"
  type = tuple([string, number, string, string])
  
  default = ["HTTPS", 443, "arn:aws:acm:us-west-2:123456789012:certificate/12345678-1234-1234-1234-123456789012", "/health"]
}

variable "backup_policies" {
  description = "Backup policies [resource_type, schedule, retention_days, cross_region_copy]"
  type = list(tuple([string, string, number, bool]))
  
  default = [
    ["database", "cron(0 2 * * ? *)", 30, true],      # Daily DB backup, 30 days retention, cross-region copy
    ["filesystem", "cron(0 1 * * ? *)", 7, false],   # Daily filesystem backup, 7 days retention, no cross-region
    ["logs", "cron(0 0 ? * SUN *)", 90, true]        # Weekly log backup, 90 days retention, cross-region copy
  ]
}

# Validation for object types
variable "environment" {
  description = "Current environment"
  type        = string
  default     = "dev"
  
  validation {
    condition = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be dev, staging, or prod."
  }
}
```

Create `main.tf`:
```hcl
terraform {
  required_version = ">= 1.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.application_stack.infrastructure.region
}

# VPC using object configuration
resource "aws_vpc" "main" {
  cidr_block           = var.application_stack.infrastructure.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  
  tags = {
    Name         = "${var.application_stack.name}-vpc"
    Environment  = var.environment
    Application  = var.application_stack.name
    Version      = var.application_stack.version
  }
}

# Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  
  tags = {
    Name = "${var.application_stack.name}-igw"
  }
}

# Subnets using object list iteration
resource "aws_subnet" "subnets" {
  for_each = {
    for idx, subnet in var.application_stack.infrastructure.subnets : 
    subnet.name => subnet
  }
  
  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.value.cidr_block
  availability_zone       = "${var.application_stack.infrastructure.region}${each.value.az_suffix}"
  map_public_ip_on_launch = each.value.public
  
  tags = {
    Name   = "${var.application_stack.name}-${each.value.name}"
    Type   = each.value.public ? "public" : "private"
    Public = each.value.public
  }
}

# Security Groups using nested object structure
resource "aws_security_group" "security_groups" {
  for_each = var.application_stack.infrastructure.security_groups
  
  name_prefix = "${each.key}-"
  vpc_id      = aws_vpc.main.id
  description = each.value.description
  
  tags = {
    Name = "${var.application_stack.name}-${each.key}-sg"
    Tier = each.key
  }
}

# Security Group Rules using nested object iteration
resource "aws_security_group_rule" "ingress_rules" {
  for_each = {
    for sg_name, sg_config in var.application_stack.infrastructure.security_groups :
    sg_name => [
      for idx, rule in sg_config.ingress_rules : {
        sg_name   = sg_name
        rule_key  = "${sg_name}-${idx}"
        from_port = rule.from_port
        to_port   = rule.to_port
        protocol  = rule.protocol
        cidrs     = rule.cidrs
      }
    ]
  }
  
  # Flatten the nested structure
  for_each = merge([
    for sg_name, rules in {
      for sg_name, sg_config in var.application_stack.infrastructure.security_groups :
      sg_name => [
        for idx, rule in sg_config.ingress_rules : {
          sg_name   = sg_name
          rule_key  = "${sg_name}-${idx}"
          from_port = rule.from_port
          to_port   = rule.to_port
          protocol  = rule.protocol
          cidrs     = rule.cidrs
        }
      ]
    } : {
      for rule in rules :
      rule.rule_key => rule
    }
  ]...)
  
  type              = "ingress"
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol
  cidr_blocks       = each.value.cidrs
  security_group_id = aws_security_group.security_groups[each.value.sg_name].id
  
  description = "Rule for ${each.value.sg_name} ${each.value.from_port}-${each.value.to_port}/${each.value.protocol}"
}

# RDS using database object configuration
resource "aws_db_instance" "database" {
  identifier = "${var.application_stack.name}-${var.environment}-db"
  
  # Configuration from database_config object
  engine            = var.database_config.engine
  engine_version    = var.database_config.engine_version
  instance_class    = var.database_config.instance_class
  allocated_storage = var.database_config.allocated_storage
  max_allocated_storage = var.database_config.max_allocated_storage
  
  multi_az             = var.database_config.multi_az
  backup_retention_period = var.database_config.backup_retention
  monitoring_interval  = var.database_config.monitoring_interval
  
  # Using nested object for maintenance window
  maintenance_window = "${var.database_config.maintenance_window.day}:${var.database_config.maintenance_window.start_time}-${var.database_config.maintenance_window.day}:${formatdate("hh:mm", timeadd("${var.database_config.maintenance_window.start_time}:00", var.database_config.maintenance_window.duration))}"
  
  db_name  = replace(var.application_stack.name, "-", "_")
  username = "admin"
  password = "changeme123!"  # Use AWS Secrets Manager in production
  
  vpc_security_group_ids = [aws_security_group.security_groups["app"].id]
  
  skip_final_snapshot = true  # For demo
  deletion_protection = false # For demo
  
  tags = {
    Name = "${var.application_stack.name} Database"
    Environment = var.environment
  }
}

# Launch Template using tuple data
resource "aws_launch_template" "servers" {
  for_each = {
    for idx, server in var.server_specifications : 
    server[0] => {  # server name (tuple index 0)
      name      = server[0]  # string
      cpu_cores = server[1]  # number
      memory_gb = server[2]  # number  
      storage_gb = server[3] # number
      gpu_enabled = server[4] # bool
    }
  }
  
  name_prefix = "${each.value.name}-"
  
  # Map CPU cores to instance types (simplified mapping)
  instance_type = each.value.cpu_cores == 2 ? "t3.small" : 
                  each.value.cpu_cores == 4 ? "t3.medium" :
                  each.value.cpu_cores == 8 ? "t3.large" : "t3.xlarge"
  
  image_id = data.aws_ami.amazon_linux.id
  
  vpc_security_group_ids = [
    contains(["web-server-1", "web-server-2"], each.value.name) ? 
    aws_security_group.security_groups["web"].id :
    aws_security_group.security_groups["app"].id
  ]
  
  # EBS configuration based on tuple storage requirements
  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = each.value.storage_gb
      volume_type = "gp3"
      encrypted   = true
    }
  }
  
  user_data = base64encode(<<-EOF
    #!/bin/bash
    yum update -y
    
    # Create info page
    mkdir -p /var/www/html
    cat > /var/www/html/server-info.html << 'HTML'
    <h1>Server Information</h1>
    <h2>Server: ${each.value.name}</h2>
    <ul>
      <li>CPU Cores: ${each.value.cpu_cores}</li>
      <li>Memory: ${each.value.memory_gb} GB</li>
      <li>Storage: ${each.value.storage_gb} GB</li>
      <li>GPU Enabled: ${each.value.gpu_enabled}</li>
      <li>Instance Type: ${each.value.cpu_cores == 2 ? "t3.small" : each.value.cpu_cores == 4 ? "t3.medium" : each.value.cpu_cores == 8 ? "t3.large" : "t3.xlarge"}</li>
    </ul>
    HTML
    
    # Install and start web server for web servers
    if [[ "${each.value.name}" == *"web-server"* ]]; then
      yum install -y httpd
      systemctl start httpd
      systemctl enable httpd
      cp /var/www/html/server-info.html /var/www/html/index.html
    fi
  EOF
  )
  
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = each.value.name
      CPUCores = tostring(each.value.cpu_cores)
      MemoryGB = tostring(each.value.memory_gb)
      StorageGB = tostring(each.value.storage_gb)
      GPUEnabled = tostring(each.value.gpu_enabled)
      ServerType = contains(["web-server-1", "web-server-2"], each.value.name) ? "web" : 
                   contains(["app-server-1"], each.value.name) ? "app" :
                   contains(["db-server-1"], each.value.name) ? "database" : "ml"
    }
  }
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}
```

Create `locals.tf` to demonstrate complex type operations:
```hcl
locals {
  # Object operations
  public_subnets = [
    for subnet in var.application_stack.infrastructure.subnets : 
    subnet if subnet.public == true
  ]
  
  private_subnets = [
    for subnet in var.application_stack.infrastructure.subnets :
    subnet if subnet.public == false
  ]
  
  # Tuple operations  
  web_servers = [
    for server in var.server_specifications :
    server if can(regex("web-server", server[0]))  # server[0] is name
  ]
  
  high_memory_servers = [
    for server in var.server_specifications :
    server if server[2] > 8  # server[2] is memory_gb
  ]
  
  # Complex transformations
  server_summary = {
    for server in var.server_specifications :
    server[0] => {  # server[0] is name
      specs = "${server[1]}C/${server[2]}GB/${server[3]}GB"  # CPU/Memory/Storage
      gpu   = server[4] ? "GPU-enabled" : "CPU-only"
      tier  = contains(["web-server-1", "web-server-2"], server[0]) ? "web" : 
              contains(["app-server-1"], server[0]) ? "app" :
              contains(["db-server-1"], server[0]) ? "database" : "ml"
    }
  }
  
  # Backup policy analysis
  backup_summary = {
    for policy in var.backup_policies :
    policy[0] => {  # resource_type
      schedule     = policy[1]  # schedule
      retention    = "${policy[2]} days"  # retention_days
      cross_region = policy[3] ? "enabled" : "disabled"  # cross_region_copy
    }
  }
}
```

Create `outputs.tf`:
```hcl
# Object type outputs
output "application_stack_info" {
  description = "Application stack object information"
  value = {
    name    = var.application_stack.name
    version = var.application_stack.version
    region  = var.application_stack.infrastructure.region
    vpc_cidr = var.application_stack.infrastructure.vpc_cidr
    
    # Nested object access
    maintenance_window = {
      day        = var.database_config.maintenance_window.day
      start_time = var.database_config.maintenance_window.start_time
      duration   = var.database_config.maintenance_window.duration
    }
    
    # Application features
    features_enabled = [
      for feature, enabled in var.application_stack.application.features :
      feature if enabled == true
    ]
  }
}

output "database_configuration" {
  description = "Database object configuration"
  value = {
    engine_info = "${var.database_config.engine} ${var.database_config.engine_version}"
    instance_class = var.database_config.instance_class
    storage = {
      allocated = var.database_config.allocated_storage
      max       = var.database_config.max_allocated_storage
    }
    backup_retention = var.database_config.backup_retention
    
    # Parameter group parameters (list within object)
    parameters = {
      for param in var.database_config.parameter_group_parameters :
      param.name => param.value
    }
  }
}

# Tuple type outputs  
output "server_specifications_analysis" {
  description = "Server specifications tuple analysis"
  value = {
    all_servers = [
      for server in var.server_specifications : {
        name      = server[0]  # string at index 0
        cpu_cores = server[1]  # number at index 1
        memory_gb = server[2]  # number at index 2
        storage_gb = server[3] # number at index 3
        gpu_enabled = server[4] # bool at index 4
      }
    ]
    
    server_summary = local.server_summary
    
    # Tuple aggregations
    total_cpu_cores = sum([for server in var.server_specifications : server[1]])
    total_memory_gb = sum([for server in var.server_specifications : server[2]])
    total_storage_gb = sum([for server in var.server_specifications : server[3]])
    gpu_enabled_count = length([for server in var.server_specifications : server if server[4] == true])
  }
}

output "load_balancer_tuple" {
  description = "Load balancer configuration tuple"
  value = {
    protocol        = var.load_balancer_config[0]  # string
    port           = var.load_balancer_config[1]   # number
    ssl_cert_arn   = var.load_balancer_config[2]   # string
    health_check_path = var.load_balancer_config[3] # string
    
    # Tuple validation
    is_secure = var.load_balancer_config[0] == "HTTPS" && var.load_balancer_config[1] == 443
  }
}

output "backup_policies_analysis" {
  description = "Backup policies tuple analysis"
  value = {
    policies = local.backup_summary
    
    # Tuple analysis
    daily_backups = length([
      for policy in var.backup_policies : 
      policy if can(regex("\\* \\* \\?", policy[1]))  # Daily pattern
    ])
    
    cross_region_enabled = length([
      for policy in var.backup_policies :
      policy if policy[3] == true  # cross_region_copy
    ])
  }
}

# Local transformations
output "local_transformations" {
  description = "Complex type transformations using locals"
  value = {
    public_subnets    = local.public_subnets
    private_subnets   = local.private_subnets
    web_servers       = local.web_servers
    high_memory_servers = local.high_memory_servers
  }
}

# Infrastructure outputs
output "infrastructure_details" {
  description = "Created infrastructure details"
  value = {
    vpc_id = aws_vpc.main.id
    subnet_ids = {
      for name, subnet in aws_subnet.subnets :
      name => subnet.id
    }
    security_group_ids = {
      for name, sg in aws_security_group.security_groups :
      name => sg.id
    }
    database_endpoint = aws_db_instance.database.endpoint
    launch_template_ids = {
      for name, lt in aws_launch_template.servers :
      name => lt.id
    }
  }
}
```

**Step 3: Test Structural Types**
```bash
terraform init
terraform plan
terraform apply -auto-approve

# Examine complex outputs
terraform output application_stack_info
terraform output server_specifications_analysis
terraform output local_transformations
```

**Step 4: Validate Schema Enforcement**

Create `terraform.tfvars` with invalid data to test validation:
```hcl
# This should cause validation errors
environment = "invalid"  # Not in allowed list

# Try changing object structure (comment out in terraform.tfvars)
# database_config = {
#   engine = "postgresql"  # Valid
#   # missing required fields - should cause error
# }
```

Test validation:
```bash
terraform plan -var="environment=invalid"
# Should show validation error
```

**Step 5: Test Terraform Console for Complex Types**

Following the transcript's hands-on approach:
```bash
terraform console

# Test object access
> var.application_stack.name
> var.application_stack.infrastructure.vpc_cidr
> var.database_config.maintenance_window.day

# Test tuple access  
> var.server_specifications[0][0]  # First server name
> var.server_specifications[0][1]  # First server CPU cores
> var.load_balancer_config[0]      # Protocol

# Test local transformations
> local.public_subnets
> local.server_summary

# Exit console
> exit
```

**Step 6: Clean Up**
```bash
terraform destroy -auto-approve
```

### 💻 **Exercise 22.4**: Complex Types in Production
**Duration**: 30 minutes

Build production infrastructure using advanced complex type patterns.

**Step 1: Setup Production Project**
```bash
cd ~/terraform-resources-complex-types
mkdir lab4-production-complex-types
cd lab4-production-complex-types
```

**Step 2: Create Production Configuration**

Create `variables.tf`:
```hcl
variable "environments" {
  description = "Multi-environment configuration using complex types"
  type = map(object({
    # Network configuration
    vpc_cidr = string
    availability_zones = list(string)
    
    # Subnet configuration using list of objects
    subnets = list(object({
      name       = string
      cidr_block = string
      subnet_type = string  # "public", "private", "database"
      az_index   = number
    }))
    
    # Application tiers using nested objects
    application_tiers = map(object({
      instance_type = string
      min_capacity  = number
      max_capacity  = number
      desired_capacity = number
      
      # Security configuration
      security_config = object({
        ingress_ports = list(number)
        egress_allowed = bool
        source_cidrs = list(string)
      })
      
      # Auto scaling configuration
      scaling_config = object({
        scale_up_threshold   = number
        scale_down_threshold = number
        scale_up_cooldown    = number
        scale_down_cooldown  = number
      })
    }))
    
    # Database configuration per environment
    database = object({
      instance_class = string
      allocated_storage = number
      multi_az = bool
      backup_retention = number
      
      # Performance configuration
      performance_config = object({
        monitoring_interval = number
        performance_insights = bool
        max_connections = number
      })
    })
    
    # Monitoring and alerting using tuples
    # Format: [metric_name, threshold, comparison_operator, alarm_actions_enabled]
    monitoring_rules = list(tuple([string, number, string, bool]))
  }))
  
  default = {
    dev = {
      vpc_cidr = "10.1.0.0/16"
      availability_zones = ["us-west-2a", "us-west-2b"]
      
      subnets = [
        {
          name        = "dev-public-1"
          cidr_block  = "10.1.1.0/24"
          subnet_type = "public"
          az_index    = 0
        },
        {
          name        = "dev-public-2" 
          cidr_block  = "10.1.2.0/24"
          subnet_type = "public"
          az_index    = 1
        },
        {
          name        = "dev-private-1"
          cidr_block  = "10.1.11.0/24"
          subnet_type = "private"
          az_index    = 0
        },
        {
          name        = "dev-private-2"
          cidr_block  = "10.1.12.0/24"
          subnet_type = "private"
          az_index    = 1
        }
      ]
      
      application_tiers = {
        web = {
          instance_type    = "t3.micro"
          min_capacity     = 1
          max_capacity     = 2
          desired_capacity = 1
          
          security_config = {
            ingress_ports  = [80, 443]
            egress_allowed = true
            source_cidrs   = ["0.0.0.0/0"]
          }
          
          scaling_config = {
            scale_up_threshold   = 70
            scale_down_threshold = 30
            scale_up_cooldown    = 300
            scale_down_cooldown  = 300
          }
        }
        
        app = {
          instance_type    = "t3.small"
          min_capacity     = 1
          max_capacity     = 3
          desired_capacity = 1
          
          security_config = {
            ingress_ports  = [8080, 8443]
            egress_allowed = true
            source_cidrs   = ["10.1.0.0/16"]
          }
          
          scaling_config = {
            scale_up_threshold   = 60
            scale_down_threshold = 20
            scale_up_cooldown    = 300
            scale_down_cooldown  = 600
          }
        }
      }
      
      database = {
        instance_class    = "db.t3.micro"
        allocated_storage = 20
        multi_az         = false
        backup_retention = 7
        
        performance_config = {
          monitoring_interval   = 60
          performance_insights = false
          max_connections      = 100
        }
      }
      
      monitoring_rules = [
        ["CPUUtilization", 80, "GreaterThanThreshold", true],
        ["DatabaseConnections", 80, "GreaterThanThreshold", false],
        ["NetworkIn", 1000000, "GreaterThanThreshold", false]
      ]
    }
    
    prod = {
      vpc_cidr = "10.0.0.0/16"
      availability_zones = ["us-west-2a", "us-west-2b", "us-west-2c"]
      
      subnets = [
        {
          name        = "prod-public-1"
          cidr_block  = "10.0.1.0/24"
          subnet_type = "public"
          az_index    = 0
        },
        {
          name        = "prod-public-2"
          cidr_block  = "10.0.2.0/24"
          subnet_type = "public"
          az_index    = 1
        },
        {
          name        = "prod-public-3"
          cidr_block  = "10.0.3.0/24"
          subnet_type = "public"
          az_index    = 2
        },
        {
          name        = "prod-private-1"
          cidr_block  = "10.0.11.0/24"
          subnet_type = "private"
          az_index    = 0
        },
        {
          name        = "prod-private-2"
          cidr_block  = "10.0.12.0/24"
          subnet_type = "private"
          az_index    = 1
        },
        {
          name        = "prod-private-3"
          cidr_block  = "10.0.13.0/24"
          subnet_type = "private"
          az_index    = 2
        },
        {
          name        = "prod-database-1"
          cidr_block  = "10.0.21.0/24"
          subnet_type = "database"
          az_index    = 0
        },
        {
          name        = "prod-database-2"
          cidr_block  = "10.0.22.0/24"
          subnet_type = "database"
          az_index    = 1
        }
      ]
      
      application_tiers = {
        web = {
          instance_type    = "t3.medium"
          min_capacity     = 2
          max_capacity     = 10
          desired_capacity = 3
          
          security_config = {
            ingress_ports  = [80, 443]
            egress_allowed = true
            source_cidrs   = ["0.0.0.0/0"]
          }
          
          scaling_config = {
            scale_up_threshold   = 70
            scale_down_threshold = 30
            scale_up_cooldown    = 300
            scale_down_cooldown  = 300
          }
        }
        
        app = {
          instance_type    = "t3.large"
          min_capacity     = 2
          max_capacity     = 20
          desired_capacity = 4
          
          security_config = {
            ingress_ports  = [8080, 8443]
            egress_allowed = true
            source_cidrs   = ["10.0.0.0/16"]
          }
          
          scaling_config = {
            scale_up_threshold   = 60
            scale_down_threshold = 20
            scale_up_cooldown    = 180
            scale_down_cooldown  = 600
          }
        }
      }
      
      database = {
        instance_class    = "db.t3.medium"
        allocated_storage = 100
        multi_az         = true
        backup_retention = 30
        
        performance_config = {
          monitoring_interval   = 60
          performance_insights = true
          max_connections      = 1000
        }
      }
      
      monitoring_rules = [
        ["CPUUtilization", 75, "GreaterThanThreshold", true],
        ["DatabaseConnections", 800, "GreaterThanThreshold", true],
        ["NetworkIn", 5000000, "GreaterThanThreshold", true],
        ["DiskSpaceUtilization", 80, "GreaterThanThreshold", true],
        ["MemoryUtilization", 85, "GreaterThanThreshold", true]
      ]
    }
  }
}

variable "current_environment" {
  description = "Current environment to deploy"
  type        = string
  default     = "dev"
  
  validation {
    condition = contains(keys(var.environments), var.current_environment)
    error_message = "Environment must be one of: ${join(", ", keys(var.environments))}."
  }
}

variable "deployment_config" {
  description = "Deployment configuration tuple [timestamp, version, deployer, rollback_enabled]"
  type        = tuple([string, string, string, bool])
  default     = ["2024-01-15T10:30:00Z", "1.2.3", "terraform", true]
}
```

Create `main.tf`:
```hcl
terraform {
  required_version = ">= 1.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"
  
  default_tags {
    tags = {
      Environment     = var.current_environment
      DeployedBy      = var.deployment_config[2]  # deployer from tuple
      DeploymentTime  = var.deployment_config[0]  # timestamp from tuple
      Version         = var.deployment_config[1]  # version from tuple
      ManagedBy       = "terraform"
    }
  }
}

# Get current environment configuration
locals {
  env_config = var.environments[var.current_environment]
  
  # Complex type transformations
  public_subnets = {
    for subnet in local.env_config.subnets :
    subnet.name => subnet if subnet.subnet_type == "public"
  }
  
  private_subnets = {
    for subnet in local.env_config.subnets :
    subnet.name => subnet if subnet.subnet_type == "private"
  }
  
  database_subnets = {
    for subnet in local.env_config.subnets :
    subnet.name => subnet if subnet.subnet_type == "database"
  }
  
  # Monitoring rules analysis
  critical_alerts = [
    for rule in local.env_config.monitoring_rules :
    rule if rule[3] == true  # alarm_actions_enabled
  ]
}

# VPC
resource "aws_vpc" "main" {
  cidr_block           = local.env_config.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  
  tags = {
    Name = "${var.current_environment}-vpc"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  
  tags = {
    Name = "${var.current_environment}-igw"
  }
}

# Subnets using complex object iteration
resource "aws_subnet" "subnets" {
  for_each = {
    for subnet in local.env_config.subnets :
    subnet.name => subnet
  }
  
  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value.cidr_block
  availability_zone = local.env_config.availability_zones[each.value.az_index]
  
  map_public_ip_on_launch = each.value.subnet_type == "public"
  
  tags = {
    Name = each.value.name
    Type = each.value.subnet_type
    AZ   = local.env_config.availability_zones[each.value.az_index]
  }
}

# Route Table for Public Subnets
resource "aws_route_table" "public" {
  count = length(local.public_subnets) > 0 ? 1 : 0
  
  vpc_id = aws_vpc.main.id
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
  
  tags = {
    Name = "${var.current_environment}-public-rt"
  }
}

# Route Table Associations for Public Subnets
resource "aws_route_table_association" "public" {
  for_each = local.public_subnets
  
  subnet_id      = aws_subnet.subnets[each.key].id
  route_table_id = aws_route_table.public[0].id
}

# Security Groups using nested object configuration
resource "aws_security_group" "application_tiers" {
  for_each = local.env_config.application_tiers
  
  name_prefix = "${var.current_environment}-${each.key}-"
  vpc_id      = aws_vpc.main.id
  description = "Security group for ${each.key} tier in ${var.current_environment}"
  
  tags = {
    Name = "${var.current_environment}-${each.key}-sg"
    Tier = each.key
  }
}

# Security Group Rules using nested object iteration
resource "aws_security_group_rule" "ingress" {
  for_each = {
    for tier_name, tier_config in local.env_config.application_tiers :
    tier_name => [
      for idx, port in tier_config.security_config.ingress_ports : {
        tier      = tier_name
        port      = port
        rule_key  = "${tier_name}-${port}"
        cidrs     = tier_config.security_config.source_cidrs
      }
    ]
  }
  
  # Flatten nested structure
  for_each = merge([
    for tier_name, rules in {
      for tier_name, tier_config in local.env_config.application_tiers :
      tier_name => [
        for idx, port in tier_config.security_config.ingress_ports : {
          tier      = tier_name
          port      = port
          rule_key  = "${tier_name}-${port}"
          cidrs     = tier_config.security_config.source_cidrs
        }
      ]
    } : {
      for rule in rules :
      rule.rule_key => rule
    }
  ]...)
  
  type              = "ingress"
  from_port         = each.value.port
  to_port           = each.value.port
  protocol          = "tcp"
  cidr_blocks       = each.value.cidrs
  security_group_id = aws_security_group.application_tiers[each.value.tier].id
  
  description = "Allow port ${each.value.port} for ${each.value.tier} tier"
}

# Egress rules for tiers that allow egress
resource "aws_security_group_rule" "egress" {
  for_each = {
    for tier_name, tier_config in local.env_config.application_tiers :
    tier_name => tier_config if tier_config.security_config.egress_allowed
  }
  
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.application_tiers[each.key].id
  
  description = "Allow all outbound traffic for ${each.key} tier"
}

# Database Subnet Group (if database subnets exist)
resource "aws_db_subnet_group" "database" {
  count = length(local.database_subnets) > 0 ? 1 : 0
  
  name       = "${var.current_environment}-db-subnet-group"
  subnet_ids = [for subnet_name, subnet_config in local.database_subnets : aws_subnet.subnets[subnet_name].id]
  
  tags = {
    Name = "${var.current_environment} Database Subnet Group"
  }
}

# RDS Instance using complex database configuration
resource "aws_db_instance" "main" {
  identifier = "${var.current_environment}-database"
  
  engine         = "mysql"
  engine_version = "8.0"
  instance_class = local.env_config.database.instance_class
  
  allocated_storage = local.env_config.database.allocated_storage
  storage_type      = "gp2"
  storage_encrypted = true
  
  multi_az                = local.env_config.database.multi_az
  backup_retention_period = local.env_config.database.backup_retention
  
  # Performance configuration from nested object
  monitoring_interval                 = local.env_config.database.performance_config.monitoring_interval
  performance_insights_enabled       = local.env_config.database.performance_config.performance_insights
  performance_insights_retention_period = local.env_config.database.performance_config.performance_insights ? 7 : null
  
  db_name  = "${var.current_environment}db"
  username = "admin"
  password = "changeme123!"  # Use AWS Secrets Manager in production
  
  db_subnet_group_name   = length(local.database_subnets) > 0 ? aws_db_subnet_group.database[0].name : null
  vpc_security_group_ids = [aws_security_group.application_tiers["app"].id]  # App tier access
  
  skip_final_snapshot = true  # For demo
  deletion_protection = var.current_environment == "prod" ? true : false
  
  # Custom timeouts based on environment
  timeouts {
    create = var.current_environment == "prod" ? "60m" : "30m"
    update = var.current_environment == "prod" ? "80m" : "40m"
    delete = "30m"
  }
  
  tags = {
    Name = "${title(var.current_environment)} Database"
    MultiAZ = tostring(local.env_config.database.multi_az)
  }
}

# Launch Templates for Application Tiers
resource "aws_launch_template" "application_tiers" {
  for_each = local.env_config.application_tiers
  
  name_prefix   = "${var.current_environment}-${each.key}-"
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = each.value.instance_type
  
  vpc_security_group_ids = [aws_security_group.application_tiers[each.key].id]
  
  user_data = base64encode(templatefile("${path.module}/user_data.sh", {
    tier_name        = each.key
    environment      = var.current_environment
    database_endpoint = aws_db_instance.main.endpoint
    deployment_info  = var.deployment_config
  }))
  
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.current_environment}-${each.key}"
      Tier = each.key
      Environment = var.current_environment
    }
  }
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}
```

Create `user_data.sh`:
```bash
#!/bin/bash
yum update -y

# Install CloudWatch agent
wget https://s3.amazonaws.com/amazoncloudwatch-agent/amazon_linux/amd64/latest/amazon-cloudwatch-agent.rpm
rpm -U ./amazon-cloudwatch-agent.rpm

# Create application directory
mkdir -p /opt/app
cd /opt/app

# Create application info file
cat > app-info.json << 'EOF'
{
  "tier": "${tier_name}",
  "environment": "${environment}",
  "database_endpoint": "${database_endpoint}",
  "deployment": {
    "timestamp": "${deployment_info[0]}",
    "version": "${deployment_info[1]}",
    "deployer": "${deployment_info[2]}",
    "rollback_enabled": ${deployment_info[3]}
  }
}
EOF

# Install web server for web tier
if [ "${tier_name}" = "web" ]; then
  yum install -y httpd
  systemctl start httpd
  systemctl enable httpd
  
  # Create web page
  cat > /var/www/html/index.html << 'HTML'
<html>
<head><title>${tier_name} - ${environment}</title></head>
<body>
  <h1>${title(tier_name)} Tier - ${title(environment)} Environment</h1>
  <h2>Deployment Information</h2>
  <ul>
    <li>Version: ${deployment_info[1]}</li>
    <li>Deployed by: ${deployment_info[2]}</li>
    <li>Timestamp: ${deployment_info[0]}</li>
    <li>Rollback enabled: ${deployment_info[3]}</li>
  </ul>
  <h2>Database Connection</h2>
  <p>Database endpoint: ${database_endpoint}</p>
</body>
</html>
HTML
fi

# Log deployment info
logger "Application ${tier_name} deployed in ${environment} environment"
```

Create `outputs.tf`:
```hcl
# Environment configuration analysis
output "environment_analysis" {
  description = "Analysis of current environment configuration"
  value = {
    environment = var.current_environment
    vpc_cidr    = local.env_config.vpc_cidr
    
    # Subnet analysis
    subnet_breakdown = {
      public   = length(local.public_subnets)
      private  = length(local.private_subnets) 
      database = length(local.database_subnets)
      total    = length(local.env_config.subnets)
    }
    
    # Application tier analysis
    tier_summary = {
      for tier_name, tier_config in local.env_config.application_tiers :
      tier_name => {
        instance_type = tier_config.instance_type
        capacity_range = "${tier_config.min_capacity}-${tier_config.max_capacity}"
        scaling_thresholds = "${tier_config.scaling_config.scale_down_threshold}%-${tier_config.scaling_config.scale_up_threshold}%"
        ports = join(",", [for port in tier_config.security_config.ingress_ports : tostring(port)])
      }
    }
    
    # Database configuration
    database_summary = {
      instance_class = local.env_config.database.instance_class
      storage = "${local.env_config.database.allocated_storage}GB"
      multi_az = local.env_config.database.multi_az
      backup_retention = "${local.env_config.database.backup_retention} days"
      performance_insights = local.env_config.database.performance_config.performance_insights
    }
  }
}

# Tuple analysis outputs
output "deployment_analysis" {
  description = "Deployment configuration from tuple"
  value = {
    timestamp = var.deployment_config[0]
    version   = var.deployment_config[1]
    deployer  = var.deployment_config[2]
    rollback_enabled = var.deployment_config[3]
    
    # Derived information
    deployment_date = formatdate("YYYY-MM-DD", var.deployment_config[0])
    is_production_deploy = var.current_environment == "prod"
    safety_enabled = var.deployment_config[3] && var.current_environment == "prod"
  }
}

# Monitoring rules analysis
output "monitoring_analysis" {
  description = "Monitoring rules analysis from tuples"
  value = {
    total_rules = length(local.env_config.monitoring_rules)
    critical_alerts = length(local.critical_alerts)
    
    # Rule breakdown
    rules_by_metric = {
      for rule in local.env_config.monitoring_rules :
      rule[0] => {  # metric_name
        threshold = rule[1]      # threshold
        operator  = rule[2]      # comparison_operator
        enabled   = rule[3]      # alarm_actions_enabled
      }
    }
    
    # Alert summary
    alert_summary = [
      for rule in local.critical_alerts :
      "${rule[0]}: ${rule[1]} (${rule[2]})"
    ]
  }
}

# Infrastructure outputs
output "infrastructure_details" {
  description = "Created infrastructure details"
  value = {
    vpc_id = aws_vpc.main.id
    
    subnets_by_type = {
      public = {
        for name, subnet in local.public_subnets :
        name => aws_subnet.subnets[name].id
      }
      private = {
        for name, subnet in local.private_subnets :
        name => aws_subnet.subnets[name].id
      }
      database = {
        for name, subnet in local.database_subnets :
        name => aws_subnet.subnets[name].id
      }
    }
    
    security_groups = {
      for tier_name, sg in aws_security_group.application_tiers :
      tier_name => sg.id
    }
    
    database_info = {
      endpoint = aws_db_instance.main.endpoint
      port     = aws_db_instance.main.port
      multi_az = aws_db_instance.main.multi_az
    }
    
    launch_templates = {
      for tier_name, lt in aws_launch_template.application_tiers :
      tier_name => {
        id      = lt.id
        version = lt.latest_version
      }
    }
  }
}

# Complex type demonstrations
output "complex_type_demonstrations" {
  description = "Examples of complex type usage patterns"
  value = {
    # Object nesting levels
    nested_object_access = {
      db_monitoring_interval = local.env_config.database.performance_config.monitoring_interval
      web_tier_scale_up = local.env_config.application_tiers.web.scaling_config.scale_up_threshold
      app_tier_ingress_ports = local.env_config.application_tiers.app.security_config.ingress_ports
    }
    
    # Tuple indexing examples
    tuple_access = {
      deployment_timestamp = var.deployment_config[0]
      first_monitoring_rule_metric = local.env_config.monitoring_rules[0][0]
      first_monitoring_rule_threshold = local.env_config.monitoring_rules[0][1]
    }
    
    # Collection transformations
    transformations = {
      availability_zone_count = length(local.env_config.availability_zones)
      total_application_tiers = length(keys(local.env_config.application_tiers))
      subnet_types = distinct([for subnet in local.env_config.subnets : subnet.subnet_type])
    }
  }
}
```

**Step 3: Deploy Different Environments**
```bash
terraform init

# Deploy development environment
terraform apply -var="current_environment=dev" -auto-approve
terraform output environment_analysis

# Deploy production environment
terraform apply -var="current_environment=prod" -auto-approve
terraform output environment_analysis

# Compare outputs to see differences
```

**Step 4: Test Complex Type Manipulations**
```bash
terraform console

# Test complex object access
> local.env_config.application_tiers.web.scaling_config.scale_up_threshold
> var.environments.prod.database.performance_config.performance_insights

# Test tuple operations
> var.deployment_config[0]
> local.env_config.monitoring_rules[0][0]

# Test transformations
> local.public_subnets
> local.critical_alerts

> exit
```

**Step 5: Validate Production vs Dev Differences**
```bash
# Check outputs for differences
terraform output deployment_analysis
terraform output monitoring_analysis
terraform output infrastructure_details
```

**Step 6: Clean Up**
```bash
terraform destroy -auto-approve
```

---

## ✅ Module 22 Summary

### 🎯 Key Takeaways
- **🏗️ Resources** represent infrastructure objects with configurable timeouts and nested blocks
- **📦 Collection Types** group similar values: list (indexed), map (key-value), set (unique, unordered)
- **🔧 Structural Types** group mixed types with schemas: object (typed map), tuple (typed array)
- **📋 Schema Enforcement** ensures type safety and validates data structure requirements
- **🎯 Type Constructors** provide both shorthand and explicit syntax for complex type definitions
- **🔄 Complex Transformations** enable sophisticated infrastructure patterns using nested structures

### 🔑 Essential Concepts Learned
```hcl
# Collection Types
list(string)    # ["item1", "item2"] - indexed access [0], [1]
map(string)     # {key1 = "val1"}   - key access ["key1"] 
set(string)     # ["a", "b", "b"]   - unique values, no indexing

# Structural Types  
object({        # Schema-enforced mixed types
  name = string
  port = number
})

tuple([string, number, bool])  # Position-enforced mixed types
```

### 💡 Pro Tips Recap
- **Use objects over maps** when you need type safety and schema validation
- **Use tuples for fixed-structure data** where position matters (like CSV-like data)
- **Sets automatically handle uniqueness** - perfect for security group rules
- **Schema validation catches errors early** - define strict object schemas in production
- **Nested complex types** enable sophisticated configuration patterns
- **Local transformations** help manipulate complex types for resource iteration

### 🧠 Knowledge Check Questions

**1. What is the key difference between collection and structural types?**
- A) Collection types are faster
- B) Collection types group similar values, structural types group mixed types
- C) Structural types don't support nesting
- D) Collection types require schemas

**2. According to the transcript, what makes sets different from lists?**
- A) Sets are faster
- B) Sets have no secondary index or preserved ordering
- C) Sets can store different types
- D) Sets require explicit typing

**3. What do structural types require that collection types don't?**
- A) More memory
- B) A schema as an argument
- C) Special providers
- D) Version constraints

**4. How do you access the second element of a tuple?**
- A) `tuple.second`
- B) `tuple["1"]`
- C) `tuple[1]`
- D) `tuple.1`

**5. What happens if you try to access a set by index like `set[0]`?**
- A) Returns the first element
- B) Returns null
- C) Causes an error
- D) Returns the entire set

**6. According to the transcript, how is an object different from a map?**
- A) Objects are faster
- B) Object is a map with more explicit keying
- C) Objects can't be nested
- D) Objects only store strings

<details>
<summary>🔍 Click for Answers</summary>

1. **B** - From transcript: *"collection types for grouping similar values... structural types for grouping potentially to similar values"*
2. **B** - Transcript states: *"set it is similar to a list but has no secondary index or preserved ordering"*
3. **B** - Transcript explains: *"structural types require a schema as an argument to specify which types are allowed"*
4. **C** - Tuples use zero-based indexing like lists: `tuple[1]` for the second element
5. **C** - Sets don't support indexing operations - this would cause a Terraform error
6. **B** - From transcript: *"object is a map with more explicit keying"*

</details>

---

**🎉 Congratulations!** You've completed Module 22 and now master Terraform's complex type system. You understand how to use collection types for grouping similar data, structural types for mixed-type schemas, and how to apply these patterns in production infrastructure.

The transcript's hands-on approach showed you: *"structural types require a schema as an argument to specify which types are allowed for which elements"* - this schema enforcement is what makes complex types so powerful for maintaining infrastructure consistency.

**➡️ Ready for Module 23?** You now have the foundation to tackle advanced Terraform features with a solid understanding of how to structure and validate complex data in your configurations!

---

---

## 🔗 **Next Steps**

Ready to continue your Terraform journey? Proceed to the next module:

**➡️ [Module 23: Built-in Functions](./module_23_built_in_functions.md)**

Master Terraform's built-in functions for data manipulation and logic.

---
