# 🛠️ Module 05: Configuration Management and Provisioners

*Duration: 3 hours | Labs: 5* | 🟢 Beginner*
---

### 🎯 Learning Objectives
By the end of this module, you will be able to:
- ✅ **Implement declarative Jamf Pro resources for standard device management**
- ✅ **Understand when declarative resources aren't enough**  
- ✅ **Identify scenarios requiring imperative actions and API calls**
- ✅ Work with terraform_data resources for device management workflows
- ✅ Recognize when MDM commands and external integrations are necessary
- ✅ Understand Terraform provisioners and their limitations in device management
- ✅ Know when to use provisioners for security events and CVE responses
- ✅ Configure provisioners appropriately for real-time device management scenarios

### 📚 Topics Covered

## ⚡ Modern Device Configuration Management Approaches

**🎯 The Problem This Module Solves**: Sometimes declarative Terraform resources aren't enough - you need imperative actions triggered by real-world events and security requirements.

**🔑 Core Concept**: Modern device management primarily uses **declarative configuration** through native Jamf Pro resources, but certain scenarios require **imperative actions** that go beyond standard resource management.

### 📋 **Declarative Approach** (Preferred for Standard Management):

1. **📱 Configuration Profiles**: Built-in macOS/iOS configuration management
2. **📦 Jamf Packages**: Pre-built software installers with dependency management  
3. **🎯 Smart Policies**: Automated deployment based on device criteria and schedules
4. **🛍️ Self Service**: User-initiated installations and configurations

### 🚨 **When Declarative Resources Fall Short - Real-World Scenarios:**

#### **1. Security Event Response**
- **🔓 CVE Published** → Need immediate assessment of exposure across device fleet
- **⚡ Zero-day exploit detected** → Emergency lockdown of vulnerable devices
- **🚩 Breach indicators found** → Instant device isolation and forensic data collection
- **📊 Vulnerability scanner integration** → Automated patch deployment based on scan results

#### **2. Immediate Actions Required**
- **💻 Device compromised** → Immediate device lock, wipe, or isolation
- **🏃‍♂️ Employee termination** → Instant access revocation across all systems
- **🔄 Critical policy update** → Force immediate device check-in and compliance verification

#### **3. Workflow Orchestration**
- **📋 After deploying policy** → Trigger device check-in to apply immediately
- **✅ After device enrollment** → Verify compliance before network access
- **🔗 System integration** → Coordinate between Jamf and ITSM/monitoring/security tools

#### **4. Dynamic Response to State Changes**
- **❌ Device non-compliance** → Auto-create incident tickets and remediation workflows
- **📈 New threat intelligence** → Push emergency configurations fleet-wide
- **⚠️ Policy deployment failure** → Automated retry logic and administrator notifications

### ⚠️ **Why Standard Provisioners Are Problematic for Device Management:**
- **🐌 Slower**: API-dependent, runs after Terraform resource creation
- **❌ Less Reliable**: Network failures, API rate limiting, MDM command delays
- **🔄 Not Idempotent**: MDM commands can't be safely repeated
- **🤝 Coupling**: Creates tight dependency between Terraform state and live device state
- **🔐 Security**: Requires elevated API credentials and careful permission management

### ✅ **When Modern Declarative Approaches Are Better:**
- **📦 Software Installation**: Use native Jamf packages and policies
- **⚙️ Device Configuration**: Use Configuration Profiles for settings and restrictions
- **📁 File Management**: Deploy files through packages or configuration profiles
- **🔄 Service Management**: Use policies with maintenance and script payloads
- **🏗️ Standard Setup**: Always prefer declarative resources for routine management

---

## 📱 Declarative Device Management: The Recommended Approach

**Declarative Jamf Pro resources** are the industry standard for device configuration management. They represent the **first choice** for most device setup and management tasks.

**🎯 Why Declarative Resources Are Superior:**
- **🚀 Faster**: Applied during device check-in, no additional API delays
- **🔒 More Secure**: No elevated credentials needed beyond provider authentication
- **✅ More Reliable**: Built into Jamf Pro, handles device offline/online scenarios automatically
- **🔄 Idempotent**: Safe to apply multiple times, Terraform manages desired state
- **📱 Standardized**: Works across macOS, iOS, iPadOS, and tvOS devices
- **🔧 Feature-Rich**: Software deployment, configuration profiles, compliance policies, user management

**📝 Basic Declarative Device Configuration:**
```hcl
# Modern approach - Declarative resources handle everything
resource "jamfpro_smart_computer_group" "development_machines" {
  name = "Development Machines"
  
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

resource "jamfpro_policy" "dev_software_bundle" {
  name                        = "Development Software Bundle"
  enabled                     = true
  trigger_checkin            = true
  trigger_enrollment_complete = true
  frequency                  = "Once per computer"
  target_drive               = "/"
  
  scope {
    all_computers      = false
    computer_group_ids = [jamfpro_smart_computer_group.development_machines.id]
  }
  
  # Software installation through packages
  payloads {
    packages = [
      {
        id     = jamfpro_package.xcode.id
        action = "install"
      },
      {
        id     = jamfpro_package.docker.id  
        action = "install"
      },
      {
        id     = jamfpro_package.vscode.id
        action = "install"
      }
    ]
  }
  
  # System maintenance
  payloads {
    maintenance {
      recon                       = true
      permissions                 = true
      system_cache                = true
      verify                      = true
    }
  }
}
```

