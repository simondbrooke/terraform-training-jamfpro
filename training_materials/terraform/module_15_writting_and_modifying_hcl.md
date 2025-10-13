# ✍️ Module 15: Writing and Modifying HCL

**⏱️ Duration**: 35 minutes  
**🎯 Difficulty**: Beginner to Intermediate  
**📋 Prerequisites**: Completed Modules 1-11

## 🎯 Learning Objectives

By the end of this module, you will be able to:

- ✅ **Format code consistently** with `terraform fmt`
- ✅ **Validate configurations** using `terraform validate`
- ✅ **Debug interactively** with `terraform console`
- ✅ **Implement code quality practices** for Terraform projects
- ✅ **Integrate formatting and validation** into CI/CD workflows
- ✅ **Troubleshoot configuration issues** effectively

---

## 🎨 terraform fmt - Code Formatting

The `terraform fmt` command **automatically formats** Terraform configuration files to a **canonical format** and **style**.

### 🔧 Basic terraform fmt Usage

```bash
# Format all .tf files in current directory
terraform fmt

# Format specific file
terraform fmt main.tf

# Format files recursively in subdirectories
terraform fmt -recursive

# Check if files need formatting (exit code 0 = no changes needed)
terraform fmt -check

# Show diff of what would be changed
terraform fmt -diff

# Write changes to stdout instead of files
terraform fmt -write=false main.tf
```

### 📋 What terraform fmt Does

**🎯 Indentation and Spacing:**

- Standardizes indentation (2 spaces)
- Removes trailing whitespace
- Ensures consistent spacing around operators
- Aligns resource arguments properly

**🔤 Formatting Rules:**

- Sorts argument assignments alphabetically within blocks
- Normalizes string quotation (removes unnecessary quotes)
- Formats multi-line strings consistently
- Standardizes comment formatting

### 💻 Before and After Examples

**Before formatting:**

```hcl
resource "aws_instance"   "web" {
ami= "ami-12345"
  instance_type ="t3.micro"
    availability_zone=   "us-west-2a"
vpc_security_group_ids=["sg-12345"]

  tags={
Name="web-server"
    Environment = "production"
  Owner="team@company.com"
  }
}

variable "instance_count" {
type=number
default=1
description   ="Number of instances to create"

  validation{
condition=var.instance_count > 0 && var.instance_count <= 10
error_message="Instance count must be between 1 and 10."
}
}
```

**After `terraform fmt`:**

```hcl
resource "aws_instance" "web" {
  ami                    = "ami-12345"
  availability_zone      = "us-west-2a"
  instance_type          = "t3.micro"
  vpc_security_group_ids = ["sg-12345"]

  tags = {
    Environment = "production"
    Name        = "web-server"
    Owner       = "team@company.com"
  }
}

variable "instance_count" {
  type        = number
  default     = 1
  description = "Number of instances to create"

  validation {
    condition     = var.instance_count > 0 && var.instance_count <= 10
    error_message = "Instance count must be between 1 and 10."
  }
}
```

### 🔄 Advanced terraform fmt Options

```bash
# Check formatting in CI/CD pipeline
terraform fmt -check -recursive
echo $?  # Exit code: 0 = properly formatted, 3 = needs formatting

# Show what would change without modifying files
terraform fmt -diff -check

# Format specific file types only
find . -name "*.tf" -exec terraform fmt {} \;

# Format and show results
terraform fmt -diff -write=true

# Integration with VS Code (automatic on save)
# Add to VS Code settings.json:
{
  "terraform.format.enable": true,
  "editor.formatOnSave": true
}
```

---

## ✅ terraform validate - Configuration Validation

The `terraform validate` command **validates the syntax** and **internal consistency** of Terraform configuration files.

### 🔧 Basic terraform validate Usage

```bash
# Validate current directory configuration
terraform validate

# Validate with JSON output
terraform validate -json

# Validate without requiring terraform init
terraform validate -no-color
```

### 📋 What terraform validate Checks

**✅ Syntax Validation:**

- HCL syntax correctness
- Block structure validity
- Argument name spelling
- Proper quotation and brackets

**🔍 Semantic Validation:**

- Resource type existence
- Required argument presence
- Argument type correctness
- Reference validity (local scope only)

**⚠️ What validate Does NOT Check:**

