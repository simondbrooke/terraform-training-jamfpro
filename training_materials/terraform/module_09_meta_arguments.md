

# 🔧 Module 09: Meta Arguments

**⏱️ Duration**: 60 minutes  
**🎯 Difficulty**: Intermediate  
**📋 Prerequisites**: Completed Modules 1-8

## 🎯 Learning Objectives

By the end of this module, you will be able to:

- ✅ **Control resource dependencies** using `depends_on` for explicit ordering
- ✅ **Create multiple resource instances** using `count` and `for_each`
- ✅ **Manage resource lifecycles** with lifecycle blocks and rules
- ✅ **Configure provider aliases** for multi-region and multi-account deployments
- ✅ **Implement advanced resource patterns** for complex infrastructure scenarios
- ✅ **Debug and troubleshoot** meta argument configurations effectively

---

## 📚 What Are Meta Arguments?

**Meta arguments** are special arguments available to **all resource types** that control how Terraform manages resources. They modify resource behavior beyond the resource's own configuration.

**🔧 Available Meta Arguments:**
- **`depends_on`** - Explicit dependencies
- **`count`** - Multiple instances with numeric indexing
- **`for_each`** - Multiple instances with key-value mapping
- **`provider`** - Non-default provider selection
- **`lifecycle`** - Resource lifecycle management

```hcl
# Meta arguments example
resource "aws_instance" "web" {
  # Regular resource arguments
  ami           = "ami-12345"
  instance_type = "t3.micro"
  
  # Meta arguments
  count      = 3                    # Create 3 instances
  depends_on = [aws_vpc.main]       # Wait for VPC
  provider   = aws.us_west_2        # Use specific provider
  
  lifecycle {
    create_before_destroy = true    # Lifecycle rule
  }
  
  tags = {
    Name = "web-${count.index}"     # Use count.index
  }
}
```

---

## 🔗 depends_on: Explicit Dependencies

Terraform automatically handles **implicit dependencies** through resource references, but sometimes you need **explicit control** over resource creation order.

### 🎯 When to Use depends_on

**✅ Use depends_on when:**
- Dependencies aren't expressed through resource attributes
- You need to ensure ordering for external reasons
- Resources have logical dependencies not visible to Terraform
- Working with provisioners that need specific ordering

**❌ Avoid depends_on when:**
- You can use resource attribute references instead
- The dependency is already implicit
- You're trying to work around configuration issues

### 🔧 Basic depends_on Usage

```hcl
# VPC and Internet Gateway
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  
  tags = {
    Name = "main-vpc"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id  # Implicit dependency
  
  tags = {
    Name = "main-igw"
  }
}

# Route table with explicit dependency
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  
  # Explicit dependency - IGW must exist first
  depends_on = [aws_internet_gateway.main]
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
  
  tags = {
    Name = "public-route-table"
  }
}

# Security group that depends on multiple resources
resource "aws_security_group" "web" {
  name_prefix = "web-sg-"
  vpc_id      = aws_vpc.main.id
  
  # Multiple explicit dependencies
  depends_on = [
    aws_vpc.main,
    aws_internet_gateway.main,
    aws_route_table.public
  ]
  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = {
    Name = "web-security-group"
  }
}
```

### 🏗️ Complex Dependencies with Modules

```hcl
# Module dependencies
module "networking" {
  source = "./modules/networking"
  
  vpc_cidr = var.vpc_cidr
  environment = var.environment
}

module "database" {
  source = "./modules/database"
  
  vpc_id     = module.networking.vpc_id
  subnet_ids = module.networking.private_subnet_ids
  
  # Explicit dependency on networking module
  depends_on = [module.networking]
}

module "application" {
  source = "./modules/application"
  
  vpc_id           = module.networking.vpc_id
  subnet_ids       = module.networking.public_subnet_ids
  database_endpoint = module.database.endpoint
  
  # Wait for both networking and database
  depends_on = [
    module.networking,
    module.database
  ]
}
```

---

## 🔢 count: Creating Multiple Resources

