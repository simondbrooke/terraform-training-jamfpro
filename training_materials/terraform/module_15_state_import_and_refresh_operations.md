

# 📥 Module 15: Import and Refresh Operations

**⏱️ Duration**: 40 minutes  
**🎯 Difficulty**: Intermediate to Advanced  
**📋 Prerequisites**: Completed Modules 1-14

## 🎯 Learning Objectives

By the end of this module, you will be able to:

- ✅ **Import existing resources** into Terraform state using `terraform import`
- ✅ **Understand import workflows** and best practices for resource adoption
- ✅ **Master refresh operations** with `terraform apply -refresh-only`
- ✅ **Synchronize state** with real infrastructure effectively
- ✅ **Handle import limitations** and troubleshoot common issues
- ✅ **Implement bulk import strategies** for large-scale adoption
- ✅ **Design migration workflows** from manual to Terraform-managed infrastructure

---

## 📥 terraform import - Bringing Existing Resources Under Management

The `terraform import` command allows you to **bring existing infrastructure** under Terraform management by importing it into your Terraform state.

### 🎯 What is terraform import?

**terraform import** is used to import existing resources into your Terraform state file so that Terraform can manage them going forward. This is essential when:

- **🏗️ Adopting Terraform**: You have existing infrastructure created manually or by other tools
- **🔄 Migration Scenarios**: Moving from other IaC tools to Terraform
- **🚨 Recovery Situations**: Rebuilding state after corruption or loss
- **🔗 External Resources**: Incorporating resources created by other teams or processes

### 🔧 Basic Import Syntax

```bash
# Basic import syntax
terraform import [options] ADDRESS ID

# ADDRESS: Resource address in your configuration
# ID: Cloud provider's unique identifier for the resource
```

### 💻 Import Process Workflow

**Step 1: Create Resource Configuration**
```hcl
# Create empty resource block first
resource "aws_instance" "web" {
  # Leave empty initially - will fill after import
}
```

**Step 2: Import the Resource**
```bash
# Import using the resource's cloud provider ID
terraform import aws_instance.web i-1234567890abcdef0
```

**Step 3: Update Configuration**
```hcl
# Fill in configuration to match imported resource
resource "aws_instance" "web" {
  ami           = "ami-12345"
  instance_type = "t3.micro"
  subnet_id     = "subnet-12345"
  
  tags = {
    Name = "imported-web-server"
  }
}
```

**Step 4: Verify Import**
```bash
# Plan should show no changes if configuration matches
terraform plan
```

---

## 🔄 Import Examples by Resource Type

### 🖥️ AWS EC2 Instance Import

```bash
# Step 1: Find existing instance
aws ec2 describe-instances --query 'Reservations[*].Instances[*].[InstanceId,Tags[?Key==`Name`].Value|[0],InstanceType,State.Name]' --output table

# Step 2: Create resource block
cat > import.tf << EOF
resource "aws_instance" "existing_web" {
  # Configuration will be filled after import
}
EOF

# Step 3: Import the instance
terraform import aws_instance.existing_web i-1234567890abcdef0

# Step 4: Get current configuration
terraform show aws_instance.existing_web

# Step 5: Update configuration to match
cat > import.tf << EOF
resource "aws_instance" "existing_web" {
  ami                    = "ami-0abcdef1234567890"
  instance_type          = "t3.micro"
  availability_zone      = "us-west-2a"
  subnet_id              = "subnet-12345"
  vpc_security_group_ids = ["sg-12345"]
  
  tags = {
    Name = "existing-web-server"
  }
}
EOF

# Step 6: Verify
terraform plan  # Should show no changes
```

### 🔐 AWS Security Group Import

```bash
# Import security group
terraform import aws_security_group.web sg-1234567890abcdef0

# Configuration example
resource "aws_security_group" "web" {
  name        = "web-sg"
  description = "Security group for web servers"
  vpc_id      = "vpc-12345"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
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
    Name = "web-sg"
  }
}
```

### 🗄️ AWS S3 Bucket Import

```bash
# Import S3 bucket
terraform import aws_s3_bucket.data my-existing-bucket-name

# Configuration example
resource "aws_s3_bucket" "data" {
  bucket = "my-existing-bucket-name"
}

resource "aws_s3_bucket_versioning" "data" {
  bucket = aws_s3_bucket.data.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_encryption" "data" {
  bucket = aws_s3_bucket.data.id

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}
```

