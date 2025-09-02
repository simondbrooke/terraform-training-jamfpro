
## ⚡ Module 04: Terraform Basics
*Duration: 3 hours | Labs: 4* | Difficulty: 🟡 Intermediate*

### 🎯 Learning Objectives
By the end of this module, you will be able to:
- ✅ Understand the complete Terraform lifecycle and workflow
- ✅ Master the core Terraform commands (init, plan, apply, destroy)
- ✅ Explain change automation and execution planning
- ✅ Visualize execution plans and understand resource graphs
- ✅ Identify Terraform use cases and best practices
- ✅ Work with input variables, local values, and outputs
- ✅ Understand Terraform modules and file organization
- ✅ Use Terraform Cloud for remote operations

### 📚 Topics Covered

#### 🔄 The Terraform Lifecycle

The Terraform lifecycle represents the complete process of managing infrastructure from creation to destruction. Understanding this lifecycle is crucial for effective infrastructure management.

**🔑 Lifecycle Phases:**

1. **📝 Write**: Create `.tf` configuration files
2. **📋 Plan**: Preview changes with `terraform plan`
3. **⚡ Apply**: Execute changes with `terraform apply`
4. **🔧 Manage**: Monitor and maintain infrastructure
5. **🔄 Update**: Modify configuration and repeat cycle
6. **💥 Destroy**: Clean up resources with `terraform destroy`

#### ⚡ Change Automation

Terraform's change automation ensures that infrastructure changes are:
- **🎯 Predictable**: Same configuration = same result
- **📋 Planned**: Preview changes before applying
- **🔄 Repeatable**: Consistent across environments
- **📊 Tracked**: State file maintains current status

**Traditional vs Terraform Change Management:**

| Traditional | Terraform |
|-------------|-----------|
| Manual changes | Automated changes |
| Inconsistent results | Consistent results |
| No change preview | Plan before apply |
| Hard to rollback | Easy rollback |
| Documentation separate | Self-documenting |

#### 📋 Execution Plans

Execution plans are Terraform's way of showing you exactly what will happen before making any changes.

**🔍 Plan Output Symbols:**
- **`+`** = Resource will be **created**
- **`-`** = Resource will be **destroyed**  
- **`~`** = Resource will be **modified**
- **`-/+`** = Resource will be **replaced** (destroyed then created)

**Example Plan Output:**
```bash
Terraform will perform the following actions:

  # aws_instance.web will be created
  + resource "aws_instance" "web" {
      + ami           = "ami-12345"
      + instance_type = "t2.micro"
      + tags          = {
          + "Name" = "WebServer"
        }
    }

  # aws_security_group.web will be modified
  ~ resource "aws_security_group" "web" {
        id     = "sg-12345"
        name   = "web-sg"
      ~ ingress {
          + from_port = 443
          + to_port   = 443
            protocol  = "tcp"
        }
    }

Plan: 1 to add, 1 to change, 0 to destroy.
```

💡 **Pro Tip**: Always run `terraform plan` before `terraform apply` to avoid surprises!

#### 📊 Visualizing Execution Plans

**🗺️ Terraform Graph**
Terraform builds a **dependency graph** from your configuration and uses it to determine the correct order for resource operations. You can visualize this graph using `terraform graph`.

**📝 Basic Usage:**
```bash
# Generate dependency graph
terraform graph

# Create visual graph (requires GraphViz installed)
terraform graph | dot -Tsvg > graph.svg

# or with png output

terraform graph | dot -Tpng > graph.png

# Open in browser
open graph.svg  # macOS
xdg-open graph.svg  # Linux
```

**🔧 Installing GraphViz:**
```bash
# macOS
brew install graphviz

# Ubuntu/Debian
sudo apt install graphviz

# CentOS/RHEL
sudo yum install graphviz
```

**🎯 What the Graph Shows:**
- **Resource dependencies**: Which resources depend on others
- **Parallel execution**: Resources that can be created simultaneously
- **Execution order**: The sequence Terraform will follow
- **Data source relationships**: How data flows between resources

**📈 Dependency Graph Example:**
```hcl
# This configuration creates dependencies
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.main.id  # Depends on VPC
  cidr_block = "10.0.1.0/24"
}

resource "aws_instance" "web" {
  subnet_id = aws_subnet.public.id  # Depends on subnet
  ami       = "ami-12345"
  instance_type = "t2.micro"
}
```

The graph shows: **VPC → Subnet → Instance** dependency chain.

💡 **Pro Tip**: Use `terraform graph` to understand complex resource relationships and optimize your configuration for parallel execution!

#### 🔄 Resource Replacement with --replace Flag

**🚨 Replacing terraform taint**
The `terraform taint` command was deprecated in Terraform v0.15.2. The modern approach uses the `--replace` flag with `terraform plan` and `terraform apply`.

