# 🔷 Module 04: HashiCorp Introduction

## _Duration: 1 hour | Labs: 1_ | Difficulty: 🟢 Beginner\*

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

> _"To enable organizations to provision, secure, and run any infrastructure for any application"_

#### 🛠️ HashiCorp Product Suite

| Product          | Purpose                     | Category       | Open Source |
| ---------------- | --------------------------- | -------------- | ----------- |
| **🔷 Terraform** | Infrastructure provisioning | Infrastructure | ✅ Yes      |
| **🔒 Vault**     | Secrets management          | Security       | ✅ Yes      |
| **🌐 Consul**    | Service discovery & mesh    | Networking     | ✅ Yes      |
| **🚀 Nomad**     | Workload orchestration      | Runtime        | ✅ Yes      |
| **📦 Packer**    | Image building              | Infrastructure | ✅ Yes      |
| **🛡️ Boundary**  | Secure remote access        | Security       | ✅ Yes      |
| **🚢 Waypoint**  | Application deployment      | Application    | ✅ Yes      |

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

Within your VS Code terminal, run the following commands:

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

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

Now perform your first terraform plan

```bash
# Plan the changes
terraform plan
```

**expected output**

```bash
Terraform used the selected providers to generate the following execution plan. Resource actions are
indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # local_file.hello will be created
  + resource "local_file" "hello" {
      + content              = "Hello from Terraform! 🚀"
      + content_base64sha256 = (known after apply)
      + content_base64sha512 = (known after apply)
      + content_md5          = (known after apply)
      + content_sha1         = (known after apply)
      + content_sha256       = (known after apply)
      + content_sha512       = (known after apply)
      + directory_permission = "0777"
      + file_permission      = "0777"
      + filename             = "hello.txt"
      + id                   = (known after apply)
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + file_content = "Hello from Terraform! 🚀"
```

```bash
# Apply the changes
terraform apply
# Type 'yes' when prompted
```

**expected output**

```bash
local_file.hello: Creating...
local_file.hello: Creation complete after 0s [id=3d3a4083913dfdd5890d12ef12a42e55c6e49235]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

Outputs:

file_content = "Hello from Terraform! 🚀"
```

```bash
# Verify the file was created
ls -la
cat hello.txt
```

**Step 6: Explore State**

```bash
# View current state
terraform show
```

**expected output**

```bash
# local_file.hello:
resource "local_file" "hello" {
    content              = "Hello from Terraform! 🚀"
    content_base64sha256 = "+on+nbr8KDyrfOYumpDGky9eF4uICt6hVdyQXNGO4/0="
    content_base64sha512 = "DD3oVIM29KZ3qo7ONRmhdfzgoYi1v8GxCSPiuo9FVgHyWYebb+IqRZIC+ul0E9FMWkjWeFgEdauBL5CLDzeylA=="
    content_md5          = "bee53481d330a69eaec861f8a3277ef0"
    content_sha1         = "3d3a4083913dfdd5890d12ef12a42e55c6e49235"
    content_sha256       = "fa89fe9dbafc283cab7ce62e9a90c6932f5e178b880adea155dc905cd18ee3fd"
    content_sha512       = "0c3de8548336f4a677aa8ece3519a175fce0a188b5bfc1b10923e2ba8f455601f259879b6fe22a459202fae97413d14c5a48d678580475ab812f908b0f37b294"
    directory_permission = "0777"
    file_permission      = "0777"
    filename             = "hello.txt"
    id                   = "3d3a4083913dfdd5890d12ef12a42e55c6e49235"
}


Outputs:

file_content = "Hello from Terraform! 🚀"
```

```bash
# List resources in state
terraform state list
```

**expected output**

```bash
local_file.hello
```

**Step 7: Clean Up**

```bash
# Destroy resources
terraform destroy
```

**expected output**

```bash
Changes to Outputs:
  - file_content = "Hello from Terraform! 🚀" -> null

Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value:
```

Type 'yes' when prompted

```bash
local_file.hello: Destroying... [id=3d3a4083913dfdd5890d12ef12a42e55c6e49235]
local_file.hello: Destruction complete after 0s

Destroy complete! Resources: 1 destroyed.
```

```bash
# Verify file was deleted
ls -la
```

💡 **Pro Tip**: Notice how Terraform tracks what it created in the state file and can cleanly remove it!

---

## ✅ Module 3 Summary

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

**🎉 Congratulations!** You've completed Module 3 and now understand HashiCorp's ecosystem and Terraform's role within it. You've also created your first Terraform configuration!

---

## 🔗 **Next Steps**

Ready to continue your Terraform journey? Proceed to the next module:

**➡️ [Module 5: Terraform Basics](./module_05-00_terraform_basics.md)**

Start to learn the basics of Terraform and the HCL language.

---
