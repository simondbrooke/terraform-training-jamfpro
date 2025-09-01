

# 📦 Module 17: Finding and Using Terraform Modules

**⏱️ Duration**: 35 minutes  
**🎯 Difficulty**: Intermediate  
**📋 Prerequisites**: Completed Modules 1-16

## 🎯 Learning Objectives

By the end of this module, you will be able to:

- ✅ **Navigate the Terraform Registry** effectively to find quality modules
- ✅ **Distinguish between verified and unverified modules** and make informed choices
- ✅ **Use public modules** from the Terraform Registry with proper versioning
- ✅ **Integrate private modules** from Terraform Cloud and Enterprise
- ✅ **Configure module authentication** using terraform login and API tokens
- ✅ **Apply module versioning strategies** for stable and predictable deployments
- ✅ **Design module consumption patterns** for team collaboration and reusability

---

## 🌐 Understanding Terraform Modules

**Terraform modules** are containers for multiple resources that are used together. They provide a way to **package and reuse** Terraform configurations, making infrastructure management more efficient and consistent.

### 🎯 **What Are Modules?**

```hcl
# Every Terraform configuration is technically a module
# Your main.tf is actually a "root module"

# Using a module looks like this:
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"
  
  name = "my-vpc"
  cidr = "10.0.0.0/16"
  
  azs             = ["us-west-2a", "us-west-2b", "us-west-2c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  
  enable_nat_gateway = true
  enable_vpn_gateway = true
  
  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}
```

### 🔍 **Module Benefits**

**🚀 Reusability:**
- Write once, use many times
- Consistent infrastructure patterns
- Reduced code duplication

**🛡️ Abstraction:**
- Hide complex implementation details
- Provide simple interfaces
- Reduce configuration errors

**🏢 Standardization:**
- Enforce organizational standards
- Consistent naming and tagging
- Compliance and security patterns

**⚡ Speed:**
- Faster development cycles
- Pre-tested configurations
- Community best practices

---

## 🏪 Terraform Registry - Your Module Marketplace

The **Terraform Registry** is the central repository for sharing Terraform modules, providers, and policies.

### 🌐 **Registry Overview**

**Registry URL**: `https://registry.terraform.io/`

**Key Features:**
- **Browse modules** by provider and use case
- **Search functionality** with filters and categories
- **Version history** and documentation
- **Usage examples** and README files
- **Download statistics** and popularity metrics

### 🔍 **Finding Modules in the Registry**

**Navigation Structure:**
```
Registry Home
├── Providers (AWS, Azure, GCP, etc.)
├── Modules
│   ├── Browse by Provider
│   ├── Search by Keyword
│   └── Filter by Verification Status
└── Policies (Sentinel policies)
```

**Search Strategies:**
```bash
# Search examples:
# - "aws vpc" → Find VPC modules for AWS
# - "azure compute" → Find compute modules for Azure
# - "kubernetes ingress" → Find ingress modules for Kubernetes
# - "database mysql" → Find MySQL database modules
```

### 🎯 **Module Categories**

**Infrastructure Modules:**
- **Networking**: VPC, subnets, security groups, load balancers
- **Compute**: EC2, Auto Scaling, ECS, EKS
- **Storage**: S3, EBS, EFS, databases
- **Security**: IAM, KMS, secrets management

**Application Modules:**
- **Web Applications**: WordPress, LAMP stack, microservices
- **Databases**: MySQL, PostgreSQL, MongoDB, Redis
- **Monitoring**: CloudWatch, Prometheus, Grafana
- **CI/CD**: Jenkins, GitLab, GitHub Actions

**Utility Modules:**
- **Networking**: DNS, CDN, API Gateway
- **Security**: Certificate management, backup solutions
- **Operations**: Logging, monitoring, alerting

---

## ✅ Verified vs Unverified Modules

Understanding the difference between verified and unverified modules is crucial for making informed decisions.