**🔧 Advanced Declarative Configuration with Multiple Resources:**
```hcl
# Advanced device configuration with multiple coordinated resources
resource "jamfpro_category" "security" {
  name     = "Security Configuration"
  priority = 1
}

resource "jamfpro_smart_computer_group" "executive_devices" {
  name = "Executive Devices"
  
  criteria {
    name          = "Department"
    priority      = 0
    and_or        = "and"
    search_type   = "is"
    value         = "Executive"
    opening_paren = false
    closing_paren = false
  }
}

# Security configuration profile with multiple payloads
resource "jamfpro_macos_configuration_profile_plist" "executive_security" {
  name                = "Executive Security Baseline"
  description         = "Enhanced security configuration for executive devices"
  level               = "System"
  distribution_method = "Install Automatically"
  redeploy_on_update  = "Newly Assigned"
  user_removable      = false
  category_id         = jamfpro_category.security.id
  
  # Multi-payload configuration profile
  payloads = file("${path.module}/profiles/executive-security.mobileconfig")
  
  scope {
    all_computers      = false
    computer_group_ids = [jamfpro_smart_computer_group.executive_devices.id]
  }
}

# Comprehensive security policy
resource "jamfpro_policy" "executive_security_policy" {
  name                        = "Executive Security Policy"
  enabled                     = true
  trigger_checkin            = true
  trigger_enrollment_complete = true
  frequency                  = "Ongoing"
  target_drive               = "/"
  category_id                = jamfpro_category.security.id
  
  scope {
    all_computers      = false
    computer_group_ids = [jamfpro_smart_computer_group.executive_devices.id]
  }
  
  # Security software installation
  payloads {
    packages = [
      {
        id     = jamfpro_package.crowdstrike.id
        action = "install"
      },
      {
        id     = jamfpro_package.vpn_client.id
        action = "install"
      }
    ]
  }
  
  # System hardening
  payloads {
    maintenance {
      recon                       = true
      reset_name                  = false
      install_all_cached_packages = true
      permissions                 = true
      system_cache                = true
      verify                      = true
    }
  }
  
  # Custom script for additional security measures
  payloads {
    scripts = [
      {
        id       = jamfpro_script.security_audit.id
        priority = "After"
      }
    ]
  }
}
```

**💡 Declarative Device Management Best Practices:**
- ✅ Use smart computer groups for dynamic device targeting
- ✅ Leverage native Jamf packages instead of custom scripts
- ✅ Use configuration profiles for system settings and restrictions
- ✅ Set appropriate scope and frequency for policies
- ✅ Use categories and priorities for organized policy deployment
- ✅ Test configurations in development groups before production rollout

---

## 📦 Jamf Packages: Pre-Built Software Deployment

**Jamf Packages** combined with **Smart Policies** represent the **ultimate solution** for efficient, scalable software deployment across device fleets.

**🎯 Why Package-Based Deployment is Superior:**
- **⚡ Fastest Deployment**: Software pre-packaged, just install and configure
- **🏗️ Immutable Packages**: Same package = same result every time
- **🔒 Security**: Signed packages with verified checksums = reduced attack surface  
- **📊 Consistency**: Identical software deployment across all environments
- **🧪 Testable**: Test packages with pilot groups before fleet rollout
- **📦 Reusable**: One package, deployed to thousands of devices

**📝 Basic Package Definition and Deployment:**
```hcl
# Define reusable software packages
resource "jamfpro_package" "development_tools" {
  name                = "Development Tools Bundle v${var.app_version}"
  filename            = "dev-tools-${var.app_version}.pkg"
  category_id         = jamfpro_category.software.id
  priority            = 10
  os_requirements     = "macOS 14.0"
  required_processor  = "None"
  info                = "Essential development tools including Docker, Node.js, and VS Code"
  notes               = "Automatically deployed to development machines"
  reboot_required     = false
  fill_user_template  = false
  fill_existing_users = false
  boot_volume_required = true
  allow_downgrade     = false
  
  # Package manifest details
  manifest_filename = "dev-tools-manifest.plist"
}

resource "jamfpro_package" "security_tools" {
  name                = "Security Tools Bundle v${var.app_version}"
  filename            = "security-tools-${var.app_version}.pkg"  
  category_id         = jamfpro_category.security.id
  priority            = 5
  os_requirements     = "macOS 13.0"
  info                = "Security software including CrowdStrike, VPN client, and certificate management"
  notes               = "Required for all corporate devices"
  reboot_required     = true
  fill_user_template  = false
  fill_existing_users = false
  boot_volume_required = true
  allow_downgrade     = false
}

# Smart policy for automated package deployment
resource "jamfpro_policy" "software_deployment" {
  name                        = "Automated Software Deployment v${var.app_version}"
  enabled                     = true
  trigger_checkin            = true
  trigger_enrollment_complete = true
  frequency                  = "Once per computer"
  target_drive               = "/"
  category_id                = jamfpro_category.software.id
  
  scope {
    all_computers      = false
    computer_group_ids = [jamfpro_smart_computer_group.development_machines.id]
  }
  
  # Deploy packages in priority order
  payloads {
    packages = [
      {
        id     = jamfpro_package.security_tools.id
        action = "install"
      },
      {
        id     = jamfpro_package.development_tools.id
        action = "install"
      }
    ]
  }
}
```