- Provider availability (requires `terraform init`)
- Resource existence in real infrastructure
- Cross-resource dependencies outside current configuration
- Provider-specific argument validation

### 💻 Validation Examples

**Valid Configuration:**

```hcl
terraform {
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

variable "aws_region" {
  type        = string
  description = "AWS region"
  default     = "us-west-2"

  validation {
    condition     = can(regex("^[a-z]{2}-[a-z]+-[0-9]$", var.aws_region))
    error_message = "AWS region must be in the format xx-xxxx-x."
  }
}

resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "main-vpc"
  }
}

output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main.id
}
```

```bash
$ terraform validate
Success! The configuration is valid.
```

**Invalid Configuration Examples:**

```hcl
# Syntax error - missing closing brace
resource "aws_instance" "web" {
  ami           = "ami-12345"
  instance_type = "t3.micro"
# Missing closing brace
```

```bash
$ terraform validate
Error: Unclosed configuration block

  on main.tf line 2, in resource "aws_instance" "web":
   2: resource "aws_instance" "web" {

There is no closing brace for this block before the end of the file.
```

```hcl
# Invalid argument name
resource "aws_instance" "web" {
  ami           = "ami-12345"
  instance_type = "t3.micro"
  invalid_arg   = "value"  # This argument doesn't exist
}
```

```bash
$ terraform validate
Error: Unsupported argument

  on main.tf line 4, in resource "aws_instance" "web":
   4:   invalid_arg = "value"

An argument named "invalid_arg" is not expected here.
```

```hcl
# Type mismatch
variable "instance_count" {
  type    = number
  default = "not_a_number"  # String provided for number type
}
```

```bash
$ terraform validate
Error: Invalid default value for variable

  on main.tf line 3, in variable "instance_count":
   3:   default = "not_a_number"

This default value is not compatible with the variable's type constraint:
number required.
```

### 🔄 Advanced Validation

```bash
# Validate with detailed JSON output
terraform validate -json | jq

# Example JSON output for errors:
{
  "valid": false,
  "error_count": 1,
  "warning_count": 0,
  "diagnostics": [
    {
      "severity": "error",
      "summary": "Unsupported argument",
      "detail": "An argument named \"invalid_arg\" is not expected here.",
      "range": {
        "filename": "main.tf",
        "start": {
          "line": 4,
          "column": 3,
          "byte": 89
        },
        "end": {
          "line": 4,
          "column": 14,
          "byte": 100
        }
      }
    }
  ]
}

# Use in CI/CD pipeline
terraform validate -json > validation_results.json
if [ $(jq -r '.valid' validation_results.json) = "false" ]; then
  echo "Validation failed!"
  jq -r '.diagnostics[].summary' validation_results.json
  exit 1
fi
```

---

## 🔧 terraform console - Interactive Console

The `terraform console` command provides an **interactive console** for evaluating **Terraform expressions** and **testing functions**.

### 🎯 Basic terraform console Usage

```bash
# Start interactive console
terraform console

# Evaluate expression from command line
echo "var.environment" | terraform console

# Use with input file
echo 'length(["a", "b", "c"])' | terraform console

# Exit console
> exit
# or Ctrl+C / Ctrl+D
```

### 💻 Console Examples

**Testing Variables and Locals:**

```bash
$ terraform console
> var.environment
"production"

> var.instance_count
3

> local.common_tags
{
  "Environment" = "production"
  "ManagedBy" = "terraform"
  "Project" = "web-app"
}
```

**Testing Functions:**

```bash
> length(["web", "app", "db"])
3

> upper("hello world")
"HELLO WORLD"

> join("-", ["web", "server", "01"])
"web-server-01"

> split(",", "apple,banana,cherry")
[
  "apple",
  "banana",
  "cherry",
]

> cidrsubnet("10.0.0.0/16", 8, 1)
"10.0.1.0/24"

> formatdate("YYYY-MM-DD", timestamp())
"2023-12-01"
```

**Testing Expressions:**

```bash
> var.environment == "production" ? "prod" : "dev"
"prod"

> [for i in range(3) : "server-${i + 1}"]
[
  "server-1",
  "server-2",
  "server-3",
]

> {for k, v in var.tags : k => upper(v)}
{
  "environment" = "PRODUCTION"
  "project" = "WEB-APP"
}

> flatten([["a", "b"], ["c", "d"]])
[
  "a",
  "b",
  "c",
  "d",
]
```