### 🏅 **Verified Modules**

**Definition**: Modules reviewed by HashiCorp and actively maintained by official contributors.

**Identification:**
```
✅ Verified badge displayed prominently
🏢 Published by HashiCorp Partners
📊 Higher visibility in search results
```

**Characteristics:**
- **Quality Assurance**: Reviewed by HashiCorp team
- **Active Maintenance**: Regular updates and bug fixes
- **Compatibility**: Tested with latest Terraform versions
- **Documentation**: Comprehensive examples and documentation
- **Support**: Backed by HashiCorp partners

**Example Verified Modules:**
```hcl
# AWS VPC Module (Verified)
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"
  # ... configuration
}

# Azure Network Module (Verified)
module "network" {
  source = "Azure/network/azurerm"
  version = "~> 5.0"
  # ... configuration
}

# Google Cloud VPC Module (Verified)
module "vpc" {
  source = "terraform-google-modules/network/google"
  version = "~> 7.0"
  # ... configuration
}
```

### 🔧 **Unverified Modules**

**Definition**: Community-contributed modules that haven't gone through HashiCorp's verification process.

**Important Notes:**
- **Not indicative of quality**: Many unverified modules are high-quality
- **Community maintained**: May have excellent support and documentation
- **Innovation source**: Often contain cutting-edge features
- **Variety**: Wider selection of specialized use cases

**Evaluation Criteria for Unverified Modules:**
```bash
# Check these factors:
✅ Recent commits and activity
✅ GitHub stars and forks
✅ Issue response time
✅ Documentation quality
✅ Example configurations
✅ Test coverage
✅ Version history
```

### 🎯 **Module Selection Decision Matrix**

| Factor | Verified Modules | Unverified Modules |
|--------|------------------|-------------------|
| **Quality Assurance** | ✅ HashiCorp reviewed | ⚠️ Community reviewed |
| **Maintenance** | ✅ Partner backed | ⚠️ Varies by maintainer |
| **Documentation** | ✅ Comprehensive | ⚠️ Varies by author |
| **Support** | ✅ Professional support | ⚠️ Community support |
| **Innovation** | ⚠️ Conservative | ✅ Cutting edge |
| **Variety** | ⚠️ Limited selection | ✅ Extensive options |
| **Search Visibility** | ✅ Prioritized | ⚠️ Standard listing |

**💡 Pro Tip**: Start with verified modules for critical infrastructure, explore unverified modules for specialized needs!

---

## 💻 **Exercise 17.1**: Building Infrastructure with Registry Modules
**Duration**: 25 minutes

Practice finding, evaluating, and using Terraform Registry modules to build a complete web application infrastructure.

**Step 1: Project Setup**
```bash
mkdir terraform-modules-lab
cd terraform-modules-lab

# Initialize project structure
cat > main.tf << EOF
# Terraform Registry Modules Lab
terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}
EOF

cat > variables.tf << EOF
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "modules-lab"
}

variable "project_name" {
  description = "Project name for resource naming"
  type        = string
  default     = "webapp"
}
EOF
```

**Step 2: Registry Module Research**
```bash
# Create research documentation
cat > module-research.md << EOF
# Module Research for Web Application Infrastructure

## Required Components:
1. **VPC and Networking** - Secure network foundation
2. **Security Groups** - Network access control
3. **Load Balancer** - Application load balancing
4. **Auto Scaling Group** - Scalable compute instances
5. **RDS Database** - Managed database service
6. **S3 Storage** - Object storage for assets

## Module Evaluation Criteria:
- ✅ Verified badge (preferred)
- ✅ Recent updates (< 6 months)
- ✅ Good documentation
- ✅ High download count
- ✅ Positive community feedback

## Selected Modules:
1. **VPC**: terraform-aws-modules/vpc/aws (Verified ✅)
2. **Security Group**: terraform-aws-modules/security-group/aws (Verified ✅)
3. **ALB**: terraform-aws-modules/alb/aws (Verified ✅)
4. **Auto Scaling**: terraform-aws-modules/autoscaling/aws (Verified ✅)
5. **RDS**: terraform-aws-modules/rds/aws (Verified ✅)
6. **S3**: terraform-aws-modules/s3-bucket/aws (Verified ✅)
EOF

echo "📋 Module research completed! Check module-research.md"
```