**🔄 Using Package-Based Deployment Patterns:**
```hcl
# Data source to find existing packages (useful for referencing pre-built packages)
data "jamfpro_package" "latest_security_tools" {
  name = "Security Tools Bundle v${var.latest_version}"
}

# Smart computer group for phased rollout
resource "jamfpro_smart_computer_group" "pilot_group" {
  name = "Pilot Deployment Group"
  
  criteria {
    name          = "Computer Name"
    priority      = 0
    and_or        = "and"
    search_type   = "like"
    value         = "pilot-*"
    opening_paren = false
    closing_paren = false
  }
}

# Deploy using pre-built packages - minimal configuration needed
resource "jamfpro_policy" "pilot_deployment" {
  name                        = "Pilot Software Deployment"
  enabled                     = true
  trigger_checkin            = true
  trigger_enrollment_complete = false
  frequency                  = "Once per computer"
  target_drive               = "/"
  category_id                = jamfpro_category.software.id
  
  scope {
    all_computers      = false
    computer_group_ids = [jamfpro_smart_computer_group.pilot_group.id]
  }
  
  # Everything is pre-packaged, just deploy and configure
  payloads {
    packages = [
      {
        id     = data.jamfpro_package.latest_security_tools.id
        action = "install"
      }
    ]
  }
  
  # Minimal post-installation configuration
  payloads {
    scripts = [
      {
        id       = jamfpro_script.environment_config.id
        priority = "After"
        parameter4 = var.environment  # Pass environment variable
      }
    ]
  }
  
  # System verification after deployment
  payloads {
    maintenance {
      recon                = true
      permissions          = true
      verify              = true
    }
  }
}
```

**💡 Package + Policy Workflow:**
1. **🔨 Build Phase**: Create and test packages with all required software
2. **🚀 Deploy Phase**: Terraform creates policies that deploy packages to device groups
3. **⚡ Result**: Fastest, most reliable device configuration possible

**🛠️ Package-Based Deployment Best Practices:**
- ✅ Version your packages with semantic versioning (e.g., v2.1.0)
- ✅ Test packages with pilot groups before production rollout
- ✅ Use different policies for different device types/environments
- ✅ Keep environment-specific data in scripts, not packages
- ✅ Automate package building and deployment in CI/CD pipelines

---

## 🔧 When to Use Imperative Actions - MDM Commands & API Integration

For **time-critical security responses, workflow orchestration, and external system integration**, imperative actions are necessary beyond declarative Terraform resources:

**🎯 Scenarios Requiring Imperative Actions:**

### **🚨 Security Event Response**
- **CVE Published**: Immediate vulnerability assessment across device fleet
- **Device Compromised**: Instant device lock, wipe, or isolation commands
- **Zero-day Exploit**: Emergency policy push and device quarantine
- **Compliance Breach**: Automated remediation and incident response

### **🔄 Workflow Orchestration** 
- **Policy Deployment**: Force immediate device check-in after configuration changes
- **Enrollment Verification**: Validate device compliance before network access
- **Multi-system Coordination**: Sync between Jamf Pro, ITSM, monitoring, and security tools

### **📊 Dynamic Response Integration**
- **External Vulnerability Scanners**: Automated patch deployment based on scan results
- **SIEM Integration**: Device isolation based on threat intelligence
- **Ticketing Systems**: Auto-create incidents for compliance failures
- **Monitoring Systems**: Push configuration changes based on performance metrics

**✅ Use Imperative Actions When:**
- Immediate response required (security incidents, compliance failures)
- Real-time workflow orchestration across multiple systems
- Dynamic policy adjustment based on external data sources
- Integration with non-Jamf systems that require API calls
- CVE response and emergency configuration deployment

**🔄 Terraform + MDM Command Integration Pattern:**
```hcl
# Terraform manages declarative device configuration
resource "jamfpro_policy" "security_update_policy" {
  name                        = "Critical Security Update - CVE Response"
  enabled                     = true
  trigger_checkin            = true
  trigger_enrollment_complete = false
  frequency                  = "Once per computer"
  target_drive               = "/"
  category_id                = jamfpro_category.security.id
  
  scope {
    all_computers      = false
    computer_group_ids = [jamfpro_smart_computer_group.vulnerable_devices.id]
  }
  
  payloads {
    packages = [
      {
        id     = jamfpro_package.security_patch.id
        action = "install"
      }
    ]
  }
  
  # Imperative action: Force immediate device check-in after policy creation
  provisioner "local-exec" {
    command = <<-EOF
      # Send MDM command to force policy check-in immediately
      curl -X POST "${var.jamf_url}/api/v2/mdm-commands" \
        -H "Authorization: Bearer ${var.api_token}" \
        -H "Content-Type: application/json" \
        -d '{
          "commandData": {
            "commandType": "DEVICE_INFORMATION"
          },
          "clientData": [
            {
              "managementId": "all-computers-in-group"
            }
          ]
        }'
      
      # Notify security team of deployment
      python3 /scripts/notify-security-team.py \
        --policy-id "${self.id}" \
        --cve-id "${var.cve_id}" \
        --affected-devices "${length(jamfpro_smart_computer_group.vulnerable_devices.criteria)}"
    EOF
    
    environment = {
      JAMF_URL       = var.jamf_url
      API_TOKEN      = var.api_token
      SECURITY_EMAIL = var.security_team_email
      ENVIRONMENT    = var.environment
    }
  }
  
  # Create ticket in external system
  provisioner "local-exec" {
    command = "python3 /scripts/create-security-ticket.py --policy '${self.name}' --cve '${var.cve_id}'"
  }
}
```