**🎯 When to Use --replace:**
- **💥 Resource corruption**: When a resource becomes damaged or degraded
- **🔧 Configuration changes**: When certain changes require resource recreation
- **🧪 Testing scenarios**: When you need to force resource recreation for testing
- **📦 Image updates**: When updating AMIs, container images, or similar immutable resources

**📝 Basic Usage:**
```bash
# Plan resource replacement
terraform plan -replace="aws_instance.web"

# Apply resource replacement
terraform apply -replace="aws_instance.web"

# Replace multiple resources (one at a time)
terraform apply -replace="aws_instance.web[0]" -replace="aws_instance.web[1]"
```

**🔍 Replacement vs Update:**
```hcl
# This resource configuration
resource "aws_instance" "web" {
  ami           = "ami-12345"      # Old AMI
  instance_type = "t2.micro"
  
  tags = {
    Name = "WebServer"
  }
}
```

**Example Scenarios:**
```bash
# Scenario 1: Force recreation due to corruption
terraform apply -replace="aws_instance.web"

# Scenario 2: Replace specific instance in a count/for_each
terraform apply -replace="aws_instance.web[0]"
terraform apply -replace='aws_instance.servers["web"]'

# Scenario 3: Combine with other changes
terraform apply -replace="aws_instance.web" -var="instance_type=t3.micro"
```

**🚨 Important Limitations:**
- **One resource at a time**: Can only replace single resources, not multiple in one flag
- **Destructive operation**: Resource will be destroyed and recreated
- **Dependency aware**: Terraform will handle dependent resource updates automatically
- **State consistency**: Replacement maintains state file consistency

**💡 Modern Best Practices:**
```bash
# ✅ Modern approach
terraform plan -replace="aws_instance.web"

# ❌ Deprecated approach (don't use)
terraform taint aws_instance.web
terraform plan
```

💡 **Pro Tip**: Always run `terraform plan -replace` first to review the replacement impact before applying!

### 💻 **Exercise 3.1**: Core Terraform Workflow
**Duration**: 30 minutes

Let's practice the complete Terraform workflow with a real cloud resource.

**Step 1: Setup Project Structure**
```bash
# Create new project directory
mkdir ~/terraform-aws-basics
cd ~/terraform-aws-basics

# Open in VS Code
code .
```

**Step 2: Create Main Configuration**

Create `main.tf`:
```hcl
# Configure the AWS Provider
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
  region = var.aws_region
}

# Create a VPC
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  
  tags = {
    Name        = "terraform-basics-vpc"
    Environment = "learning"
  }
}

# Create an Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  
  tags = {
    Name = "terraform-basics-igw"
  }
}

# Create a subnet
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true
  
  tags = {
    Name = "terraform-basics-public-subnet"
  }
}

# Data source to get available AZs
data "aws_availability_zones" "available" {
  state = "available"
}
```

**Step 3: Create Variables File**

Create `variables.tf`:
```hcl
variable "aws_region" {
  description = "AWS region for resources"
  type        = string
  default     = "us-west-2"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "learning"
}
```

**Step 4: Create Outputs File**

Create `outputs.tf`:
```hcl
output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "vpc_cidr_block" {
  description = "CIDR block of the VPC"
  value       = aws_vpc.main.cidr_block
}

output "subnet_id" {
  description = "ID of the public subnet"
  value       = aws_subnet.public.id
}

output "availability_zone" {
  description = "Availability zone of the subnet"
  value       = aws_subnet.public.availability_zone
}
```

**Step 5: Initialize Terraform**
```bash
# Initialize the working directory
terraform init

# Verify initialization
ls -la
# You should see .terraform/ directory and .terraform.lock.hcl file
```

**Step 6: Validate Configuration**
```bash
# Check syntax and configuration
terraform validate

# Format code (optional but recommended)
terraform fmt
```

**Step 7: Plan the Infrastructure**
```bash
# Create execution plan
terraform plan

# Save plan to file for review
terraform plan -out=tfplan

# Review the saved plan
terraform show tfplan
```

**Step 8: Apply the Configuration**
```bash
# Apply the changes (will prompt for confirmation)
terraform apply

# Or apply with auto-approval (be careful!)
terraform apply -auto-approve
```

**Step 9: Explore the State**
```bash
# View current state
terraform show

# List all resources in state
terraform state list

# Show specific resource details
terraform state show aws_vpc.main
```

**Step 10: Clean Up**
```bash
# Destroy all resources
terraform destroy

# Verify resources are gone
terraform show
```

💡 **Pro Tip**: Notice how Terraform tracks dependencies and creates resources in the correct order!

#### 🎯 Use Cases for Terraform

**🏢 Enterprise Use Cases:**
- **☁️ Multi-cloud deployments**: Consistent infrastructure across providers
- **🔄 Environment provisioning**: Dev, staging, production environments
- **📦 Application infrastructure**: Complete application stacks
- **🛡️ Compliance automation**: Standardized, auditable infrastructure
- **💾 Disaster recovery**: Rapid infrastructure recreation