The **`count`** meta argument creates multiple instances of a resource using **numeric indexing**.

### 🎯 Basic count Usage

```hcl
# Create multiple EC2 instances
resource "aws_instance" "web" {
  count = 3  # Creates 3 instances: web[0], web[1], web[2]
  
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.public[count.index].id
  
  tags = {
    Name = "web-server-${count.index + 1}"  # web-server-1, web-server-2, web-server-3
    Index = count.index                      # 0, 1, 2
  }
}

# Create subnets across availability zones
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

### 🔄 Dynamic count with Variables

```hcl
# variables.tf
variable "instance_count" {
  description = "Number of instances to create"
  type        = number
  default     = 2
  
  validation {
    condition     = var.instance_count >= 1 && var.instance_count <= 10
    error_message = "Instance count must be between 1 and 10."
  }
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

# main.tf
locals {
  # Conditional count based on environment
  instance_count = var.environment == "prod" ? var.instance_count * 2 : var.instance_count
}

resource "aws_instance" "app" {
  count = local.instance_count
  
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.environment == "prod" ? "t3.small" : "t2.micro"
  
  tags = {
    Name        = "${var.environment}-app-${count.index + 1}"
    Environment = var.environment
    Index       = count.index
  }
}

# Output all instance IDs
output "instance_ids" {
  description = "List of instance IDs"
  value       = aws_instance.app[*].id
}

# Output specific instance
output "first_instance_ip" {
  description = "IP of the first instance"
  value       = aws_instance.app[0].public_ip
}
```

### ⚠️ count Limitations and Considerations

```hcl
# ❌ PROBLEM: Removing middle element causes recreation
variable "server_names" {
  default = ["web1", "web2", "web3"]
}

resource "aws_instance" "servers" {
  count = length(var.server_names)
  
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  
  tags = {
    Name = var.server_names[count.index]
  }
}

# If you remove "web2", "web3" becomes "web2" and gets recreated!
```

💡 **Pro Tip**: Use `for_each` instead of `count` when dealing with collections that might change, as it uses keys instead of numeric indices!

---

## 🗝️ for_each: Key-Value Resource Creation

The **`for_each`** meta argument creates multiple instances using **keys from a map or set**, providing more stable resource management than `count`.

### 🎯 for_each with Sets

```hcl
# Create instances for specific environments
variable "environments" {
  description = "Set of environments to create"
  type        = set(string)
  default     = ["dev", "staging", "prod"]
}

resource "aws_instance" "env_servers" {
  for_each = var.environments
  
  ami           = data.aws_ami.ubuntu.id
  instance_type = each.key == "prod" ? "t3.medium" : "t2.micro"
  
  tags = {
    Name        = "${each.key}-server"      # each.key = "dev", "staging", "prod"
    Environment = each.key
  }
}

# Output all instances
output "environment_servers" {
  value = {
    for env, instance in aws_instance.env_servers :
    env => {
      id        = instance.id
      public_ip = instance.public_ip
    }
  }
}
```

### 🗺️ for_each with Maps

```hcl
# Complex configuration with maps
variable "server_config" {
  description = "Server configurations"
  type = map(object({
    instance_type = string
    volume_size   = number
    environment   = string
  }))
  
  default = {
    web = {
      instance_type = "t3.small"
      volume_size   = 20
      environment   = "prod"
    }
    api = {
      instance_type = "t3.medium"
      volume_size   = 30
      environment   = "prod"
    }
    worker = {
      instance_type = "t3.large"
      volume_size   = 50
      environment   = "prod"
    }
  }
}

resource "aws_instance" "servers" {
  for_each = var.server_config
  
  ami           = data.aws_ami.ubuntu.id
  instance_type = each.value.instance_type
  
  root_block_device {
    volume_size = each.value.volume_size
    volume_type = "gp3"
    encrypted   = true
  }
  
  tags = {
    Name        = "${each.key}-server"           # each.key = "web", "api", "worker"
    Type        = each.key
    Environment = each.value.environment         # each.value = entire object
    VolumeSize  = each.value.volume_size
  }
}

# Create security groups for each server type
resource "aws_security_group" "server_sg" {
  for_each = var.server_config
  
  name_prefix = "${each.key}-sg-"
  vpc_id      = aws_vpc.main.id
  description = "Security group for ${each.key} servers"
  
  # Dynamic rules based on server type
  dynamic "ingress" {
    for_each = each.key == "web" ? [80, 443] : each.key == "api" ? [8080] : []
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = {
    Name = "${each.key}-security-group"
    Type = each.key
  }
}
```

### 🔄 for_each with Data Sources

```hcl
# Get all availability zones
data "aws_availability_zones" "available" {
  state = "available"
}

# Create subnets in each AZ using for_each
locals {
  # Convert list to set for for_each
  availability_zones = toset(data.aws_availability_zones.available.names)
}

resource "aws_subnet" "public" {
  for_each = local.availability_zones
  
  vpc_id            = aws_vpc.main.id
  availability_zone = each.key
  cidr_block        = "10.0.${index(sort(data.aws_availability_zones.available.names), each.key) + 1}.0/24"
  
  map_public_ip_on_launch = true
  
  tags = {
    Name = "public-subnet-${each.key}"
    AZ   = each.key
    Type = "public"
  }
}

# Create NAT gateways in each public subnet
resource "aws_eip" "nat" {
  for_each = aws_subnet.public
  
  domain = "vpc"
  
  tags = {
    Name = "nat-eip-${each.key}"
  }
}

resource "aws_nat_gateway" "main" {
  for_each = aws_subnet.public
  
  allocation_id = aws_eip.nat[each.key].id
  subnet_id     = each.value.id
  
  tags = {
    Name = "nat-gateway-${each.key}"
  }
  
  depends_on = [aws_internet_gateway.main]
}
```

---

## ♻️ lifecycle: Resource Lifecycle Management

The **`lifecycle`** meta argument controls how Terraform manages resource creation, updates, and destruction.

### 🔧 Lifecycle Rules

```hcl
resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  
  lifecycle {
    # Create new resource before destroying old one
    create_before_destroy = true
    
    # Prevent accidental destruction
    prevent_destroy = false  # Set to true for production
    
    # Ignore changes to these attributes
    ignore_changes = [
      ami,           # Ignore AMI updates
      user_data,     # Ignore user data changes
      tags["LastUpdated"]  # Ignore specific tag changes
    ]
  }
  
  tags = {
    Name        = "web-server"
    LastUpdated = timestamp()
  }
}
```

### 🛡️ Advanced Lifecycle Management

```hcl
# Database with protection
resource "aws_db_instance" "main" {
  identifier = "main-database"
  
  engine         = "mysql"
  engine_version = "8.0"
  instance_class = "db.t3.micro"
  
  allocated_storage = 20
  storage_type      = "gp2"
  storage_encrypted = true
  
  db_name  = var.db_name
  username = var.db_username
  password = var.db_password
  
  backup_retention_period = 7
  backup_window          = "03:00-04:00"
  maintenance_window     = "sun:04:00-sun:05:00"
  
  skip_final_snapshot = false
  final_snapshot_identifier = "${var.db_name}-final-snapshot-${formatdate("YYYY-MM-DD-hhmm", timestamp())}"
  
  lifecycle {
    # Prevent accidental deletion
    prevent_destroy = true
    
    # Ignore password changes (managed externally)
    ignore_changes = [password]
    
    # Always create new before destroying (for zero downtime)
    create_before_destroy = false  # Not recommended for databases
  }
  
  tags = {
    Name        = "main-database"
    Environment = var.environment
    Backup      = "enabled"
  }
}

# Auto Scaling Group with lifecycle management
resource "aws_launch_template" "app" {
  name_prefix   = "app-template-"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  
  vpc_security_group_ids = [aws_security_group.app.id]
  
  user_data = base64encode(templatefile("${path.module}/user_data.sh", {
    environment = var.environment
  }))
  
  lifecycle {
    create_before_destroy = true
  }
  
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name        = "app-instance"
      Environment = var.environment
    }
  }
}

