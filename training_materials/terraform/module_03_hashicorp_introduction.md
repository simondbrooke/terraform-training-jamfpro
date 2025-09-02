
# 🔷 Module 03: HashiCorp Introduction
*Duration: 1 hour | Labs: 1* | Difficulty: 🟢 Beginner*

### 🎯 Learning Objectives
By the end of this module, you will be able to:
- ✅ Understand HashiCorp's role in the DevOps ecosystem
- ✅ Explain what Terraform is and its core purpose
- ✅ Distinguish between Terraform OSS and Terraform Cloud/Enterprise
- ✅ Identify Terraform's position in HashiCorp's product suite
- ✅ Understand Terraform's architecture and core components
- ✅ Explain Terraform's multi-cloud capabilities

### 📚 Topics Covered

#### 🏢 HashiCorp Company Overview

HashiCorp is a company focused on **infrastructure automation** and **security**. Founded in 2012, they've built a suite of tools that work together to solve modern infrastructure challenges.

**🔑 HashiCorp's Mission**: 
> *"To enable organizations to provision, secure, and run any infrastructure for any application"*

#### 🛠️ HashiCorp Product Suite

| Product | Purpose | Category | Open Source |
|---------|---------|----------|-------------|
| **🔷 Terraform** | Infrastructure provisioning | Infrastructure | ✅ Yes |
| **🔒 Vault** | Secrets management | Security | ✅ Yes |
| **🌐 Consul** | Service discovery & mesh | Networking | ✅ Yes |
| **🚀 Nomad** | Workload orchestration | Runtime | ✅ Yes |
| **📦 Packer** | Image building | Infrastructure | ✅ Yes |
| **🛡️ Boundary** | Secure remote access | Security | ✅ Yes |
| **🚢 Waypoint** | Application deployment | Application | ✅ Yes |

💡 **Pro Tip**: All HashiCorp tools follow similar principles - they're declarative, use HCL (HashiCorp Configuration Language), and integrate seamlessly!

---

#### 🔷 What is Terraform?

**Terraform** is an **Infrastructure as Code (IaC)** tool that allows you to **build, change, and version infrastructure** safely and efficiently.

**🎯 Core Purpose:**
- **Provision** infrastructure resources across multiple providers
- **Manage** the complete lifecycle of infrastructure
- **Version control** infrastructure changes
- **Collaborate** on infrastructure development

**🔑 Key Characteristics:**

- **☁️ Cloud Agnostic**: Works with AWS, Azure, GCP, and 5000+ providers
- **📋 Declarative**: You describe what you want, not how to get it
- **🔄 Idempotent**: Same configuration = same result every time
- **📊 State Management**: Tracks what resources exist and their configuration
- **🗺️ Execution Planning**: Shows what will change before making changes

#### 🔄 Terraform vs Traditional Infrastructure Management

**❌ Traditional Approach:**
```bash
# Manual AWS Console clicks or CLI commands
aws ec2 run-instances --image-id ami-12345 --instance-type t2.micro
aws ec2 create-security-group --group-name web-sg
aws ec2 authorize-security-group-ingress --group-name web-sg --protocol tcp --port 80
# ... many more commands
# No easy way to track what was created or replicate it
```

**✅ Terraform Approach:**
```hcl
# Single configuration file describes entire infrastructure
resource "aws_instance" "web" {
  ami           = "ami-12345"
  instance_type = "t2.micro"
  
  vpc_security_group_ids = [aws_security_group.web.id]
  
  tags = {
    Name = "WebServer"
  }
}

resource "aws_security_group" "web" {
  name = "web-sg"
  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
```

#### ☁️ Terraform Deployment Options

**🆓 Terraform Open Source (OSS)**
- Free to use
- Run locally or in CI/CD with runners like GitHub Actions or GitLab CI
- Manual state management
- Individual or small team usage

**☁️ Terraform Cloud**
- SaaS offering by HashiCorp
- Remote state management
- Team collaboration features
- Policy enforcement
- Private module registry

**🏢 Terraform Enterprise**
- Self-hosted version of Terraform Cloud
- Enterprise security and compliance
- Air-gapped environments
- Advanced governance features

#### 🌍 Multi-Cloud Capabilities

**🎯 Why Multi-Cloud Matters:**
- **🛡️ Avoid vendor lock-in**: Don't put all eggs in one basket
- **🌐 Geographic distribution**: Use best regions from different providers
- **💰 Cost optimization**: Leverage competitive pricing
- **🔄 Disaster recovery**: Failover between providers
- **🎯 Best-of-breed**: Use each provider's strongest services

