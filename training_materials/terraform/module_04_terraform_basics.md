
# ⚡ Module 04: Terraform Basics

*Duration: 3 hours | Labs: 4* | Difficulty: 🟢 Beginner*

## 🎯 Learning Objectives

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

**Example Plan Output (Jamf Pro):**

```bash
Terraform will perform the following actions:

  # jamfpro_policy.software_update will be created
  + resource "jamfpro_policy" "software_update" {
      + name                = "Auto Software Updates"
      + enabled            = true
      + frequency          = "Once per day"
      + target_drive       = "/"
      + category          = {
          + name = "Software Updates"
        }
    }

  # jamfpro_computer_group.marketing will be modified
  ~ resource "jamfpro_computer_group" "marketing" {
        id       = "123"
        name     = "Marketing Computers"
      ~ criteria {
          + criterion = "Department"
          + operator  = "is"
          + value     = "Marketing"
        }
    }

Plan: 1 to add, 1 to change, 0 to destroy.
```

💡 **Pro Tip**: `terraform plan` is sometimes referred to as a speculative plan. It is used to preview the changes that will be applied to the infrastructure. You can use the optional `-out=FILE` option to save the generated plan to a file on disk, which you can later execute by passing the file to terraform apply as an extra argument. This two-step workflow is primarily intended for when running Terraform in automation e.g with CI/CD pipelines.