---

## 🚀 terraform_data Resource for Device Management Workflows

The `terraform_data` resource is the **modern replacement** for the deprecated `null_resource`. Use it for advanced device management workflows and triggering imperative actions.

**📝 Basic Usage for Device Management Triggers:**
```hcl
# Use terraform_data to trigger device actions based on configuration changes
resource "terraform_data" "device_configuration_trigger" {
  input = {
    policy_version    = var.policy_version
    config_hash       = filemd5("configs/security-baseline.mobileconfig")
    cve_response      = var.force_security_update ? timestamp() : null
    affected_devices  = length(jamfpro_smart_computer_group.vulnerable_devices.criteria)
  }
}

resource "jamfpro_policy" "security_baseline" {
  name                        = "Security Baseline Configuration v${terraform_data.device_configuration_trigger.input.policy_version}"
  enabled                     = true
  trigger_checkin            = true
  trigger_enrollment_complete = false
  frequency                  = "Ongoing"
  target_drive               = "/"
  category_id                = jamfpro_category.security.id
  
  # Reference terraform_data to trigger policy updates
  lifecycle {
    replace_triggered_by = [
      terraform_data.device_configuration_trigger.output
    ]
  }
  
  scope {
    all_computers      = false
    computer_group_ids = [jamfpro_smart_computer_group.vulnerable_devices.id]
  }
  
  # Modern approach: declarative configuration with dynamic values
  payloads {
    packages = [
      {
        id     = jamfpro_package.security_patch.id
        action = "install"
      }
    ]
  }
  
  # Imperative action triggered by configuration changes
  provisioner "local-exec" {
    command = <<-EOF
      # Send MDM command to force immediate policy application
      python3 /scripts/trigger-device-checkin.py \
        --group-id "${jamfpro_smart_computer_group.vulnerable_devices.id}" \
        --policy-version "${terraform_data.device_configuration_trigger.input.policy_version}" \
        --config-hash "${terraform_data.device_configuration_trigger.input.config_hash}"
    EOF
    
    environment = {
      JAMF_URL    = var.jamf_url
      API_TOKEN   = var.api_token
      POLICY_ID   = self.id
    }
  }
}
```

---

## ⚠️ Provisioners for Device Management: When Declarative Resources Aren't Enough

**🚨 Use provisioners ONLY when declarative Jamf Pro resources can't handle the scenario:**

### When Provisioners Are Needed in Device Management:

**🔍 Specific Use Cases:**
1. **🚨 Emergency MDM Commands**: Immediate device lock, wipe, or isolation for security incidents
2. **🔗 External System Integration**: Calling vulnerability scanners, ITSM, or security tools APIs
3. **📊 Real-time Monitoring**: Integration with SIEM, compliance, or monitoring systems
4. **⚡ CVE Response Workflow**: Automated vulnerability assessment and patch coordination
5. **🔄 Multi-system Orchestration**: Coordinating between Jamf Pro and other enterprise systems

### ⚠️ Provisioner Types for Device Management (Use Sparingly)

**🏠 Local Provisioners** (run on your Terraform execution environment):
- `local-exec`: Execute API calls, scripts, notifications - **primary tool for device management**

**🌐 Remote Provisioners** (limited applicability for device management):
- `remote-exec`: Rarely used - devices don't typically allow SSH access
- `file`: Limited use - configuration profiles and packages preferred

#### 💻 Local-Exec Provisioner for Device Management

The `local-exec` provisioner executes commands on the machine running Terraform - perfect for MDM API calls and external integrations.

**📝 Basic MDM Command Syntax:**
```hcl
resource "jamfpro_policy" "emergency_security_policy" {
  name                        = "Emergency Security Response"
  enabled                     = true
  trigger_checkin            = true
  frequency                  = "Once per computer"
  target_drive               = "/"
  category_id                = jamfpro_category.security.id
  
  scope {
    all_computers      = false
    computer_group_ids = [jamfpro_smart_computer_group.compromised_devices.id]
  }
  
  # Immediate MDM command after policy creation
  provisioner "local-exec" {
    command = <<-EOF
      # Send immediate device lock command
      curl -X POST "${var.jamf_url}/api/v2/mdm-commands" \
        -H "Authorization: Bearer ${var.api_token}" \
        -H "Content-Type: application/json" \
        -d '{
          "commandData": {
            "commandType": "DEVICE_LOCK",
            "lockMessage": "Device locked due to security incident - Contact IT immediately"
          },
          "clientData": [
            {
              "managementId": "all-computers-in-group"
            }
          ]
        }'
        
      echo "Emergency device lock sent for policy ${self.id}"
    EOF
  }
}
```