**Example Multi-Cloud Setup:**
```hcl
# AWS Provider for compute
provider "aws" {
  region = "us-west-2"
}

# Azure Provider for databases  
provider "azurerm" {
  features {}
}

# Google Cloud for ML services
provider "google" {
  project = "my-project"
  region  = "us-central1"
}

# Create resources across all three clouds
resource "aws_instance" "web" {
  ami           = "ami-12345"
  instance_type = "t2.micro"
}

resource "azurerm_mysql_server" "database" {
  name                = "mydb-server"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  # ... configuration
}

resource "google_ml_engine_model" "ml_model" {
  name = "my_ml_model"
  # ... configuration
}
```

### 💻 **Exercise 2.1**: Terraform Installation Verification
**Duration**: 15 minutes

Let's verify your Terraform installation and explore basic commands.

**Step 1: Verify Installation**
```bash
# Open VS Code terminal (Ctrl+` or Cmd+`)
terraform version

# Expected output:
# Terraform v1.12.2
# on darwin_arm6 (or your platform)
```

**Step 2: Explore Help System**
```bash
# Get general help
terraform --help

# Get help for specific commands
terraform plan --help
terraform apply --help
terraform destroy --help
```

**Step 3: Create Your First Terraform Directory**
```bash
# Create project directory
mkdir ~/terraform-learning
cd ~/terraform-learning

# Open in VS Code
code .
```

**Step 4: Create a Simple Configuration**

Create a file called `main.tf` in VS Code:
```hcl
# This is a comment in HCL
terraform {
  required_version = ">= 1.0"
  
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5.3"
    }
  }
}

# Create a local file - no cloud provider needed!
resource "local_file" "hello" {
  filename = "hello.txt"
  content  = "Hello from Terraform! 🚀"
}

# Output the file content
output "file_content" {
  value = local_file.hello.content
}
```

**Step 5: Initialize and Apply**

Within your vs code terminal, run the following commands:

```bash
# Initialize Terraform (downloads providers)
terraform init
```

```bash
Initializing the backend...
Initializing provider plugins...
- Finding hashicorp/local versions matching "~> 2.5.3"...
- Installing hashicorp/local v2.5.3...
- Installed hashicorp/local v2.5.3 (signed by HashiCorp)
Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

<span style="color:green">**Terraform has been successfully initialized!**</span>

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

```bash
# Plan the changes
terraform plan

# Apply the changes
terraform apply
# Type 'yes' when prompted

# Verify the file was created
ls -la
cat hello.txt
```

**Step 6: Explore State**
```bash
# View current state
terraform show

# List resources in state
terraform state list
```

**Step 7: Clean Up**
```bash
# Destroy resources
terraform destroy
# Type 'yes' when prompted

# Verify file was deleted
ls -la
```

💡 **Pro Tip**: Notice how Terraform tracks what it created in the state file and can cleanly remove it!

---

## ✅ Module 2 Summary

### 🎯 Key Takeaways
- **🏢 HashiCorp** builds integrated tools for infrastructure automation
- **🔷 Terraform** is the infrastructure provisioning tool in their suite
- **☁️ Multi-cloud support** prevents vendor lock-in and enables best-of-breed approaches
- **📊 State management** is what makes Terraform powerful and reliable
- **🔌 Provider system** enables Terraform to work with any API
- **📋 HCL syntax** is human-readable and version-control friendly

### 🔑 Essential Commands Learned
```bash
terraform version        # Check Terraform version
terraform init          # Initialize working directory
terraform plan          # Preview changes
terraform apply         # Apply changes
terraform destroy       # Remove resources
terraform show          # Display current state
terraform state list    # List managed resources
```

### 💡 Pro Tips Recap
- Start simple with local resources before moving to cloud providers
- Always run `terraform plan` before `terraform apply`
- State files contain sensitive information - protect them!
- Use version constraints for providers to ensure consistency

---

**🎉 Congratulations!** You've completed Module 2 and now understand HashiCorp's ecosystem and Terraform's role within it. You've also created your first Terraform configuration!

---

## 🔗 **Next Steps**

Ready to continue your Terraform journey? Proceed to the next module:

**➡️ [Module 4: Terraform Basics](./module_04_terraform_basics.md)**

Dive deep into the core Terraform workflow and commands - where you'll master the essential operations for managing infrastructure.

---