### 🌐 AWS VPC and Networking Import

```bash
# Import VPC
terraform import aws_vpc.main vpc-1234567890abcdef0

# Import subnets
terraform import aws_subnet.public subnet-1234567890abcdef0
terraform import aws_subnet.private subnet-0987654321fedcba0

# Import internet gateway
terraform import aws_internet_gateway.main igw-1234567890abcdef0

# Configuration example
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "main-vpc"
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-west-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet"
    Type = "public"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main-igw"
  }
}
```

---

## 🔄 Advanced Import Scenarios

### 📊 Importing Resources with Count/For_Each

```bash
# Import multiple instances with count
terraform import 'aws_instance.web[0]' i-1234567890abcdef0
terraform import 'aws_instance.web[1]' i-0987654321fedcba0

# Configuration with count
resource "aws_instance" "web" {
  count = 2
  
  ami           = "ami-12345"
  instance_type = "t3.micro"
  
  tags = {
    Name = "web-${count.index + 1}"
  }
}

# Import with for_each
terraform import 'aws_instance.servers["web"]' i-1234567890abcdef0
terraform import 'aws_instance.servers["api"]' i-0987654321fedcba0

# Configuration with for_each
resource "aws_instance" "servers" {
  for_each = {
    web = "t3.micro"
    api = "t3.small"
  }
  
  ami           = "ami-12345"
  instance_type = each.value
  
  tags = {
    Name = each.key
    Role = each.key
  }
}
```

### 🏗️ Module Resource Import

```bash
# Import resource within a module
terraform import module.networking.aws_vpc.main vpc-1234567890abcdef0
terraform import module.web.aws_instance.server i-1234567890abcdef0

# Import resource in nested module
terraform import module.app.module.database.aws_db_instance.main myapp-prod-db
```

### 🔍 Import with State File Targeting

```bash
# Import to specific state file
terraform import -state=production.tfstate aws_instance.web i-1234567890abcdef0

# Import with backend configuration
terraform import -backend-config="bucket=my-state-bucket" aws_instance.web i-1234567890abcdef0
```

---

## ⚠️ Import Limitations and Considerations

### 🚫 What Import Cannot Do

**❌ Automatic Configuration Generation:**
- Import does NOT generate configuration automatically
- You must manually create and maintain resource blocks
- Configuration must match the imported resource exactly

**❌ Resource Dependencies:**
- Import does not automatically import related resources
- You must import dependencies separately
- Relationships must be established manually in configuration

**❌ Resource-Specific Limitations:**
```bash
# Some resources cannot be imported
terraform import aws_autoscaling_attachment.example  # ❌ Not supported
terraform import aws_route.example                   # ❌ Complex import process

# Check provider documentation for import support
# Look for "Import" section in resource docs
```

### ⚠️ Import Best Practices

**🔍 Pre-Import Investigation:**
```bash
# Investigate existing resources before import
aws ec2 describe-instances --instance-ids i-1234567890abcdef0
aws s3api get-bucket-location --bucket my-bucket
aws iam get-role --role-name my-role

# Document resource relationships
aws ec2 describe-instances --instance-ids i-1234567890abcdef0 \
  --query 'Reservations[*].Instances[*].[InstanceId,SubnetId,SecurityGroups[*].GroupId]'
```

**📝 Configuration Matching:**
```bash
# Import resource first
terraform import aws_instance.web i-1234567890abcdef0

# Use terraform show to see current state
terraform show aws_instance.web > current_config.txt

# Create configuration matching the output
# Focus on required and significant optional attributes
```

**🔄 Iterative Import Process:**
```bash
# Import core resources first
terraform import aws_vpc.main vpc-12345
terraform import aws_subnet.public subnet-12345

# Then import dependent resources
terraform import aws_security_group.web sg-12345
terraform import aws_instance.web i-12345

# Verify after each import
terraform plan
```

---

## 🔄 terraform apply -refresh-only - State Synchronization

The `terraform apply -refresh-only` command synchronizes your Terraform state with the actual infrastructure without making any changes.

### 🎯 What is Refresh-Only Mode?

**Refresh-only mode** updates your state file to reflect the current reality of your infrastructure without applying any configuration changes.

**🔍 Key Differences:**
- **`terraform plan -refresh-only`**: Shows what would change in state (preview)
- **`terraform apply -refresh-only`**: Actually updates the state file (execution)

### 🔧 Refresh-Only Usage