resource "aws_autoscaling_group" "app" {
  name                = "app-asg"
  vpc_zone_identifier = aws_subnet.private[*].id
  target_group_arns   = [aws_lb_target_group.app.arn]
  health_check_type   = "ELB"
  
  min_size         = var.min_size
  max_size         = var.max_size
  desired_capacity = var.desired_capacity
  
  launch_template {
    id      = aws_launch_template.app.id
    version = "$Latest"
  }
  
  lifecycle {
    create_before_destroy = true
    ignore_changes       = [desired_capacity]  # Allow auto-scaling
  }
  
  tag {
    key                 = "Name"
    value               = "app-asg-instance"
    propagate_at_launch = true
  }
}
```

---

## 🔄 provider: Multi-Provider Configurations

The **`provider`** meta argument selects a specific provider configuration when you have multiple provider aliases.

### 🌍 Multi-Region AWS Setup

```hcl
# Provider configurations
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Default provider (us-west-2)
provider "aws" {
  region = "us-west-2"
  
  default_tags {
    tags = {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "terraform"
    }
  }
}

# East region provider
provider "aws" {
  alias  = "east"
  region = "us-east-1"
  
  default_tags {
    tags = {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "terraform"
      Region      = "us-east-1"
    }
  }
}

# Europe provider
provider "aws" {
  alias  = "europe"
  region = "eu-west-1"
  
  default_tags {
    tags = {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "terraform"
      Region      = "eu-west-1"
    }
  }
}