**Testing Resource References:**

```bash
> aws_vpc.main.id
"vpc-12345678"

> aws_subnet.public[*].id
[
  "subnet-12345",
  "subnet-67890",
]

> data.aws_availability_zones.available.names
[
  "us-west-2a",
  "us-west-2b",
  "us-west-2c",
]
```

### 🔧 Advanced Console Usage

**Complex Expression Testing:**

```bash
> local.subnet_configs = {
>   for az in data.aws_availability_zones.available.names :
>   az => {
>     cidr = cidrsubnet(var.vpc_cidr, 8, index(data.aws_availability_zones.available.names, az))
>     az   = az
>   }
> }

> local.subnet_configs
{
  "us-west-2a" = {
    "az" = "us-west-2a"
    "cidr" = "10.0.0.0/24"
  }
  "us-west-2b" = {
    "az" = "us-west-2b"
    "cidr" = "10.0.1.0/24"
  }
  "us-west-2c" = {
    "az" = "us-west-2c"
    "cidr" = "10.0.2.0/24"
  }
}
```

**Function Exploration:**

```bash
# Test JSON encoding/decoding
> jsonencode({name = "test", count = 3})
"{\"count\":3,\"name\":\"test\"}"

> jsondecode("{\"name\":\"test\",\"count\":3}")
{
  "count" = 3
  "name" = "test"
}

# Test template functions
> templatefile("${path.module}/user_data.tpl", {hostname = "web01"})
"#!/bin/bash\necho 'Setting hostname to web01'\nhostname web01\n"

# Test validation functions
> can(regex("^[0-9]+$", "123"))
true

> can(regex("^[0-9]+$", "abc"))
false
```

---

## 💻 **Exercise 12.1**: Code Quality Workflow

**Duration**: 20 minutes

Let's practice a complete code quality workflow with formatting, validation, and interactive debugging.

**Step 1: Create Poorly Formatted Configuration**

```bash
mkdir terraform-quality-demo
cd terraform-quality-demo
```

Create `main.tf` with intentional formatting issues:

```hcl
terraform{
required_providers{
aws={
source="hashicorp/aws"
version="~> 5.0"
}
}
}

provider "aws"{
region=var.aws_region
}

variable "aws_region"{
type=string
default="us-west-2"
description   ="AWS region for resources"

validation{
condition=contains(["us-west-2","us-east-1","eu-west-1"], var.aws_region)
error_message="Region must be us-west-2, us-east-1, or eu-west-1."
}
}

variable "environment"{
type=string
default="dev"
}

variable   "instance_count" {
type=number
default=2
}

locals{
common_tags={
Environment=var.environment
ManagedBy="terraform"
Project="quality-demo"
}
}

resource "aws_vpc"    "main"{
cidr_block="10.0.0.0/16"
enable_dns_hostnames=true
enable_dns_support=true

tags=merge(local.common_tags,{
Name="main-vpc"
})
}

resource "aws_subnet" "public"{
count=var.instance_count
vpc_id=aws_vpc.main.id
cidr_block=cidrsubnet(aws_vpc.main.cidr_block,8,count.index)
availability_zone=data.aws_availability_zones.available.names[count.index]
map_public_ip_on_launch=true

tags=merge(local.common_tags,{
Name="public-subnet-${count.index + 1}"
Type="public"
})
}

data "aws_availability_zones""available"{
state="available"
}

output "vpc_id"{
description="VPC ID"
value=aws_vpc.main.id
}

output "subnet_ids"{
description="Public subnet IDs"
value=aws_subnet.public[*].id
}
```

**Step 2: Check Current Formatting**

```bash
# Check if formatting is needed
terraform fmt -check
echo "Exit code: $?"  # Should be 3 (needs formatting)

# Show what would change
terraform fmt -diff
```

**Step 3: Format the Code**

```bash
# Format all files
terraform fmt

# Verify formatting is now correct
terraform fmt -check
echo "Exit code: $?"  # Should be 0 (properly formatted)

# View the formatted result
cat main.tf
```

**Step 4: Validate Configuration**