```bash
# Preview state changes
terraform plan -refresh-only

# Apply state changes
terraform apply -refresh-only

# Refresh with auto-approval
terraform apply -refresh-only -auto-approve

# Refresh specific resources
terraform apply -refresh-only -target=aws_instance.web
```

### 📊 Refresh-Only Scenarios

**Scenario 1: Resource Deleted Externally**
```bash
# Someone deleted an instance via AWS console
terraform plan -refresh-only

# Output:
Note: Objects have changed outside of Terraform

  # aws_instance.web has been deleted
  - resource "aws_instance" "web" {
      - ami           = "ami-12345" -> null
      - instance_type = "t3.micro" -> null
      - id            = "i-1234567890abcdef0" -> null
      # ... other attributes
    }

# Apply refresh to update state
terraform apply -refresh-only

# Now state reflects that resource is gone
terraform plan  # Will show it wants to recreate the instance
```

**Scenario 2: Resource Modified Externally**
```bash
# Someone changed instance type via console
terraform plan -refresh-only

# Output:
Note: Objects have changed outside of Terraform

  ~ resource "aws_instance" "web" {
        id            = "i-1234567890abcdef0"
      ~ instance_type = "t3.micro" -> "t3.small"
        # ... other attributes
    }

# Apply refresh to update state
terraform apply -refresh-only

# Now you can decide: revert change or update configuration
terraform plan  # Will show it wants to change back to t3.micro
```

**Scenario 3: Tags Added Externally**
```bash
# Someone added tags via console
terraform plan -refresh-only

# Output shows new tags in state
terraform apply -refresh-only

# Update configuration to include the new tags
resource "aws_instance" "web" {
  ami           = "ami-12345"
  instance_type = "t3.micro"
  
  tags = {
    Name        = "web-server"
    Environment = "production"  # Added externally
    Owner       = "team-alpha"  # Added externally
  }
}

terraform plan  # Should show no changes
```

---

## 🔄 Refresh vs Import Decision Matrix

| Scenario | Use Import | Use Refresh-Only |
|----------|------------|------------------|
| **New resource created outside Terraform** | ✅ Import the resource | ❌ Cannot refresh non-managed resources |
| **Managed resource deleted outside Terraform** | ❌ Resource no longer exists | ✅ Refresh to sync state |
| **Managed resource modified outside Terraform** | ❌ Already in state | ✅ Refresh to see changes |
| **Want to adopt existing infrastructure** | ✅ Import all resources | ❌ Refresh won't add to management |
| **State file lost or corrupted** | ✅ Re-import all resources | ❌ No state to refresh |
| **Migrating from other IaC tools** | ✅ Import resources | ❌ Resources not in Terraform state |

---

## 💻 **Exercise 15.1**: Import and Refresh Workflow
**Duration**: 30 minutes

Let's practice importing existing resources and using refresh operations in realistic scenarios.

**Step 1: Create Existing Infrastructure (Simulate External Creation)**
```bash
mkdir terraform-import-demo
cd terraform-import-demo

# Create resources manually via AWS CLI (simulating existing infrastructure)
```