**Step 3: Implement VPC Foundation**
```bash
# Add VPC module to main.tf
cat >> main.tf << EOF

# Random suffix for unique resource naming
resource "random_id" "suffix" {
  byte_length = 4
}

locals {
  name_prefix = "\${var.project_name}-\${var.environment}"
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
    CreatedBy   = "modules-lab"
  }
}

# VPC Module - Foundation networking
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "\${local.name_prefix}-vpc"
  cidr = "10.0.0.0/16"

  azs              = ["\${var.aws_region}a", "\${var.aws_region}b", "\${var.aws_region}c"]
  private_subnets  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets   = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  database_subnets = ["10.0.201.0/24", "10.0.202.0/24", "10.0.203.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = false
  enable_dns_hostnames = true
  enable_dns_support = true

  # Database subnet group
  create_database_subnet_group = true
  create_database_subnet_route_table = true

  tags = local.common_tags
}
EOF

terraform init
terraform plan
echo "✅ VPC module configured successfully!"
```

**Step 4: Add Security Groups**
```bash
# Add security group modules
cat >> main.tf << EOF

# Web Security Group - Allow HTTP/HTTPS from ALB
module "web_security_group" {
  source = "terraform-aws-modules/security-group/aws"
  version = "~> 5.0"

  name        = "\${local.name_prefix}-web-sg"
  description = "Security group for web servers"
  vpc_id      = module.vpc.vpc_id

  # Allow inbound from ALB security group
  computed_ingress_with_source_security_group_id = [
    {
      rule                     = "http-80-tcp"
      source_security_group_id = module.alb_security_group.security_group_id
    },
    {
      rule                     = "https-443-tcp"
      source_security_group_id = module.alb_security_group.security_group_id
    }
  ]
  number_of_computed_ingress_with_source_security_group_id = 2

  egress_rules = ["all-all"]

  tags = local.common_tags
}

# ALB Security Group - Allow HTTP/HTTPS from internet
module "alb_security_group" {
  source = "terraform-aws-modules/security-group/aws"
  version = "~> 5.0"

  name        = "\${local.name_prefix}-alb-sg"
  description = "Security group for application load balancer"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp", "https-443-tcp"]
  egress_rules        = ["all-all"]

  tags = local.common_tags
}

# Database Security Group - Allow MySQL from web servers
module "database_security_group" {
  source = "terraform-aws-modules/security-group/aws"
  version = "~> 5.0"

  name        = "\${local.name_prefix}-db-sg"
  description = "Security group for RDS database"
  vpc_id      = module.vpc.vpc_id

  computed_ingress_with_source_security_group_id = [
    {
      rule                     = "mysql-tcp"
      source_security_group_id = module.web_security_group.security_group_id
    }
  ]
  number_of_computed_ingress_with_source_security_group_id = 1

  tags = local.common_tags
}
EOF

echo "✅ Security groups configured!"
```

**Step 5: Add Application Load Balancer**
```bash
# Add ALB module
cat >> main.tf << EOF

# Application Load Balancer
module "alb" {
  source = "terraform-aws-modules/alb/aws"
  version = "~> 8.0"

  name = "\${local.name_prefix}-alb"

  load_balancer_type = "application"

  vpc_id          = module.vpc.vpc_id
  subnets         = module.vpc.public_subnets
  security_groups = [module.alb_security_group.security_group_id]

  target_groups = [
    {
      name_prefix      = "web-"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
      
      health_check = {
        enabled             = true
        healthy_threshold   = 2
        interval            = 30
        matcher             = "200"
        path                = "/"
        port                = "traffic-port"
        protocol            = "HTTP"
        timeout             = 5
        unhealthy_threshold = 2
      }
    }
  ]

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]

  tags = local.common_tags
}
EOF

echo "✅ Application Load Balancer configured!"
```