```bash
# Initialize first (required for validation with providers)
terraform init

# Validate configuration
terraform validate

# Get detailed JSON output
terraform validate -json | jq
```

**Step 5: Interactive Console Testing**

```bash
# Start console
terraform console

# Test variables
> var.aws_region
> var.environment
> var.instance_count

# Test locals
> local.common_tags

# Test functions
> length(data.aws_availability_zones.available.names)
> cidrsubnet("10.0.0.0/16", 8, 0)
> cidrsubnet("10.0.0.0/16", 8, 1)

# Test complex expressions
> [for i in range(var.instance_count) : "subnet-${i + 1}"]
> {for i in range(var.instance_count) : "subnet-${i}" => cidrsubnet("10.0.0.0/16", 8, i)}

# Exit console
> exit
```

**Step 6: Add Validation Error for Testing**
Add this to `main.tf`:

```hcl
# Intentional error for testing
resource "aws_instance" "invalid" {
  ami           = "ami-12345"
  instance_type = "t3.micro"
  invalid_arg   = "this will cause validation error"
}
```

```bash
# Validate again (should fail)
terraform validate

# Check JSON output
terraform validate -json | jq '.diagnostics'
```

**Step 7: Fix Error and Final Validation**

```bash
# Remove the invalid resource
# Edit main.tf to remove the invalid resource block

# Format and validate
terraform fmt
terraform validate

# Test in console
terraform console
> aws_vpc.main.cidr_block
> aws_subnet.public[0].cidr_block
> exit
```

**Step 8: CI/CD Integration Script**
Create `validate.sh`:

```bash
#!/bin/bash
set -e

echo "🎨 Checking Terraform formatting..."
terraform fmt -check -recursive
if [ $? -ne 0 ]; then
  echo "❌ Terraform files need formatting. Run 'terraform fmt -recursive'"
  exit 1
fi
echo "✅ Terraform formatting is correct"

echo "🔍 Validating Terraform configuration..."
terraform validate
if [ $? -ne 0 ]; then
  echo "❌ Terraform validation failed"
  exit 1
fi
echo "✅ Terraform validation passed"

echo "🚀 All quality checks passed!"
```

```bash
chmod +x validate.sh
./validate.sh
```

**Step 9: VS Code Integration**
Create `.vscode/settings.json`:

```json
{
  "terraform.format.enable": true,
  "editor.formatOnSave": true,
  "files.associations": {
    "*.tf": "terraform",
    "*.tfvars": "terraform"
  },
  "terraform.validate.enable": true,
  "terraform.codelens.enable": true
}
```

💡 **Pro Tip**: Integrate `terraform fmt -check` and `terraform validate` into your CI/CD pipeline to ensure consistent code quality!

---

## ✅ Module 12 Summary

**🎯 Learning Objectives Achieved:**

- ✅ Mastered **code formatting** with `terraform fmt` for consistent style
- ✅ Implemented **configuration validation** using `terraform validate`
- ✅ Learned **interactive debugging** with `terraform console`
- ✅ Established **code quality practices** for Terraform projects
- ✅ Integrated **formatting and validation** into development workflows
- ✅ Developed **troubleshooting skills** for configuration issues

**🔑 Key Concepts Covered:**

- **Code Formatting**: Automatic formatting, style consistency, CI/CD integration
- **Configuration Validation**: Syntax checking, semantic validation, error reporting
- **Interactive Console**: Expression testing, function exploration, debugging
- **Quality Workflows**: Pre-commit hooks, automated checks, team standards
- **IDE Integration**: VS Code configuration, automatic formatting, real-time validation

**💼 Professional Skills Developed:**

- **Code Quality**: Maintaining consistent, readable Terraform code
- **Debugging Techniques**: Using console for expression testing and troubleshooting
- **Workflow Integration**: Automating quality checks in development pipelines
- **Team Collaboration**: Establishing coding standards and practices
- **Problem Solving**: Identifying and resolving configuration issues

**➡️ Next Steps**: Ready to explore **Plan and Apply** where you'll master execution planning, applying changes, and saved plans!

---

---

## 🔗 **Next Steps**

Ready to continue your Terraform journey? Proceed to the next module:

**➡️ [Module 16: Plan and Apply](./module_16_plan_and_apply.md)**

Master the core Terraform workflow for safe infrastructure changes.

---