Create `create-existing.sh`:
```bash
#!/bin/bash
set -e

echo "🏗️ Creating existing infrastructure to import..."

# Create VPC
VPC_ID=$(aws ec2 create-vpc --cidr-block 10.0.0.0/16 --query 'Vpc.VpcId' --output text)
aws ec2 create-tags --resources $VPC_ID --tags Key=Name,Value=import-demo-vpc

# Enable DNS support
aws ec2 modify-vpc-attribute --vpc-id $VPC_ID --enable-dns-support
aws ec2 modify-vpc-attribute --vpc-id $VPC_ID --enable-dns-hostnames

# Create Internet Gateway
IGW_ID=$(aws ec2 create-internet-gateway --query 'InternetGateway.InternetGatewayId' --output text)
aws ec2 attach-internet-gateway --vpc-id $VPC_ID --internet-gateway-id $IGW_ID
aws ec2 create-tags --resources $IGW_ID --tags Key=Name,Value=import-demo-igw

# Create subnet
SUBNET_ID=$(aws ec2 create-subnet --vpc-id $VPC_ID --cidr-block 10.0.1.0/24 --query 'Subnet.SubnetId' --output text)
aws ec2 create-tags --resources $SUBNET_ID --tags Key=Name,Value=import-demo-subnet

# Create security group
SG_ID=$(aws ec2 create-security-group --group-name import-demo-sg --description "Import demo security group" --vpc-id $VPC_ID --query 'GroupId' --output text)

# Add security group rules
aws ec2 authorize-security-group-ingress --group-id $SG_ID --protocol tcp --port 80 --cidr 0.0.0.0/0
aws ec2 authorize-security-group-ingress --group-id $SG_ID --protocol tcp --port 443 --cidr 0.0.0.0/0

# Get latest Ubuntu AMI
AMI_ID=$(aws ec2 describe-images --owners 099720109477 --filters "Name=name,Values=ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*" --query 'Images | sort_by(@, &CreationDate) | [-1].ImageId' --output text)

# Create EC2 instance
INSTANCE_ID=$(aws ec2 run-instances --image-id $AMI_ID --count 1 --instance-type t2.micro --subnet-id $SUBNET_ID --security-group-ids $SG_ID --associate-public-ip-address --query 'Instances[0].InstanceId' --output text)
aws ec2 create-tags --resources $INSTANCE_ID --tags Key=Name,Value=import-demo-web

# Create S3 bucket
BUCKET_NAME="import-demo-$(date +%s)-$(openssl rand -hex 4)"
aws s3 mb s3://$BUCKET_NAME
aws s3api put-bucket-tagging --bucket $BUCKET_NAME --tagging 'TagSet=[{Key=Name,Value=import-demo-bucket},{Key=Purpose,Value=demo}]'

# Output resource IDs for import
echo ""
echo "📋 Resources created for import:"
echo "VPC ID: $VPC_ID"
echo "IGW ID: $IGW_ID"
echo "Subnet ID: $SUBNET_ID"
echo "Security Group ID: $SG_ID"
echo "Instance ID: $INSTANCE_ID"
echo "Bucket Name: $BUCKET_NAME"

# Save to file for later use
cat > resource_ids.txt << EOF
VPC_ID=$VPC_ID
IGW_ID=$IGW_ID
SUBNET_ID=$SUBNET_ID
SG_ID=$SG_ID
INSTANCE_ID=$INSTANCE_ID
BUCKET_NAME=$BUCKET_NAME
AMI_ID=$AMI_ID
EOF

echo "✅ Infrastructure created successfully!"
echo "💾 Resource IDs saved to resource_ids.txt"
```

```bash
chmod +x create-existing.sh
./create-existing.sh
```

**Step 2: Initialize Terraform Project**
```bash
# Create Terraform configuration
cat > main.tf << EOF
terraform {
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

# We'll add resource blocks as we import
EOF

terraform init
```

**Step 3: Import VPC and Networking**
```bash
# Load resource IDs
source resource_ids.txt

# Add VPC resource block
cat >> main.tf << EOF

resource "aws_vpc" "main" {
  # Will be filled after import
}
EOF

# Import VPC
terraform import aws_vpc.main $VPC_ID

# Check what was imported
terraform show aws_vpc.main

# Update configuration to match
cat > vpc.tf << EOF
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  
  tags = {
    Name = "import-demo-vpc"
  }
}
EOF

# Verify import
terraform plan -target=aws_vpc.main
```

**Step 4: Import Internet Gateway**
```bash
# Add IGW resource block
cat >> vpc.tf << EOF

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  
  tags = {
    Name = "import-demo-igw"
  }
}
EOF

# Import IGW
terraform import aws_internet_gateway.main $IGW_ID

# Verify
terraform plan -target=aws_internet_gateway.main
```

**Step 5: Import Subnet**
```bash
# Add subnet resource block
cat >> vpc.tf << EOF

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = false
  
  tags = {
    Name = "import-demo-subnet"
  }
}
EOF

# Import subnet
terraform import aws_subnet.public $SUBNET_ID

# Check configuration match
terraform plan -target=aws_subnet.public

# Fix any discrepancies (e.g., availability_zone)
terraform show aws_subnet.public | grep availability_zone
```

**Step 6: Import Security Group**
```bash
# Add security group resource block
cat >> security.tf << EOF
resource "aws_security_group" "web" {
  name        = "import-demo-sg"
  description = "Import demo security group"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
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
    Name = "import-demo-sg"
  }
}
EOF

# Import security group
terraform import aws_security_group.web $SG_ID

# Verify
terraform plan -target=aws_security_group.web
```