**🔧 Advanced CVE Response Example:**
```hcl
resource "jamfpro_policy" "cve_response_policy" {
  name                        = "CVE-2024-12345 Response Policy"
  enabled                     = true
  trigger_checkin            = true
  frequency                  = "Once per computer"  
  target_drive               = "/"
  category_id                = jamfpro_category.security.id
  
  scope {
    all_computers      = false
    computer_group_ids = [jamfpro_smart_computer_group.vulnerable_devices.id]
  }
  
  # Log policy deployment
  provisioner "local-exec" {
    command = "echo 'CVE Response Policy Details:' > cve-response-${formatdate("YYYY-MM-DD", timestamp())}.log"
  }
  
  provisioner "local-exec" {
    command = "echo 'Policy ID: ${self.id}' >> cve-response-${formatdate("YYYY-MM-DD", timestamp())}.log"
  }
  
  provisioner "local-exec" {
    command = "echo 'CVE ID: ${var.cve_id}' >> cve-response-${formatdate("YYYY-MM-DD", timestamp())}.log"
  }
  
  # Multi-step response workflow with environment variables
  provisioner "local-exec" {
    command = "./scripts/cve-response-workflow.py"
    
    environment = {
      POLICY_ID      = self.id
      CVE_ID         = var.cve_id
      JAMF_URL       = var.jamf_url
      API_TOKEN      = var.api_token
      AFFECTED_COUNT = length(jamfpro_smart_computer_group.vulnerable_devices.criteria)
      ENVIRONMENT    = var.environment
    }
  }
  
  # External system notifications
  provisioner "local-exec" {
    command = <<-EOF
      # Create ITSM ticket
      python3 ./scripts/create-itsm-ticket.py \
        --title "CVE-${var.cve_id} Response Deployment" \
        --policy-id "${self.id}" \
        --severity "High"
        
      # Notify security team
      python3 ./scripts/notify-security.py \
        --event "cve-response-deployed" \
        --policy "${self.name}" \
        --devices-affected "${length(jamfpro_smart_computer_group.vulnerable_devices.criteria)}"
    EOF
  }
  
  # Cleanup actions on policy destruction
  provisioner "local-exec" {
    when    = destroy
    command = "python3 ./scripts/cleanup-cve-response.py --policy-id '${self.id}' --cve-id '${var.cve_id}'"
  }
}
```

**💡 Pro Tip**: Use `local-exec` for notifications, local logging, or triggering external systems!

#### 🌐 Remote-Exec Provisioner

The `remote-exec` provisioner executes commands on the remote resource after it's created.

**📝 Basic Syntax:**
```hcl
resource "aws_instance" "web" {
  ami           = "ami-12345"
  instance_type = "t2.micro"
  key_name      = "my-key"
  
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("~/.ssh/id_rsa")
    host        = self.public_ip
  }
  
  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install -y httpd",
      "sudo systemctl start httpd",
      "sudo systemctl enable httpd"
    ]
  }
}
```

**🔧 Advanced Example with Script:**
```hcl
resource "aws_instance" "web" {
  ami                    = "ami-12345"
  instance_type          = "t2.micro"
  key_name              = "my-key"
  vpc_security_group_ids = [aws_security_group.web.id]
  
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file(var.private_key_path)
    host        = self.public_ip
    timeout     = "5m"
  }
  
  # Copy and run a script
  provisioner "file" {
    source      = "scripts/setup-web-server.sh"
    destination = "/tmp/setup-web-server.sh"
  }
  
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/setup-web-server.sh",
      "sudo /tmp/setup-web-server.sh"
    ]
  }
  
  # Run a heredoc script
  provisioner "remote-exec" {
    script = "scripts/configure-monitoring.sh"
  }
}
```

#### 📁 File Provisioner

The `file` provisioner copies files or directories from your local machine to the remote resource.

**📝 Basic Syntax:**
```hcl
resource "aws_instance" "web" {
  ami           = "ami-12345"
  instance_type = "t2.micro"
  key_name      = "my-key"
  
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("~/.ssh/id_rsa")
    host        = self.public_ip
  }
  
  # Copy a single file
  provisioner "file" {
    source      = "config/app.conf"
    destination = "/tmp/app.conf"
  }
  
  # Copy entire directory
  provisioner "file" {
    source      = "scripts/"
    destination = "/tmp/scripts/"
  }
  
  # Copy with content (inline)
  provisioner "file" {
    content     = templatefile("templates/nginx.conf.tpl", {
      server_name = "example.com"
      port        = 80
    })
    destination = "/tmp/nginx.conf"
  }
}
```

#### 🔗 Connection Blocks

Connection blocks tell provisioners how to connect to remote resources.

**🔐 SSH Connection:**
```hcl
connection {
  type        = "ssh"
  user        = "ec2-user"
  password    = var.instance_password  # Not recommended
  private_key = file(var.private_key_path)
  host        = self.public_ip
  port        = 22
  timeout     = "5m"
  
  # SSH Agent
  agent = true
  
  # Bastion/Jump host
  bastion_host        = "bastion.example.com"
  bastion_user        = "admin"
  bastion_private_key = file("bastion-key.pem")
}
```

**💻 WinRM Connection (Windows):**
```hcl
connection {
  type     = "winrm"
  user     = "Administrator"
  password = var.admin_password
  host     = self.public_ip
  port     = 5985
  https    = false
  insecure = true
  timeout  = "10m"
}
```