# Resources in default region (us-west-2)
resource "aws_s3_bucket" "main" {
  bucket = "${var.project_name}-main-${random_id.bucket_suffix.hex}"
}

# Resources in us-east-1 (required for CloudFront)
resource "aws_s3_bucket" "east" {
  provider = aws.east  # Use the east provider
  
  bucket = "${var.project_name}-east-${random_id.bucket_suffix.hex}"
}

# Resources in Europe
resource "aws_s3_bucket" "europe" {
  provider = aws.europe  # Use the europe provider
  
  bucket = "${var.project_name}-europe-${random_id.bucket_suffix.hex}"
}

# CloudFront distribution (must use us-east-1 for ACM certificate)
resource "aws_acm_certificate" "main" {
  provider = aws.east  # ACM certificates for CloudFront must be in us-east-1
  
  domain_name       = var.domain_name
  validation_method = "DNS"
  
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_cloudfront_distribution" "main" {
  # CloudFront is global but uses us-east-1 for certificates
  provider = aws.east
  
  origin {
    domain_name = aws_s3_bucket.main.bucket_regional_domain_name
    origin_id   = "S3-${aws_s3_bucket.main.bucket}"
    
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.main.cloudfront_access_identity_path
    }
  }
  
  enabled             = true
  default_root_object = "index.html"
  
  default_cache_behavior {
    allowed_methods        = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = "S3-${aws_s3_bucket.main.bucket}"
    compress              = true
    viewer_protocol_policy = "redirect-to-https"
    
    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }
  
  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate.main.arn
    ssl_support_method  = "sni-only"
  }
  
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
}
```

### 🏢 Multi-Account AWS Setup

```hcl
# Production account provider
provider "aws" {
  alias  = "prod"
  region = "us-west-2"
  
  assume_role {
    role_arn = "arn:aws:iam::${var.prod_account_id}:role/TerraformRole"
  }
  
  default_tags {
    tags = {
      Environment = "production"
      Account     = "prod"
    }
  }
}

# Development account provider
provider "aws" {
  alias  = "dev"
  region = "us-west-2"
  
  assume_role {
    role_arn = "arn:aws:iam::${var.dev_account_id}:role/TerraformRole"
  }
  
  default_tags {
    tags = {
      Environment = "development"
      Account     = "dev"
    }
  }
}

# Resources in production account
resource "aws_vpc" "prod" {
  provider = aws.prod
  
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  
  tags = {
    Name = "prod-vpc"
  }
}