[hashi docs: terraform plan command](https://developer.hashicorp.com/terraform/cli/commands/plan)

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

**📈 Dependency Graph Example (Jamf Pro):**
```hcl
# This configuration creates dependencies
resource "jamfpro_category" "software" {
  name = "Software Management"
}

resource "jamfpro_computer_group" "dev_machines" {
  name = "Developer Machines"
  # Group criteria configuration
}

resource "jamfpro_policy" "install_xcode" {
  name     = "Install Xcode"
  category = jamfpro_category.software.name  # Depends on category
  scope {
    computer_groups = [jamfpro_computer_group.dev_machines.id]  # Depends on group
  }
}
```

The graph shows: **Category → Computer Group → Policy** dependency chain.

💡 **Pro Tip**: Use `terraform graph` to understand complex resource relationships and optimize your configuration for parallel execution!

[hashi docs: terraform graph command](https://developer.hashicorp.com/terraform/cli/commands/graph)

### 💻 **Exercise 3.1**: Visualizing Dependencies with Terraform Graph
**Duration**: 20 minutes

Let's explore Terraform's dependency graph using Jamf Pro resources to understand how Terraform determines execution order.

**Step 1: Setup Project Structure**
```bash
# Create new project directory
mkdir ~/terraform-graph-example
cd ~/terraform-graph-example

# Open in VS Code
code .
```

**Step 2: Create Variables File**

Create `variables.tf`:
```hcl
variable "version_number" {
  description = "The version number to include in the name and install button text."
  type        = string
  default     = "v1.0"
}
```

**Step 3: Create Jamf Pro Configuration with Dependencies**

Create `main.tf`:
```hcl
terraform {
  required_version = ">= 1.0"
  
  required_providers {
    jamfpro = {
      source  = "deploymenttheory/jamfpro"
      version = "~> 0.24.0"
    }
  }
}

variable "version_number" {
  description = "The version number to include in the name and install button text."
  type        = string
  default     = "v1.0"
}

provider "jamfpro" {
  jamfpro_instance_fqdn                = "https://your-instance.jamfcloud.com"
  auth_method                          = "oauth2"
  client_id                            = "your-client-id"
  client_secret                        = "your-client-secret"
  jamfpro_load_balancer_lock           = true
}

# 1. Categories (no dependencies)
resource "jamfpro_category" "software" {
  name     = "Software Management"
  priority = 10
}

resource "jamfpro_category" "security" {
  name     = "Security Policies"
  priority = 5
}

# 2. Smart Computer Groups (no dependencies on other resources)
resource "jamfpro_smart_computer_group" "developer_machines" {
  name = "Developer Machines - ${var.version_number}"
  
  criteria {
    name          = "Department"
    priority      = 0
    and_or        = "and"
    search_type   = "is"
    value         = "Engineering"
    opening_paren = false
    closing_paren = false
  }
}

resource "jamfpro_smart_computer_group" "marketing_machines" {
  name = "Marketing Machines - ${var.version_number}"
  
  criteria {
    name          = "Department"
    priority      = 0
    and_or        = "and"
    search_type   = "is"
    value         = "Marketing"
    opening_paren = false
    closing_paren = false
  }
}

# 3. Policies (depend on categories and groups)
resource "jamfpro_policy" "developer_maintenance" {
  name                        = "Developer Machine Maintenance - ${var.version_number}"
  enabled                     = true
  trigger_checkin            = true
  trigger_enrollment_complete = false
  trigger_login              = false
  frequency                  = "Once per computer"
  target_drive               = "/"
  category_id                = jamfpro_category.software.id
  
  scope {
    all_computers      = false
    computer_group_ids = [jamfpro_smart_computer_group.developer_machines.id]
  }
  
  payloads {
    maintenance {
      recon                       = true
      reset_name                  = false
      install_all_cached_packages = false
      heal                        = false
      prebindings                 = false
      permissions                 = true
      byhost                      = false
      system_cache                = true
      user_cache                  = false
      verify                      = true
    }
  }
}

resource "jamfpro_policy" "security_baseline" {
  name                        = "Security Baseline Configuration - ${var.version_number}"
  enabled                     = true
  trigger_checkin            = true
  trigger_enrollment_complete = true
  frequency                  = "Ongoing"
  target_drive               = "/"
  category_id                = jamfpro_category.security.id
  
  scope {
    all_computers      = false
    computer_group_ids = [
      jamfpro_smart_computer_group.developer_machines.id,
      jamfpro_smart_computer_group.marketing_machines.id
    ]
  }
  
  payloads {
    maintenance {
      recon                       = true
      permissions                 = true
      system_cache                = true
      verify                      = true
    }
  }
}

# 4. Configuration Profile (depends on computer group and category)
resource "jamfpro_macos_configuration_profile_plist" "root_ca_cert" {
  name                = "google root ca cert - ${var.version_number}"
  description         = "Automatically deploy google root ca"
  level               = "System"
  distribution_method = "Install Automatically"
  redeploy_on_update  = "Newly Assigned"
  payloads           = file("${path.module}/root-ca.mobileconfig")
  payload_validate    = true
  user_removable      = false
  category_id         = jamfpro_category.software.id
  
  scope {
    all_computers      = false
    computer_group_ids = [jamfpro_smart_computer_group.developer_machines.id]
  }
}

# 5. Self Service Policy (depends on multiple resources)
resource "jamfpro_policy" "self_service_apps" {
  name                  = "Self Service App Installation - ${var.version_number}"
  enabled               = true
  trigger_other         = "USER_INITIATED"
  frequency             = "Ongoing"
  target_drive          = "/"
  category_id           = jamfpro_category.software.id
  
  scope {
    all_computers      = false
    computer_group_ids = [
      jamfpro_smart_computer_group.developer_machines.id,
      jamfpro_smart_computer_group.marketing_machines.id
    ]
  }
  
  self_service {
    use_for_self_service            = true
    install_button_text             = "Install Apps - ${var.version_number}"
    self_service_description        = "Install essential applications for your department"
    force_users_to_view_description = true
    feature_on_main_page           = true
  }
  
  payloads {
    maintenance {
      recon = true
    }
  }
}
```

**Step 4: Create WiFi Configuration Profile**

Create `root-ca.mobileconfig`:
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
    <key>PayloadContent</key>
    <array>
      <dict>
        <key>PayloadDisplayName</key>
        <string>Google Example Root CA</string>
        <key>PayloadCertificateFileName</key>
        <string>GTS_Root_G1.cer</string>
        <key>PayloadContent</key>
        <data>
          MIIFYjCCBEqgAwIBAgIQd70NbNs2+RrqIQ/E8FjTDTANBgkqhkiG9w0BAQsFADBX
          MQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEQMA4GA1UE
          CxMHUm9vdCBDQTEbMBkGA1UEAxMSR2xvYmFsU2lnbiBSb290IENBMB4XDTIwMDYx
          OTAwMDA0MloXDTI4MDEyODAwMDA0MlowRzELMAkGA1UEBhMCVVMxIjAgBgNVBAoT
          GUdvb2dsZSBUcnVzdCBTZXJ2aWNlcyBMTEMxFDASBgNVBAMTC0dUUyBSb290IFIx
          MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAthECix7joXebO9y/lD63
          ladAPKH9gvl9MgaCcfb2jH/76Nu8ai6Xl6OMS/kr9rH5zoQdsfnFl97vufKj6bwS
          iV6nqlKr+CMny6SxnGPb15l+8Ape62im9MZaRw1NEDPjTrETo8gYbEvs/AmQ351k
          KSUjB6G00j0uYODP0gmHu81I8E3CwnqIiru6z1kZ1q+PsAewnjHxgsHA3y6mbWwZ
          DrXYfiYaRQM9sHmklCitD38m5agI/pboPGiUU+6DOogrFZYJsuB6jC511pzrp1Zk
          j5ZPaK49l8KEj8C8QMALXL32h7M1bKwYUH+E4EzNktMg6TO8UpmvMrUpsyUqtEj5
          cuHKZPfmghCN6J3Cioj6OGaK/GP5Afl4/Xtcd/p2h/rs37EOeZVXtL0m79YB0esW
          CruOC7XFxYpVq9Os6pFLKcwZpDIlTirxZUTQAs6qzkm06p98g7BAe+dDq6dso499
          iYH6TKX/1Y7DzkvgtdizjkXPdsDtQCv9Uw+wp9U7DbGKogPeMa3Md+pvez7W35Ei
          Eua++tgy/BBjFFFy3l3WFpO9KWgz7zpm7AeKJt8T11dleCfeXkkUAKIAf5qoIbap
          sZWwpbkNFhHax2xIPEDgfg1azVY80ZcFuctL7TlLnMQ/0lUTbiSw1nH69MG6zO0b
          9f6BQdgAmD06yK56mDcYBZUCAwEAAaOCATgwggE0MA4GA1UdDwEB/wQEAwIBhjAP
          BgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBTkrysmcRorSCeFL1JmLO/wiRNxPjAf
          BgNVHSMEGDAWgBRge2YaRQ2XyolQL30EzTSo//z9SzBgBggrBgEFBQcBAQRUMFIw
          JQYIKwYBBQUHMAGGGWh0dHA6Ly9vY3NwLnBraS5nb29nL2dzcjEwKQYIKwYBBQUH
          MAKGHWh0dHA6Ly9wa2kuZ29vZy9nc3IxL2dzcjEuY3J0MDIGA1UdHwQrMCkwJ6Al
          oCOGIWh0dHA6Ly9jcmwucGtpLmdvb2cvZ3NyMS9nc3IxLmNybDA7BgNVHSAENDAy
          MAgGBmeBDAECATAIBgZngQwBAgIwDQYLKwYBBAHWeQIFAwIwDQYLKwYBBAHWeQIF
          AwMwDQYJKoZIhvcNAQELBQADggEBADSkHrEoo9C0dhemMXoh6dFSPsjbdBZBiLg9
          NR3t5P+T4Vxfq7vqfM/b5A3Ri1fyJm9bvhdGaJQ3b2t6yMAYN/olUazsaL+yyEn9
          WprKASOshIArAoyZl+tJaox118fessmXn1hIVw41oeQa1v1vg4Fv74zPl6/AhSrw
          9U5pCZEt4Wi4wStz6dTZ/CLANx8LZh1J7QJVj2fhMtfTJr9w4z30Z209fOU0iOMy
          +qduBmpvvYuR7hZL6Dupszfnw0Skfths18dG9ZKb59UhvmaSGZRVbNQpsg3BZlvi
          d0lIKO2d1xozclOzgjXPYovJJIultzkMu34qQb9Sz/yilrbCgj8=
        </data>
        <key>PayloadDescription</key>
        <string></string>
        <key>AllowAllAppsAccess</key>
        <true/>
        <key>KeyIsExtractable</key>
        <false />
        <key>PayloadEnabled</key>
        <true/>
        <key>PayloadIdentifier</key>
        <string>e0eda400-195d-4e65-9719-ab6ab33910cf</string>
        <key>PayloadOrganization</key>
        <string>Example Org</string>
        <key>PayloadType</key>
        <string>com.apple.security.pkcs1</string>
        <key>PayloadUUID</key>
        <string>e0eda400-195d-4e65-9719-ab6ab33910cf</string>
        <key>PayloadVersion</key>
        <integer>1</integer>
      </dict>
    </array>
    <key>PayloadDescription</key>
    <string>Distributes the Root Example Certificates</string>
    <key>PayloadDisplayName</key>
    <string>Example Certs</string>
    <key>PayloadEnabled</key>
    <true/>
    <key>PayloadIdentifier</key>
    <string>d0fde289-97c3-4d7c-a218-89a70f88c5aa</string>
    <key>PayloadOrganization</key>
    <string>Example Org</string>
    <key>PayloadRemovalDisallowed</key>
    <true/>
    <key>PayloadScope</key>
    <string>System</string>
    <key>PayloadType</key>
    <string>Configuration</string>
    <key>PayloadUUID</key>
    <string>d0fde289-97c3-4d7c-a218-89a70f88c5aa</string>
    <key>PayloadVersion</key>
    <integer>1</integer>
  </dict>
</plist>
```

**Step 5: Initialize the Project**
```bash
# Initialize Terraform
terraform init

# Validate the configuration
terraform validate
```

**Step 6: Generate Basic Dependency Graph**
```bash
# Generate the dependency graph in DOT format
terraform graph
```
**expected output**

```bash
digraph G {
  rankdir = "RL";
  node [shape = rect, fontname = "sans-serif"];
  "jamfpro_category.security" [label="jamfpro_category.security"];
  "jamfpro_category.software" [label="jamfpro_category.software"];
  "jamfpro_macos_configuration_profile_plist.root_ca_cert" [label="jamfpro_macos_configuration_profile_plist.root_ca_cert"];
  "jamfpro_policy.developer_maintenance" [label="jamfpro_policy.developer_maintenance"];
  "jamfpro_policy.security_baseline" [label="jamfpro_policy.security_baseline"];
  "jamfpro_policy.self_service_apps" [label="jamfpro_policy.self_service_apps"];
  "jamfpro_smart_computer_group.developer_machines" [label="jamfpro_smart_computer_group.developer_machines"];
  "jamfpro_smart_computer_group.marketing_machines" [label="jamfpro_smart_computer_group.marketing_machines"];
  "local_file.hello" [label="local_file.hello"];
  "jamfpro_macos_configuration_profile_plist.root_ca_cert" -> "jamfpro_category.software";
  "jamfpro_macos_configuration_profile_plist.root_ca_cert" -> "jamfpro_smart_computer_group.developer_machines";
  "jamfpro_policy.developer_maintenance" -> "jamfpro_category.software";
  "jamfpro_policy.developer_maintenance" -> "jamfpro_smart_computer_group.developer_machines";
  "jamfpro_policy.security_baseline" -> "jamfpro_category.security";
  "jamfpro_policy.security_baseline" -> "jamfpro_smart_computer_group.developer_machines";
  "jamfpro_policy.security_baseline" -> "jamfpro_smart_computer_group.marketing_machines";
  "jamfpro_policy.self_service_apps" -> "jamfpro_category.software";
  "jamfpro_policy.self_service_apps" -> "jamfpro_smart_computer_group.developer_machines";
  "jamfpro_policy.self_service_apps" -> "jamfpro_smart_computer_group.marketing_machines";
}
```

**Step 7: Create Visual Graph (Optional - Requires GraphViz)**
```bash
# Install GraphViz if not already installed
# macOS:
brew install graphviz

# Ubuntu/Debian:
# sudo apt install graphviz

# Create SVG visualization
terraform graph | dot -Tsvg > dependency-graph.svg

# Create PNG visualization  
terraform graph | dot -Tpng > dependency-graph.png

# Open the visualization
open dependency-graph.svg  # macOS
# xdg-open dependency-graph.svg  # Linux
```

**Step 8: Analyze the Graph Output**

Look for these dependency relationships in the graph:
- **Categories** have no dependencies (created first)
- **Computer Groups** have no dependencies (created in parallel with categories)  
- **Policies** depend on both categories and computer groups
- **Configuration Profiles** depend on both categories and computer groups
- **Self Service Policy** depends on categories and multiple computer groups

**Step 9: Create Plan to See Execution Order**
```bash
# Generate execution plan to see the actual order
terraform plan

# Notice the order:
# 1. Categories and Computer Groups (can be created in parallel)
# 2. Policies and Configuration Profiles (wait for categories and groups)
# 3. Complex policies with multiple dependencies created last
```

**Step 10: Understanding Graph Types**
```bash
# Different graph types for different scenarios:

# Plan graph (default) - shows what will be created/modified
terraform graph

# Apply graph - shows execution during apply
terraform graph -type=plan-destroy

# Refresh graph - shows data source dependencies  
terraform graph -type=refresh
```

**🔍 What You Should Observe:**

1. **Parallel Execution**: Categories and Computer Groups can be created simultaneously
2. **Dependency Chain**: Policies must wait for both categories and groups
3. **Resource References**: Configuration profile references the mobileconfig file
4. **Multiple Dependencies**: Self Service policy depends on category and multiple groups
5. **Variable Dependencies**: All resources using `var.version_number` show implicit dependencies

**💡 Key Learning Points:**
- Terraform automatically determines the optimal execution order
- Resources with no dependencies can be created in parallel
- Complex dependency chains are resolved automatically
- File references create implicit dependencies on local files
- Variables create relationships between resources that use them
- The graph helps identify bottlenecks in large configurations

**🧹 Clean Up (Optional)**
```bash
# If you applied the configuration, clean up resources
terraform destroy -auto-approve
```

💡 **Pro Tip**: Use `terraform graph | grep -E "jamfpro_"` to filter and see only your Jamf Pro resources in large graphs!

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

**🔍 Replacement vs Update (Jamf Pro):**
```hcl
# This resource configuration
resource "jamfpro_policy" "software_update" {
  name      = "Monthly Software Updates"
  enabled   = true
  frequency = "Once per month"  # Changing this may require replacement
  
  category = {
    name = "System Maintenance"
  }
}
```

**Example Scenarios (Jamf Pro):**
```bash
# Scenario 1: Force recreation of corrupted policy
terraform apply -replace="jamfpro_policy.software_update"

# Scenario 2: Replace specific policy in a count/for_each
terraform apply -replace="jamfpro_policy.department_policies[0]"
terraform apply -replace='jamfpro_policy.site_policies["main_office"]'

# Scenario 3: Combine with other changes
terraform apply -replace="jamfpro_policy.software_update" -var="update_frequency=weekly"
```

**🚨 Important Limitations:**

- **One resource at a time**: Can only replace single resources, not multiple in one flag
- **Destructive operation**: Resource will be destroyed and recreated
- **Dependency aware**: Terraform will handle dependent resource updates automatically
- **State consistency**: Replacement maintains state file consistency

**💡 Modern Best Practices (Jamf Pro):**
```bash
# ✅ Modern approach
terraform plan -replace="jamfpro_policy.software_update"

# ❌ Deprecated approach (don't use)
terraform taint jamfpro_policy.software_update
terraform plan
```

💡 **Pro Tip**: Always run `terraform plan -replace` first to review the replacement impact before applying!

### 💻 **Exercise 3.2**: Core Terraform Workflow
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

#### 🎯 Use Cases for Terraform with Jamf Pro

**🏢 Enterprise Use Cases:**
- **🍎 Multi-environment MDM**: Consistent device management across dev, staging, production
- **🔄 Policy standardization**: Automated policy deployment across multiple Jamf Pro instances
- **📱 Device configuration**: Complete device enrollment and configuration workflows
- **🛡️ Compliance automation**: Standardized, auditable security policies
- **💾 Disaster recovery**: Rapid Jamf Pro configuration restoration

**🔧 Common Jamf Pro Patterns:**
```hcl
# 1. Organizational Foundation
resource "jamfpro_category" "security" { /* ... */ }
resource "jamfpro_site" "main_office" { /* ... */ }
resource "jamfpro_department" "engineering" { /* ... */ }

# 2. Device Grouping
resource "jamfpro_computer_group" "laptops" { /* ... */ }
resource "jamfpro_mobile_device_group" "ipads" { /* ... */ }

# 3. Policy Management
resource "jamfpro_policy" "security_baseline" { /* ... */ }
resource "jamfpro_configuration_profile" "wifi_settings" { /* ... */ }

# 4. Application Management
resource "jamfpro_package" "corporate_app" { /* ... */ }
resource "jamfpro_mobile_device_application" "required_apps" { /* ... */ }
```

---

## ✅ Module 4 Summary

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

**➡️ Ready for Module 5?** Let me know when you'd like to continue with Terraform Provisioners - where we'll learn how to configure resources after they're created!

---

---

## 🔗 **Next Steps**

Ready to continue your Terraform journey? Proceed to the next module:

**➡️ [Module 5: Configuration Management and Provisioners](./module_05_configuration_management_and_provisioners.md)**

Learn advanced configuration management techniques and provisioner usage.

---