### 💻 **Exercise 4.1**: Local-Exec and Remote-Exec Provisioners
**Duration**: 25 minutes

Let's practice using both local and remote provisioners with a real AWS instance.

**Step 1: Setup Project Structure**
```bash
# Create new project directory
mkdir ~/terraform-provisioners
cd ~/terraform-provisioners

# Create directories for scripts
mkdir scripts
mkdir config

# Open in VS Code
code .
```

**Step 2: Create Main Configuration**

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
  region = var.aws_region
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

# Create key pair for SSH access
resource "aws_key_pair" "main" {
  key_name   = "terraform-provisioner-key"
  public_key = file(var.public_key_path)
}

# Security group for SSH and HTTP
resource "aws_security_group" "web" {
  name_prefix = "terraform-provisioner-"
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
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
}

# EC2 Instance with provisioners
resource "aws_instance" "web" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t2.micro"
  key_name              = aws_key_pair.main.key_name
  vpc_security_group_ids = [aws_security_group.web.id]
  
  tags = {
    Name = "terraform-provisioner-demo"
  }
  
  # Local provisioner - runs on your machine
  provisioner "local-exec" {
    command = "echo 'Instance ${self.id} is being created...'"
  }
  
  # Wait for instance to be ready
  provisioner "local-exec" {
    command = "sleep 30"
  }
  
  # Connection block for remote provisioners
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file(var.private_key_path)
    host        = self.public_ip
    timeout     = "5m"
  }
  
  # Remote provisioner - update system
  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install -y httpd",
      "sudo systemctl start httpd",
      "sudo systemctl enable httpd"
    ]
  }
  
  # Copy web content
  provisioner "file" {
    content = templatefile("${path.module}/config/index.html.tpl", {
      instance_id = self.id
      public_ip   = self.public_ip
      timestamp   = timestamp()
    })
    destination = "/tmp/index.html"
  }
  
  # Move web content and set permissions
  provisioner "remote-exec" {
    inline = [
      "sudo mv /tmp/index.html /var/www/html/",
      "sudo chown apache:apache /var/www/html/index.html",
      "sudo systemctl restart httpd"
    ]
  }
  
  # Local provisioner - log completion
  provisioner "local-exec" {
    command = "echo 'Web server setup completed for ${self.public_ip}' >> deployment.log"
  }
  
  # Cleanup on destroy
  provisioner "local-exec" {
    when    = destroy
    command = "echo 'Instance ${self.id} destroyed at ${timestamp()}' >> deployment.log"
  }
}
```

**Step 3: Create Supporting Files**

Create `variables.tf`:
```hcl
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}

variable "public_key_path" {
  description = "Path to public key file"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "private_key_path" {
  description = "Path to private key file"
  type        = string
  default     = "~/.ssh/id_rsa"
}
```

**Step 4: Deploy and Test**
```bash
# Initialize Terraform
terraform init

# Plan the deployment
terraform plan

# Apply (this will take a few minutes)
terraform apply

# Test the web server
curl $(terraform output -raw web_url)

# Check deployment log
cat deployment.log
```

**Step 5: Clean Up**
```bash
# Destroy resources
terraform destroy

# Check final log entry
cat deployment.log
```

💡 **Pro Tip**: Notice how provisioners run in order and how local-exec can be used for logging and notifications!

---

#### 🚀 terraform_data Resource (Modern Approach)

The `terraform_data` resource is the **modern replacement** for the deprecated `null_resource`. It's designed to hold arbitrary data and trigger recreations based on input changes.

**📝 Basic Usage:**
```hcl
resource "terraform_data" "web_server_setup" {
  # Trigger recreation when any of these change
  input = {
    server_config = var.server_config
    app_version   = var.app_version
    environment   = var.environment
  }
  
  # Lifecycle management
  lifecycle {
    replace_triggered_by = [
      aws_instance.web.ami,
      aws_instance.web.instance_type
    ]
  }
}

resource "aws_instance" "web" {
  ami           = "ami-12345"
  instance_type = "t2.micro"
  
  # Reference terraform_data to establish dependency
  depends_on = [terraform_data.web_server_setup]
  
  # Provisioner using terraform_data trigger
  provisioner "local-exec" {
    command = "echo 'Deploying app version: ${terraform_data.web_server_setup.input.app_version}'"
  }
}
```

**🔧 Advanced Example with Triggers:**
```hcl
# Use terraform_data for conditional provisioning
resource "terraform_data" "app_deployment" {
  input = {
    app_version    = var.app_version
    config_hash    = filemd5("config/app.conf")
    deploy_trigger = timestamp()
  }
}

resource "aws_instance" "app_server" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"
  key_name      = aws_key_pair.main.key_name
  
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file(var.private_key_path)
    host        = self.public_ip
  }
  
  # Provisioner triggered by terraform_data changes
  provisioner "remote-exec" {
    inline = [
      "echo 'Deploying version: ${terraform_data.app_deployment.input.app_version}'",
      "curl -o /tmp/app.tar.gz https://releases.company.com/app-${terraform_data.app_deployment.input.app_version}.tar.gz",
      "sudo tar -xzf /tmp/app.tar.gz -C /opt/app/",
      "sudo systemctl restart app-service"
    ]
  }
}