# Resources in development account
resource "aws_vpc" "dev" {
  provider = aws.dev
  
  cidr_block           = "10.1.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  
  tags = {
    Name = "dev-vpc"
  }
}

# Cross-account VPC peering
resource "aws_vpc_peering_connection" "prod_to_dev" {
  provider = aws.prod
  
  vpc_id      = aws_vpc.prod.id
  peer_vpc_id = aws_vpc.dev.id
  peer_region = "us-west-2"
  
  tags = {
    Name = "prod-to-dev-peering"
  }
}

# Accept peering connection in dev account
resource "aws_vpc_peering_connection_accepter" "dev_accept" {
  provider = aws.dev
  
  vpc_peering_connection_id = aws_vpc_peering_connection.prod_to_dev.id
  auto_accept              = true
  
  tags = {
    Name = "dev-accept-peering"
  }
}
```

---

## 💻 **Exercise 8.1**: Complete Meta Arguments Implementation
**Duration**: 45 minutes

Let's build a comprehensive multi-tier application using all meta arguments.

**Step 1: Project Structure**
```bash
mkdir terraform-meta-arguments
cd terraform-meta-arguments

# Create file structure
touch {main,variables,outputs,providers}.tf
mkdir -p modules/{networking,compute,database}
```

**Step 2: Provider Configuration (`providers.tf`)**
```hcl
terraform {
  required_version = ">= 1.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.4"
    }
  }
}

# Primary region provider
provider "aws" {
  region = var.primary_region
  
  default_tags {
    tags = {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "terraform"
      Region      = var.primary_region
    }
  }
}

# Secondary region for disaster recovery
provider "aws" {
  alias  = "secondary"
  region = var.secondary_region
  
  default_tags {
    tags = {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "terraform"
      Region      = var.secondary_region
      Purpose     = "disaster-recovery"
    }
  }
}

# Random provider for unique naming
provider "random" {}
```

**Step 3: Variables (`variables.tf`)**
```hcl
variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "meta-args-demo"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
  
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be dev, staging, or prod."
  }
}

variable "primary_region" {
  description = "Primary AWS region"
  type        = string
  default     = "us-west-2"
}

variable "secondary_region" {
  description = "Secondary AWS region for DR"
  type        = string
  default     = "us-east-1"
}

variable "server_configurations" {
  description = "Server configurations for different tiers"
  type = map(object({
    instance_type = string
    min_size      = number
    max_size      = number
    desired_size  = number
    ports         = list(number)
  }))
  
  default = {
    web = {
      instance_type = "t3.small"
      min_size      = 2
      max_size      = 6
      desired_size  = 2
      ports         = [80, 443]
    }
    api = {
      instance_type = "t3.medium"
      min_size      = 2
      max_size      = 8
      desired_size  = 3
      ports         = [8080, 8443]
    }
    worker = {
      instance_type = "t3.large"
      min_size      = 1
      max_size      = 4
      desired_size  = 2
      ports         = []
    }
  }
}

variable "enable_disaster_recovery" {
  description = "Enable disaster recovery in secondary region"
  type        = bool
  default     = false
}
```

**Step 4: Main Configuration (`main.tf`)**
```hcl
# Random suffix for unique naming
resource "random_id" "suffix" {
  byte_length = 4
}

# Data sources
data "aws_availability_zones" "primary" {
  state = "available"
}

data "aws_availability_zones" "secondary" {
  provider = aws.secondary
  state    = "available"
}

data "aws_ami" "ubuntu" {
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

# Primary region networking
resource "aws_vpc" "primary" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  
  tags = {
    Name = "${var.project_name}-primary-vpc"
  }
}

# Internet Gateway with explicit dependency
resource "aws_internet_gateway" "primary" {
  vpc_id = aws_vpc.primary.id
  
  tags = {
    Name = "${var.project_name}-primary-igw"
  }
}

# Public subnets using for_each
locals {
  primary_azs = slice(data.aws_availability_zones.primary.names, 0, 3)
}