**Step 6: Add RDS Database**
```bash
# Add RDS module
cat >> main.tf << EOF

# RDS Database
module "rds" {
  source = "terraform-aws-modules/rds/aws"
  version = "~> 6.0"

  identifier = "\${local.name_prefix}-db-\${random_id.suffix.hex}"

  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = "db.t3.micro"
  allocated_storage = 20

  db_name  = "webapp"
  username = "admin"
  password = "changeme123!"  # In production, use AWS Secrets Manager

  vpc_security_group_ids = [module.database_security_group.security_group_id]
  db_subnet_group_name   = module.vpc.database_subnet_group

  backup_retention_period = 1
  backup_window          = "03:00-04:00"
  maintenance_window     = "sun:04:00-sun:05:00"

  skip_final_snapshot = true
  deletion_protection = false

  tags = local.common_tags
}
EOF

echo "✅ RDS database configured!"
```

**Step 7: Add S3 Storage**
```bash
# Add S3 module
cat >> main.tf << EOF

# S3 Bucket for static assets
module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 3.0"

  bucket = "\${local.name_prefix}-assets-\${random_id.suffix.hex}"

  # Bucket policies
  attach_policy = true
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "arn:aws:s3:::\${local.name_prefix}-assets-\${random_id.suffix.hex}/*"
      }
    ]
  })

  # Bucket configuration
  control_object_ownership = true
  object_ownership         = "BucketOwnerPreferred"

  public_access_block = {
    block_public_acls       = false
    block_public_policy     = false
    ignore_public_acls      = false
    restrict_public_buckets = false
  }

  versioning = {
    enabled = true
  }

  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = local.common_tags
}
EOF

echo "✅ S3 storage configured!"
```

**Step 8: Add Outputs and Test**
```bash
# Create outputs.tf
cat > outputs.tf << EOF
# Infrastructure Outputs

output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "public_subnets" {
  description = "Public subnet IDs"
  value       = module.vpc.public_subnets
}

output "private_subnets" {
  description = "Private subnet IDs"
  value       = module.vpc.private_subnets
}

output "database_subnets" {
  description = "Database subnet IDs"
  value       = module.vpc.database_subnets
}

output "alb_dns_name" {
  description = "Application Load Balancer DNS name"
  value       = module.alb.lb_dns_name
}

output "alb_target_group_arn" {
  description = "ALB target group ARN"
  value       = module.alb.target_group_arns[0]
}

output "database_endpoint" {
  description = "RDS instance endpoint"
  value       = module.rds.db_instance_endpoint
  sensitive   = true
}

output "s3_bucket_name" {
  description = "S3 bucket name"
  value       = module.s3_bucket.s3_bucket_id
}

output "s3_bucket_website_endpoint" {
  description = "S3 bucket website endpoint"
  value       = module.s3_bucket.s3_bucket_website_endpoint
}
EOF

# Test the complete configuration
terraform plan
echo "✅ Complete infrastructure plan generated!"
```

**Step 9: Module Dependency Analysis**
```bash
# Create dependency visualization
cat > analyze-modules.sh << EOF
#!/bin/bash
echo "🔍 Module Dependency Analysis"
echo "============================"

echo ""
echo "📊 Module Sources:"
grep -h "source.*=" main.tf | sort | uniq

echo ""
echo "📋 Module Versions:"
grep -h "version.*=" main.tf | sort | uniq

echo ""
echo "🔗 Module Dependencies:"
echo "1. VPC (Foundation) → All other modules depend on VPC"
echo "2. Security Groups → Depend on VPC"
echo "3. ALB → Depends on VPC and ALB Security Group"
echo "4. RDS → Depends on VPC and Database Security Group"
echo "5. S3 → Independent (no dependencies)"

echo ""
echo "✅ Analysis complete!"
EOF

chmod +x analyze-modules.sh
./analyze-modules.sh
```