# Output the deployment info
output "deployment_info" {
  value = terraform_data.app_deployment.input
}
```

**💡 Benefits of terraform_data over null_resource:**
- More explicit and purpose-built
- Better integration with Terraform's dependency system
- Cleaner state management
- Future-proof as null_resource is deprecated

---

#### ☁️ Cloud-Init: The Better Alternative

**Cloud-Init** is an industry standard for cross-platform cloud instance initialization. It's the **recommended approach** instead of provisioners for most instance setup tasks.

**🎯 What is Cloud-Init?**
- **Industry standard** for VM initialization
- **Built into most cloud images** (Amazon Linux, Ubuntu, CentOS, etc.)
- **Runs automatically** on first boot
- **Declarative configuration** using YAML
- **More reliable** than provisioners

**📝 Basic Cloud-Init with User Data:**
```hcl
# Cloud-Init script as user data
resource "aws_instance" "web" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"
  
  # Cloud-Init configuration
  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd
    systemctl start httpd
    systemctl enable httpd
    
    # Create simple web page
    cat > /var/www/html/index.html <<HTML
    <h1>Web Server Deployed with Cloud-Init</h1>
    <p>Instance ID: $(curl -s http://169.254.169.254/latest/meta-data/instance-id)</p>
    <p>Deployed at: $(date)</p>
    HTML
  EOF
  
  tags = {
    Name = "cloud-init-web-server"
  }
}
```

**🔧 Advanced Cloud-Init with YAML Configuration:**
```hcl
# Cloud-Init YAML configuration
locals {
  cloud_init_config = <<-EOF
    #cloud-config
    package_update: true
    packages:
      - httpd
      - git
      - nodejs
      - npm
    
    write_files:
      - path: /etc/httpd/conf.d/app.conf
        content: |
          <VirtualHost *:80>
              ServerName ${var.domain_name}
              DocumentRoot /var/www/html
              ErrorLog /var/log/httpd/error.log
              CustomLog /var/log/httpd/access.log combined
          </VirtualHost>
        permissions: '0644'
    
    runcmd:
      - systemctl start httpd
      - systemctl enable httpd
      - git clone https://github.com/company/web-app.git /var/www/html
      - npm install -g pm2
      - systemctl restart httpd
    
    final_message: "Web server setup completed successfully!"
  EOF
}

resource "aws_instance" "web_advanced" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"
  
  # Base64 encode the cloud-init config for complex YAML
  user_data = base64encode(local.cloud_init_config)
  
  tags = {
    Name = "advanced-cloud-init-server"
  }
}
```

**⚡ Why Choose Cloud-Init over Provisioners?**
- **✅ More Reliable**: Runs during instance boot, not after Terraform
- **✅ Built-in**: No SSH/WinRM connection required
- **✅ Faster**: No network dependency after instance creation
- **✅ Idempotent**: Cloud-Init handles retries and failures
- **✅ Standardized**: Works across all major cloud providers

---

#### 📦 Packer Integration

**Packer** is HashiCorp's automated image builder service. It's often the **best alternative** to provisioners for complex setups.

**🎯 What is Packer?**
- **Automated image building** for multiple platforms
- **Pre-baked images** with software already installed
- **Immutable infrastructure** approach
- **Integrates with Terraform** for complete workflows

**📝 Basic Packer Template Example:**
```json
{
  "builders": [
    {
      "type": "amazon-ebs",
      "access_key": "{{user `aws_access_key`}}",
      "secret_key": "{{user `aws_secret_key`}}",
      "region": "us-west-2",
      "source_ami": "ami-12345",
      "instance_type": "t2.micro",
      "ssh_username": "ec2-user",
      "ami_name": "web-server-{{timestamp}}"
    }
  ],
  "provisioners": [
    {
      "type": "shell",
      "inline": [
        "sudo yum update -y",
        "sudo yum install -y httpd nodejs npm",
        "sudo systemctl enable httpd"
      ]
    },
    {
      "type": "file",
      "source": "app/",
      "destination": "/tmp/"
    },
    {
      "type": "shell",
      "inline": [
        "sudo mv /tmp/app/* /var/www/html/",
        "sudo chown -R apache:apache /var/www/html"
      ]
    }
  ]
}
```

**🔄 Using Packer-Built AMI with Terraform:**
```hcl
# Data source to find Packer-built AMI
data "aws_ami" "web_server" {
  most_recent = true
  owners      = ["self"]
  
  filter {
    name   = "name"
    values = ["web-server-*"]
  }
  
  filter {
    name   = "state"
    values = ["available"]
  }
}