resource "aws_subnet" "public" {
  for_each = toset(local.primary_azs)
  
  vpc_id            = aws_vpc.primary.id
  availability_zone = each.key
  cidr_block        = "10.0.${index(local.primary_azs, each.key) + 1}.0/24"
  
  map_public_ip_on_launch = true
  
  tags = {
    Name = "${var.project_name}-public-${each.key}"
    Type = "public"
  }
}

# Private subnets using for_each
resource "aws_subnet" "private" {
  for_each = toset(local.primary_azs)
  
  vpc_id            = aws_vpc.primary.id
  availability_zone = each.key
  cidr_block        = "10.0.${index(local.primary_azs, each.key) + 10}.0/24"
  
  tags = {
    Name = "${var.project_name}-private-${each.key}"
    Type = "private"
  }
}

# Route table with explicit dependency
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.primary.id
  
  depends_on = [aws_internet_gateway.primary]
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.primary.id
  }
  
  tags = {
    Name = "${var.project_name}-public-rt"
  }
}

# Route table associations using for_each
resource "aws_route_table_association" "public" {
  for_each = aws_subnet.public
  
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

# NAT Gateways using for_each
resource "aws_eip" "nat" {
  for_each = aws_subnet.public
  
  domain = "vpc"
  
  depends_on = [aws_internet_gateway.primary]
  
  tags = {
    Name = "${var.project_name}-nat-eip-${each.key}"
  }
}

resource "aws_nat_gateway" "main" {
  for_each = aws_subnet.public
  
  allocation_id = aws_eip.nat[each.key].id
  subnet_id     = each.value.id
  
  depends_on = [aws_internet_gateway.primary]
  
  tags = {
    Name = "${var.project_name}-nat-${each.key}"
  }
}

# Private route tables using for_each
resource "aws_route_table" "private" {
  for_each = aws_subnet.private
  
  vpc_id = aws_vpc.primary.id
  
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main[each.key].id
  }
  
  tags = {
    Name = "${var.project_name}-private-rt-${each.key}"
  }
}

resource "aws_route_table_association" "private" {
  for_each = aws_subnet.private
  
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private[each.key].id
}

# Security groups using for_each
resource "aws_security_group" "app_tiers" {
  for_each = var.server_configurations
  
  name_prefix = "${each.key}-sg-"
  vpc_id      = aws_vpc.primary.id
  description = "Security group for ${each.key} tier"
  
  # Dynamic ingress rules
  dynamic "ingress" {
    for_each = each.value.ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = each.key == "web" ? ["0.0.0.0/0"] : [aws_vpc.primary.cidr_block]
    }
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = {
    Name = "${var.project_name}-${each.key}-sg"
    Tier = each.key
  }
  
  lifecycle {
    create_before_destroy = true
  }
}

# Launch templates using for_each
resource "aws_launch_template" "app_tiers" {
  for_each = var.server_configurations
  
  name_prefix   = "${each.key}-lt-"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = each.value.instance_type
  
  vpc_security_group_ids = [aws_security_group.app_tiers[each.key].id]
  
  user_data = base64encode(templatefile("${path.module}/user_data.sh", {
    tier        = each.key
    environment = var.environment
    ports       = jsonencode(each.value.ports)
  }))
  
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.project_name}-${each.key}-instance"
      Tier = each.key
    }
  }
  
  lifecycle {
    create_before_destroy = true
  }
}

# Auto Scaling Groups using for_each
resource "aws_autoscaling_group" "app_tiers" {
  for_each = var.server_configurations
  
  name                = "${var.project_name}-${each.key}-asg"
  vpc_zone_identifier = values(aws_subnet.private)[*].id
  
  min_size         = each.value.min_size
  max_size         = each.value.max_size
  desired_capacity = each.value.desired_size
  
  health_check_type         = "EC2"
  health_check_grace_period = 300
  
  launch_template {
    id      = aws_launch_template.app_tiers[each.key].id
    version = "$Latest"
  }
  
  # Explicit dependencies
  depends_on = [
    aws_nat_gateway.main,
    aws_route_table_association.private
  ]
  
  tag {
    key                 = "Name"
    value               = "${var.project_name}-${each.key}-asg-instance"
    propagate_at_launch = true
  }
  
  tag {
    key                 = "Tier"
    value               = each.key
    propagate_at_launch = true
  }
  
  lifecycle {
    create_before_destroy = true
    ignore_changes       = [desired_capacity]
  }
}