**Step 10: Best Practices Review**
```bash
# Create best practices checklist
cat > module-best-practices.md << EOF
# Module Usage Best Practices Review

## ✅ What We Did Right:
1. **Used Verified Modules**: All modules have HashiCorp verification
2. **Version Constraints**: Used ~> constraints for stable updates
3. **Consistent Naming**: Applied consistent naming patterns
4. **Common Tags**: Used local values for consistent tagging
5. **Security**: Implemented proper security group relationships
6. **Documentation**: Created clear variable descriptions

## 🔧 Areas for Improvement:
1. **Secrets Management**: Use AWS Secrets Manager for database passwords
2. **Environment Separation**: Use workspaces or separate state files
3. **Module Pinning**: Consider exact versions for production
4. **Monitoring**: Add CloudWatch and monitoring modules
5. **Backup Strategy**: Implement comprehensive backup modules

## 📋 Module Evaluation Checklist:
- ✅ Verified badge present
- ✅ Recent updates (< 6 months)
- ✅ Good documentation
- ✅ High download count
- ✅ Active community support
- ✅ Semantic versioning
- ✅ Example configurations

## 🎯 Next Steps:
1. Test with \`terraform apply\` in development environment
2. Add monitoring and alerting modules
3. Implement CI/CD pipeline for module updates
4. Create custom modules for organization-specific patterns
EOF

echo "📋 Best practices review completed!"
```

💡 **Pro Tip**: Always research modules thoroughly before use - check documentation, examples, and community feedback!

---

## ✅ Module 17 Summary

**🎯 Learning Objectives Achieved:**
- ✅ **Mastered Terraform Registry navigation** and effective module discovery
- ✅ **Distinguished verified from unverified modules** with clear evaluation criteria
- ✅ **Implemented public modules** with proper versioning and configuration
- ✅ **Understood private module integration** for organizational use
- ✅ **Configured module authentication** for secure access
- ✅ **Applied versioning strategies** for stable deployments
- ✅ **Designed consumption patterns** for team collaboration

**🔑 Key Concepts Covered:**
- **Module Fundamentals**: Understanding modules as reusable infrastructure components
- **Registry Navigation**: Effective searching, filtering, and module evaluation
- **Verification System**: HashiCorp's quality assurance and partner ecosystem
- **Version Management**: Semantic versioning, constraints, and update strategies
- **Authentication**: Terraform Cloud login and private repository access
- **Integration Patterns**: Module composition and dependency management

**💼 Professional Skills Developed:**
- **Module Evaluation**: Systematic assessment of module quality and suitability
- **Infrastructure Design**: Using modules to build scalable, maintainable architectures
- **Version Management**: Balancing stability with feature updates
- **Security Practices**: Proper authentication and access control for private modules
- **Team Collaboration**: Shared module usage patterns and standards

**🌟 Advanced Techniques Mastered:**
- **Module Composition**: Building complex infrastructure from multiple modules
- **Dependency Management**: Understanding and managing inter-module relationships
- **Source Variety**: Registry, Git, and local module sources
- **Authentication Methods**: Multiple approaches for private module access
- **Quality Assessment**: Comprehensive evaluation criteria for module selection

**🎯 Production-Ready Skills:**
- **Enterprise Module Usage**: Patterns suitable for large-scale deployments
- **Quality Assurance**: Systematic module evaluation and testing
- **Security Implementation**: Proper authentication and access patterns
- **Maintenance Planning**: Version management and update strategies
- **Team Standards**: Collaborative module usage and governance

**➡️ Next Steps**: Ready to dive into **Module Structure and Development** where you'll learn to create your own well-structured, reusable Terraform modules!

---