**Step 7: Import EC2 Instance**
```bash
# Add instance resource block
cat >> instances.tf << EOF
resource "aws_instance" "web" {
  ami                    = "$AMI_ID"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.web.id]
  
  associate_public_ip_address = true
  
  tags = {
    Name = "import-demo-web"
  }
}
EOF

# Import instance
terraform import aws_instance.web $INSTANCE_ID

# Check for configuration mismatches
terraform plan -target=aws_instance.web

# Fix any issues (common: availability_zone, security_groups vs vpc_security_group_ids)
```

**Step 8: Import S3 Bucket**
```bash
# Add S3 bucket resources
cat >> storage.tf << EOF
resource "aws_s3_bucket" "demo" {
  bucket = "$BUCKET_NAME"
}

resource "aws_s3_bucket_tagging" "demo" {
  bucket = aws_s3_bucket.demo.id

  tag_set = {
    Name    = "import-demo-bucket"
    Purpose = "demo"
  }
}
EOF

# Import S3 bucket
terraform import aws_s3_bucket.demo $BUCKET_NAME
terraform import aws_s3_bucket_tagging.demo $BUCKET_NAME

# Verify
terraform plan
```

**Step 9: Practice Refresh Operations**
```bash
# Make manual change to test refresh
aws ec2 create-tags --resources $INSTANCE_ID --tags Key=Environment,Value=imported

# Detect change with refresh-only
terraform plan -refresh-only

# Apply refresh to update state
terraform apply -refresh-only

# Update configuration to match
sed -i '/tags = {/a\    Environment = "imported"' instances.tf

# Verify no changes needed
terraform plan
```

**Step 10: Test Complete Infrastructure**
```bash
# Run full plan to verify everything is imported correctly
terraform plan

# If plan shows no changes, import was successful!
echo "✅ All resources successfully imported!"

# Test infrastructure management
terraform plan -target=aws_instance.web
```

**Step 11: Cleanup**
```bash
# Clean up imported infrastructure
terraform destroy

# Verify cleanup
aws ec2 describe-vpcs --filters "Name=tag:Name,Values=import-demo-vpc" --query 'Vpcs[*].VpcId'
```

💡 **Pro Tip**: Always import resources incrementally and verify each step before proceeding to the next resource!

---

## ✅ Module 15 Summary

**🎯 Learning Objectives Achieved:**
- ✅ Mastered **resource import** using `terraform import` with various resource types
- ✅ Understood **import workflows** and best practices for adopting existing infrastructure
- ✅ Implemented **refresh operations** with `terraform apply -refresh-only` for state synchronization
- ✅ Learned to **synchronize state** effectively with real infrastructure changes
- ✅ Handled **import limitations** and troubleshot common import issues
- ✅ Practiced **bulk import strategies** for complex infrastructure adoption
- ✅ Designed **migration workflows** for transitioning to Terraform management

**🔑 Key Concepts Covered:**
- **Import Process**: Resource identification, configuration creation, import execution, verification
- **Import Scenarios**: Single resources, count/for_each resources, module resources
- **Refresh Operations**: State synchronization, external change detection, state updates
- **Import Limitations**: Configuration requirements, dependency management, unsupported resources
- **Best Practices**: Incremental import, configuration matching, verification procedures

**💼 Professional Skills Developed:**
- **Infrastructure Adoption**: Systematic approach to bringing existing resources under management
- **State Synchronization**: Maintaining accurate state representation of infrastructure
- **Migration Planning**: Strategies for transitioning from manual to automated infrastructure
- **Troubleshooting**: Resolving import conflicts and configuration mismatches
- **Workflow Design**: Efficient processes for large-scale infrastructure adoption

**🌟 Advanced Techniques Mastered:**
- **Complex Resource Import**: Handling networking, security, and compute resources
- **Bulk Import Operations**: Strategies for importing multiple related resources
- **State Refresh Workflows**: Maintaining state accuracy with external changes
- **Configuration Matching**: Ensuring imported resources match Terraform expectations
- **Migration Automation**: Scripts and processes for systematic infrastructure adoption

**➡️ Next Steps**: Ready to master **Terraform Troubleshooting and Debugging** where you'll learn to diagnose and resolve any Terraform issues like a pro!

---

---

## 🔗 **Next Steps**

Ready to continue your Terraform journey? Proceed to the next module:

**➡️ [Module 16: Terraform Troubleshooting and Debugging](./module_16_terraform_troubleshooting_and_debugging.md)**

Debug and troubleshoot common Terraform issues.

---