# Disaster Recovery in Secondary Region (conditional)
resource "aws_vpc" "secondary" {
  count = var.enable_disaster_recovery ? 1 : 0
  
  provider = aws.secondary
  
  cidr_block           = "10.1.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  
  tags = {
    Name    = "${var.project_name}-secondary-vpc"
    Purpose = "disaster-recovery"
  }
  
  lifecycle {
    prevent_destroy = false
  }
}

# Secondary region subnets (using count for simplicity in DR)
resource "aws_subnet" "secondary_public" {
  count = var.enable_disaster_recovery ? length(slice(data.aws_availability_zones.secondary.names, 0, 2)) : 0
  
  provider = aws.secondary
  
  vpc_id            = aws_vpc.secondary[0].id
  availability_zone = data.aws_availability_zones.secondary.names[count.index]
  cidr_block        = "10.1.${count.index + 1}.0/24"
  
  map_public_ip_on_launch = true
  
  tags = {
    Name    = "${var.project_name}-secondary-public-${count.index + 1}"
    Purpose = "disaster-recovery"
  }
}
```

**Step 5: Create User Data Script (`user_data.sh`)**
```bash
#!/bin/bash
# Update system
apt-get update
apt-get upgrade -y

# Install basic tools
apt-get install -y curl wget jq nginx

# Create application directory
mkdir -p /opt/app

# Create tier-specific configuration
cat > /opt/app/config.json << EOF
{
  "tier": "${tier}",
  "environment": "${environment}",
  "ports": ${ports},
  "instance_id": "$(curl -s http://169.254.169.254/latest/meta-data/instance-id)",
  "availability_zone": "$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone)",
  "local_ipv4": "$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)"
}
EOF