**🔧 Common Patterns:**
```hcl
# 1. Network Foundation
resource "aws_vpc" "main" { /* ... */ }
resource "aws_subnet" "private" { /* ... */ }
resource "aws_subnet" "public" { /* ... */ }

# 2. Security Groups
resource "aws_security_group" "web" { /* ... */ }
resource "aws_security_group" "database" { /* ... */ }

# 3. Compute Resources
resource "aws_instance" "web" { /* ... */ }
resource "aws_rds_instance" "database" { /* ... */ }

# 4. Load Balancing
resource "aws_lb" "main" { /* ... */ }
resource "aws_lb_target_group" "web" { /* ... */ }
```

---

## ✅ Module 3 Summary

### 🎯 Key Takeaways
- **🔄 Terraform lifecycle** follows a predictable Write → Plan → Apply → Manage cycle
- **📋 Execution plans** show exactly what will change before applying
- **🗺️ Resource graphs** ensure proper dependency resolution and parallel execution
- **📊 Variables** make configurations flexible and reusable across environments
- **🏷️ Local values** compute derived values and reduce repetition
- **📤 Outputs** extract information from infrastructure for use by other systems
- **📥 Data sources** query existing infrastructure and cloud provider APIs

### 🔑 Essential Commands Learned
```bash
terraform init          # Initialize working directory
terraform validate      # Check configuration syntax
terraform fmt          # Format configuration files
terraform plan         # Preview changes
terraform apply        # Apply changes
terraform destroy      # Remove all resources
terraform output       # Display output values
terraform show         # Display current state
terraform state list   # List resources in state
terraform state show   # Show specific resource details
```

### 💡 Pro Tips Recap
- Always run `terraform plan` before `terraform apply`
- Use variables to make configurations reusable
- Leverage local values for computed and derived values
- Use data sources to reference existing infrastructure
- Tag all resources consistently for better organization
- Keep sensitive outputs marked as sensitive
- Use validation rules to catch errors early

---

## 🧠 Knowledge Check: Module 3 Quiz

Test your understanding of Terraform Basics with these questions:

### 📝 Quiz Questions

**1. What is the correct order of the core Terraform workflow?**
- A) Plan → Write → Apply → Destroy
- B) Write → Plan → Apply → Manage  
- C) Init → Write → Plan → Apply
- D) Apply → Plan → Write → Validate

**2. Which symbol in a Terraform plan output indicates a resource will be replaced?**
- A) `+`
- B) `~` 
- C) `-/+`
- D) `-`

**3. What command would you use to visualize Terraform's dependency graph?**
- A) `terraform show`
- B) `terraform graph`
- C) `terraform state list`
- D) `terraform validate`

**4. Which type of Terraform value is computed at apply time and cannot be used in resource count?**
- A) Input variables
- B) Local values
- C) Output values
- D) Data source attributes

**5. What is the modern replacement for the deprecated `terraform taint` command?**
- A) `terraform destroy --target`
- B) `terraform apply --replace`
- C) `terraform refresh --replace`
- D) `terraform state rm`

**6. Which block type is used to query existing infrastructure?**
- A) `resource`
- B) `variable`
- C) `data`
- D) `output`

**7. What makes Terraform operations idempotent?**
- A) HCL syntax validation
- B) Provider version constraints
- C) State file tracking of current infrastructure
- D) Execution plan generation

**8. Which validation constraint ensures a variable contains a valid email address?**
- A) `validation { condition = length(var.email) > 0 }`
- B) `validation { condition = can(regex(".*@.*", var.email)) }`
- C) `validation { condition = var.email != "" }`
- D) `validation { condition = contains(var.email, "@") }`

<details>
<summary>🔍 Click for Answers</summary>

1. **B** - The core Terraform workflow follows Write → Plan → Apply → Manage cycle
2. **C** - The `-/+` symbol indicates a resource will be replaced (destroyed then created)
3. **B** - `terraform graph` generates a visual representation of resource dependencies
4. **D** - Data source attributes are computed at apply time and cannot be used in resource count
5. **B** - `terraform apply --replace` is the modern replacement for deprecated `terraform taint`
6. **C** - `data` blocks are used to query existing infrastructure and cloud provider APIs
7. **C** - State file tracking makes Terraform idempotent by knowing current infrastructure state
8. **B** - Using `can(regex(".*@.*", var.email))` provides basic email format validation

</details>

---

**🎉 Congratulations!** You've completed Module 3 and now understand the core Terraform workflow, variables, outputs, and data sources. You've built real AWS infrastructure and learned to make it flexible and maintainable!

**➡️ Ready for Module 4?** Let me know when you'd like to continue with Terraform Provisioners - where we'll learn how to configure resources after they're created!

---

---

## 🔗 **Next Steps**

Ready to continue your Terraform journey? Proceed to the next module:

**➡️ [Module 5: Configuration Management and Provisioners](./module_05_configuration_management_and_provisioners.md)**

Learn advanced configuration management techniques and provisioner usage.

---