# Use the pre-built AMI (no provisioners needed!)
resource "aws_instance" "web" {
  ami           = data.aws_ami.web_server.id
  instance_type = "t2.micro"
  
  # Just start the service - everything is pre-installed
  user_data = <<-EOF
    #!/bin/bash
    systemctl start httpd
  EOF
  
  tags = {
    Name = "packer-built-web-server"
  }
}
```

**💡 Packer + Terraform Workflow:**
1. **🔨 Packer**: Build and configure golden images
2. **🚀 Terraform**: Deploy infrastructure using those images
3. **⚡ Result**: Faster deployments, consistent environments

---

#### 📚 Certification Context

**⚠️ Important for HashiCorp Terraform Associate Certification:**

According to the current certification guide, **provisioners are no longer heavily emphasized** in the exam. The focus has shifted to:

**✅ Recommended Approaches:**
- **Cloud-Init/User Data** for instance initialization
- **Packer** for pre-built images
- **Configuration Management** tools (Ansible, Chef, Puppet)
- **Terraform modules** for reusable infrastructure patterns

**📖 What You Still Need to Know:**
- Basic understanding of provisioner types (`local-exec`, `remote-exec`, `file`)
- Connection blocks for SSH/WinRM
- When provisioners are appropriate (rare cases)
- Why alternatives are preferred

**🎯 Exam Focus Areas:**
- Infrastructure as Code principles
- Provider configuration and usage
- State management and workflows
- Terraform Cloud and Enterprise features

**💡 Study Tip**: While provisioners are still covered in training materials, spend more time mastering state management, providers, and Terraform Cloud features for exam success!

---

## ✅ Module 4 Summary

### 🎯 Key Takeaways
- **🔧 Provisioners** are used as a last resort for post-creation configuration
- **💻 Local-exec** runs commands on your local machine
- **🌐 Remote-exec** runs commands on the target resource
- **📁 File provisioner** copies files from local to remote resources
- **🔗 Connection blocks** define how to connect to remote resources
- **🚀 terraform_data** is the modern replacement for null_resource
- **☁️ Cloud-Init** is often a better alternative to provisioners

### 🔑 Essential Concepts Learned
- Provisioner types and when to use each
- Connection configuration for SSH and WinRM
- File copying and template rendering
- Trigger-based resource recreation
- Best practices and alternatives

### 💡 Pro Tips Recap
- Use provisioners sparingly - prefer Cloud-Init or user data
- Always include proper error handling and timeouts
- Use terraform_data instead of null_resource for new projects
- Consider configuration management tools for complex setups
- Test provisioners thoroughly in development environments

---

## 🧠 Knowledge Check: Module 4 Quiz

Test your understanding of Terraform Provisioners with these questions:

### 📝 Quiz Questions

**1. Which provisioner runs commands on your local machine where Terraform is executed?**
- A) remote-exec
- B) local-exec  
- C) file
- D) cloud-init

**2. What is the modern replacement for the deprecated null_resource?**
- A) data_resource
- B) terraform_data
- C) null_data
- D) local_resource

**3. Which connection type is used for Windows instances?**
- A) ssh
- B) rdp
- C) winrm
- D) powershell

**4. According to HashiCorp best practices, when should provisioners be used?**
- A) For all infrastructure configuration
- B) As the primary method for software installation
- C) As a last resort when other options aren't available
- D) Only for local operations

**5. What is Cloud-Init?**
- A) A Terraform provisioner type
- B) An industry standard for cross-platform VM initialization
- C) A configuration management tool
- D) A local-exec command

**6. Which tool is recommended for building pre-configured machine images?**
- A) Ansible
- B) Cloud-Init
- C) Packer
- D) Puppet

**7. What happens when a provisioner fails during terraform apply?**
- A) Terraform continues with other resources
- B) The resource is marked as tainted and creation fails
- C) Terraform automatically retries the provisioner
- D) Only a warning is displayed

**8. Which provisioner argument allows you to run commands only when a resource is destroyed?**
- A) on_failure = destroy
- B) when = destroy
- C) lifecycle = destroy
- D) trigger = destroy

**9. In the current HashiCorp Terraform Associate certification, provisioners are:**
- A) The primary focus of the exam
- B) No longer heavily emphasized
- C) Required for all questions
- D) Only tested in advanced scenarios

**10. What is the recommended approach for instance initialization instead of provisioners?**
- A) Manual SSH configuration
- B) Cloud-Init with user data
- C) Remote desktop connections
- D) Configuration management only

<details>
<summary>🔍 Click for Answers</summary>

1. **B** - `local-exec` provisioner runs commands on your local machine where Terraform is executed
2. **B** - `terraform_data` is the modern replacement for the deprecated `null_resource`
3. **C** - `winrm` (Windows Remote Management) is used for connecting to Windows instances
4. **C** - HashiCorp recommends using provisioners as a last resort when other options aren't available
5. **B** - Cloud-Init is an industry standard for cross-platform cloud instance initialization
6. **C** - Packer is HashiCorp's tool for building pre-configured, immutable machine images
7. **B** - When a provisioner fails, the resource is marked as tainted and the creation fails
8. **B** - `when = destroy` allows provisioners to run only when a resource is being destroyed
9. **B** - In the current certification, provisioners are no longer heavily emphasized
10. **B** - Cloud-Init with user data is the recommended approach for instance initialization

</details>

---

**🎉 Congratulations!** You've completed Module 4 and now understand how to use Terraform provisioners effectively. You've learned when to use them, how to configure them, and what alternatives exist!

**➡️ Ready for Module 5?** Let me know when you'd like to continue with Terraform Providers - where we'll explore the plugin ecosystem that makes Terraform so powerful!

---

---

## 🔗 **Next Steps**

Ready to continue your Terraform journey? Proceed to the next module:

**➡️ [Module 6: Terraform Providers](./module_06_terraform_providers.md)**

Understand how providers work and manage different cloud platforms.

---