# Configure nginx with tier-specific page
cat > /var/www/html/index.html << EOF
<!DOCTYPE html>
<html>
<head>
    <title>${tier} Tier - ${environment}</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; }
        .tier-${tier} { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); }
        .info { background: #f0f8ff; padding: 20px; border-radius: 5px; margin: 10px 0; }
        .highlight { color: #7B42BC; font-weight: bold; }
    </style>
</head>
<body class="tier-${tier}">
    <h1>🔧 ${tier} Tier Server</h1>
    <div class="info">
        <h2>Server Information</h2>
        <p><strong>Tier:</strong> <span class="highlight">${tier}</span></p>
        <p><strong>Environment:</strong> <span class="highlight">${environment}</span></p>
        <p><strong>Instance ID:</strong> <span class="highlight">$(curl -s http://169.254.169.254/latest/meta-data/instance-id)</span></p>
        <p><strong>Availability Zone:</strong> <span class="highlight">$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone)</span></p>
    </div>
    <p>This server demonstrates Terraform meta arguments!</p>
</body>
</html>
EOF

# Start services
systemctl start nginx
systemctl enable nginx

# Log deployment
echo "$(date): ${tier} tier instance deployed in ${environment}" >> /var/log/terraform-deployment.log
```

**Step 6: Outputs (`outputs.tf`)**
```hcl
output "vpc_info" {
  description = "VPC information"
  value = {
    primary = {
      id         = aws_vpc.primary.id
      cidr_block = aws_vpc.primary.cidr_block
    }
    secondary = var.enable_disaster_recovery ? {
      id         = aws_vpc.secondary[0].id
      cidr_block = aws_vpc.secondary[0].cidr_block
    } : null
  }
}

output "subnet_info" {
  description = "Subnet information"
  value = {
    public = {
      for az, subnet in aws_subnet.public :
      az => {
        id         = subnet.id
        cidr_block = subnet.cidr_block
      }
    }
    private = {
      for az, subnet in aws_subnet.private :
      az => {
        id         = subnet.id
        cidr_block = subnet.cidr_block
      }
    }
  }
}

output "auto_scaling_groups" {
  description = "Auto Scaling Group information"
  value = {
    for tier, asg in aws_autoscaling_group.app_tiers :
    tier => {
      name         = asg.name
      min_size     = asg.min_size
      max_size     = asg.max_size
      desired_size = asg.desired_capacity
    }
  }
}

output "security_groups" {
  description = "Security group information"
  value = {
    for tier, sg in aws_security_group.app_tiers :
    tier => {
      id   = sg.id
      name = sg.name
    }
  }
}

output "nat_gateways" {
  description = "NAT Gateway information"
  value = {
    for az, nat in aws_nat_gateway.main :
    az => {
      id        = nat.id
      public_ip = aws_eip.nat[az].public_ip
    }
  }
}
```

**Step 7: Deploy and Test**
```bash
# Initialize
terraform init

# Plan with disaster recovery disabled
terraform plan

# Apply
terraform apply

# Test with disaster recovery enabled
terraform plan -var="enable_disaster_recovery=true"
terraform apply -var="enable_disaster_recovery=true"

# View outputs
terraform output

# Clean up
terraform destroy
```

**🔍 What This Exercise Demonstrates:**

1. **`depends_on`**: Explicit dependencies between networking components
2. **`count`**: Conditional disaster recovery resources
3. **`for_each`**: Dynamic subnet, security group, and ASG creation
4. **`provider`**: Multi-region deployment with aliases
5. **`lifecycle`**: Resource protection and creation strategies

💡 **Pro Tip**: Meta arguments are powerful tools for managing complex infrastructure patterns. Use them thoughtfully to create maintainable and scalable Terraform configurations!

---

## ✅ Module 8 Summary

**🎯 Learning Objectives Achieved:**
- ✅ Mastered **explicit dependencies** with `depends_on` for resource ordering
- ✅ Implemented **multiple resource creation** using `count` and `for_each`
- ✅ Configured **resource lifecycle management** with lifecycle blocks
- ✅ Established **multi-provider configurations** with aliases
- ✅ Built **complex infrastructure patterns** using all meta arguments

**🔑 Key Concepts Covered:**
- **Meta Arguments**: Special arguments available to all resource types
- **depends_on**: Explicit dependency management and ordering control
- **count**: Numeric indexing for multiple resource instances
- **for_each**: Key-value mapping for stable resource management
- **provider**: Multi-region and multi-account provider configurations
- **lifecycle**: Resource creation, update, and destruction control

**💼 Professional Skills Developed:**
- **Dependency Management**: Understanding implicit vs explicit dependencies
- **Resource Scaling**: Creating multiple resources efficiently
- **Multi-Cloud Strategy**: Managing resources across regions and accounts
- **Lifecycle Control**: Protecting critical resources and managing updates
- **Infrastructure Patterns**: Implementing enterprise-grade configurations

**🏗️ Technical Achievements:**
- Built multi-tier application with all meta arguments
- Implemented disaster recovery across multiple regions
- Created dynamic security groups and auto-scaling groups
- Established cross-account VPC peering connections
- Developed comprehensive infrastructure with lifecycle protection

**🔧 Advanced Patterns Mastered:**
- **Conditional Resources**: Using `count` for optional infrastructure
- **Dynamic Configuration**: Using `for_each` with complex data structures
- **Cross-Region Deployment**: Multi-provider configurations with aliases
- **Resource Protection**: Lifecycle rules for critical infrastructure
- **Dependency Orchestration**: Explicit ordering for complex deployments

**➡️ Next Steps**: Ready to explore **Expressions** where you'll learn about advanced Terraform language features including conditionals, loops, and dynamic blocks!

---

---

## 🔗 **Next Steps**

Ready to continue your Terraform journey? Proceed to the next module:

**➡️ [Module 28: Expressions](./module_10_expressions.md)**

Understand Terraform expressions, functions, and dynamic configurations.

---
