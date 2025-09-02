

# 📁 Module 11: Terraform State

**⏱️ Duration**: 45 minutes  
**🎯 Difficulty**: Intermediate  
**📋 Prerequisites**: Completed Modules 1-9

## 🎯 Learning Objectives

By the end of this module, you will be able to:

- ✅ **Understand Terraform state** and its critical role in infrastructure management
- ✅ **Manage state files** with commands like `state mv`, `state rm`, and `state show`
- ✅ **Work with state backups** and recovery mechanisms
- ✅ **Use state CLI commands** effectively for troubleshooting and management
- ✅ **Implement state best practices** for team collaboration and security
- ✅ **Handle state conflicts** and corruption scenarios

---

## 📚 What is Terraform State?

**Terraform state** is a **JSON file** that maps your Terraform configuration to the real-world resources it manages. It's the **source of truth** that tracks resource metadata, dependencies, and current status.

**🔍 Key State Concepts:**
- **🗂️ State File** - JSON database of managed resources
- **🔄 State Tracking** - Maps configuration to real infrastructure  
- **📊 Resource Metadata** - Stores attributes, dependencies, and status
- **🔒 State Locking** - Prevents concurrent modifications
- **💾 State Backends** - Local vs remote state storage

```hcl
# Example: How Terraform tracks resources in state
resource "aws_instance" "web" {
  ami           = "ami-12345"
  instance_type = "t3.micro"
  
  tags = {
    Name = "web-server"
  }
}

# After apply, state file contains:
# {
#   "resources": [
#     {
#       "type": "aws_instance",
#       "name": "web",
#       "provider": "provider.aws",
#       "instances": [
#         {
#           "attributes": {
#             "id": "i-1234567890abcdef0",
#             "ami": "ami-12345",
#             "instance_type": "t3.micro",
#             "public_ip": "54.123.45.67",
#             ...
#           }
#         }
#       ]
#     }
#   ]
# }
```

### 🎯 Why State is Critical

**📊 Resource Tracking:**
- Maps configuration names to real resource IDs
- Tracks resource dependencies and relationships
- Stores sensitive data like passwords and keys
- Enables performance optimization through caching

**🔄 Change Detection:**
- Compares current state vs desired configuration
- Identifies what needs to be created, updated, or destroyed
- Prevents duplicate resource creation
- Enables drift detection and correction

**⚡ Performance Benefits:**
- Caches resource attributes to avoid API calls
- Enables parallel operations through dependency graph
- Reduces plan/apply time for large infrastructures
- Supports incremental updates

---

## 🛠️ State Management Commands

Terraform provides powerful CLI commands for state inspection and manipulation.

### 📋 terraform state list

List all resources in the state file.

```bash
# List all resources
terraform state list

# Output example:
aws_vpc.main
aws_internet_gateway.main
aws_subnet.public[0]
aws_subnet.public[1]
aws_subnet.private[0]
aws_subnet.private[1]
aws_security_group.web
aws_instance.web[0]
aws_instance.web[1]

# Filter resources by type
terraform state list aws_instance

# Filter with patterns
terraform state list 'aws_subnet.*'
```

### 🔍 terraform state show

Show detailed information about a specific resource.

```bash
# Show specific resource
terraform state show aws_instance.web[0]

# Output example:
# aws_instance.web[0]:
resource "aws_instance" "web" {
    ami                                  = "ami-12345"
    arn                                  = "arn:aws:ec2:us-west-2:123456789:instance/i-1234567890"
    associate_public_ip_address          = true
    availability_zone                    = "us-west-2a"
    cpu_core_count                       = 1
    cpu_threads_per_core                 = 1
    disable_api_stop                     = false
    disable_api_termination              = false
    ebs_optimized                        = false
    get_password_data                    = false
    hibernation                          = false
    id                                   = "i-1234567890"
    instance_initiated_shutdown_behavior = "stop"
    instance_state                       = "running"
    instance_type                        = "t3.micro"
    # ... more attributes
}

# Show with JSON output
terraform state show -json aws_instance.web[0] | jq
```

### 🔄 terraform state mv

Move resources within state or rename them.

```bash
# Rename a resource
terraform state mv aws_instance.web aws_instance.web_server

# Move resource to different module
terraform state mv aws_instance.web module.web.aws_instance.server

# Move entire module
terraform state mv module.web module.web_servers

# Move resources with count/for_each
terraform state mv 'aws_instance.web[0]' 'aws_instance.web_servers[0]'
terraform state mv 'aws_instance.web["primary"]' 'aws_instance.web_servers["primary"]'

# Bulk move with patterns
for i in {0..2}; do
  terraform state mv "aws_instance.web[$i]" "aws_instance.web_servers[$i]"
done
```

### ❌ terraform state rm

Remove resources from state without destroying them.

```bash
# Remove single resource
terraform state rm aws_instance.web[0]

# Remove multiple resources
terraform state rm aws_instance.web[0] aws_instance.web[1]

# Remove all instances of a resource
terraform state rm 'aws_instance.web'

# Remove entire module
terraform state rm module.web

# Remove with confirmation
terraform state rm -dry-run aws_instance.web[0]  # Preview only
terraform state rm aws_instance.web[0]           # Actually remove
```

**⚠️ Important Notes:**
- Resources removed from state still exist in your infrastructure
- Use this when you want to stop managing a resource with Terraform
- The resource won't be destroyed by `terraform destroy`
- You can re-import the resource later if needed

---

## 💾 State Backups and Recovery

Terraform automatically creates backups to protect against state corruption and accidental changes.

### 🔄 Automatic Backups

```bash
# Terraform creates backups automatically
ls -la terraform.tfstate*
# terraform.tfstate         <- Current state
# terraform.tfstate.backup  <- Previous state

# View backup contents
terraform state show -state=terraform.tfstate.backup aws_instance.web
```

### 📁 Manual Backup Management

```bash
# Create manual backup before risky operations
cp terraform.tfstate terraform.tfstate.$(date +%Y%m%d-%H%M%S)

# Or use terraform command
terraform state pull > backup-$(date +%Y%m%d-%H%M%S).tfstate

# Restore from backup
cp terraform.tfstate.backup terraform.tfstate

# Or push specific backup
terraform state push backup-20231201-143000.tfstate
```

### 🔒 Remote State Management

When using remote backends, state management requires different approaches and considerations.

#### 🌐 Remote State Backends

```hcl
# S3 backend with versioning for backups
terraform {
  backend "s3" {
    bucket         = "my-terraform-state"
    key            = "prod/terraform.tfstate"
    region         = "us-west-2"
    versioning     = true  # Enable versioning for backups
    
    # State locking
    dynamodb_table = "terraform-state-lock"
    
    # Encryption
    encrypt = true
    kms_key_id = "arn:aws:kms:us-west-2:123456789:key/12345678-1234-1234-1234-123456789012"
  }
}

# Azure backend
terraform {
  backend "azurerm" {
    resource_group_name  = "terraform-rg"
    storage_account_name = "terraformstate"
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"
    
    # Optional: Access key or use Azure CLI/MSI
    access_key = var.storage_access_key
  }
}

# Terraform Cloud backend
terraform {
  backend "remote" {
    organization = "my-organization"
    
    workspaces {
      name = "production-infrastructure"
    }
  }
}

# Google Cloud Storage backend
terraform {
  backend "gcs" {
    bucket = "my-terraform-state"
    prefix = "terraform/state"
    
    # Optional: Credentials
    credentials = "path/to/service-account-key.json"
  }
}
```

#### 🔧 Remote State Operations

**📊 State Inspection with Remote Backends:**
```bash
# Pull remote state to local file for inspection
terraform state pull > remote-state.json

# View remote state structure
terraform state pull | jq '.resources[].type' | sort | uniq -c

# Show specific resource from remote state
terraform state show aws_instance.web[0]

# List all resources in remote state
terraform state list
```

**🔄 Remote State Movement Operations:**
```bash
# State mv works the same with remote backends
terraform state mv aws_instance.web[0] aws_instance.primary

# However, operations require state locking
# If lock fails, you may see:
# Error: Error acquiring the state lock
# Lock Info:
#   ID:        12345678-1234-1234-1234-123456789012
#   Path:      my-terraform-state/prod/terraform.tfstate
#   Operation: OperationTypeApply
#   Who:       user@hostname
#   Version:   1.6.0
#   Created:   2023-12-01 14:30:00.123456789 +0000 UTC
#   Info:      

# Force unlock if necessary (use with caution!)
terraform force-unlock 12345678-1234-1234-1234-123456789012
```

**🔒 Remote State Security Considerations:**
```bash
# Encrypt state at rest (S3 example)
aws s3api put-bucket-encryption \
  --bucket my-terraform-state \
  --server-side-encryption-configuration '{
    "Rules": [{
      "ApplyServerSideEncryptionByDefault": {
        "SSEAlgorithm": "aws:kms",
        "KMSMasterKeyID": "arn:aws:kms:us-west-2:123456789:key/12345678-1234-1234-1234-123456789012"
      }
    }]
  }'

# Enable versioning for recovery
aws s3api put-bucket-versioning \
  --bucket my-terraform-state \
  --versioning-configuration Status=Enabled

# Set up access logging
aws s3api put-bucket-logging \
  --bucket my-terraform-state \
  --bucket-logging-status file://logging.json
```

#### ⚠️ Remote State Limitations

**🚫 Operations Not Available with Terraform Cloud:**
```bash
# These operations are LIMITED or UNAVAILABLE with Terraform Cloud:

# ❌ terraform state pull (limited access)
terraform state pull  # May not work or require special permissions

# ❌ terraform state push (not allowed)
terraform state push terraform.tfstate  # Error: not supported

# ❌ Direct state file manipulation
# Cannot directly edit state files in Terraform Cloud

# ❌ Manual state recovery
# Must use Terraform Cloud UI or API for state management
```

**✅ Available Remote State Operations:**
```bash
# ✅ These operations work with all remote backends:
terraform state list
terraform state show aws_instance.web[0]
terraform state mv aws_instance.web[0] aws_instance.primary
terraform state rm aws_instance.web[0]
terraform import aws_instance.web i-1234567890abcdef0

# ✅ Terraform Cloud specific operations:
# Use Terraform Cloud UI for:
# - State version history
# - State rollback
# - State download (via UI)
# - Workspace settings
```

#### 🔄 Remote State Recovery Strategies

**📁 S3 Backend Recovery:**
```bash
# List state versions
aws s3api list-object-versions \
  --bucket my-terraform-state \
  --prefix prod/terraform.tfstate

# Download specific version
aws s3api get-object \
  --bucket my-terraform-state \
  --key prod/terraform.tfstate \
  --version-id "version-id-here" \
  terraform.tfstate.recovered

# Restore to current (if using local state temporarily)
terraform state push terraform.tfstate.recovered

# Or copy back to S3 as current version
aws s3 cp terraform.tfstate.recovered \
  s3://my-terraform-state/prod/terraform.tfstate
```

**🔧 Azure Backend Recovery:**
```bash
# List blob versions (if versioning enabled)
az storage blob list \
  --container-name tfstate \
  --account-name terraformstate \
  --include snapshots

# Download specific version
az storage blob download \
  --container-name tfstate \
  --name prod.terraform.tfstate \
  --file terraform.tfstate.recovered \
  --account-name terraformstate
```

**☁️ Terraform Cloud Recovery:**
```bash
# Use Terraform Cloud API
curl \
  --header "Authorization: Bearer $TF_CLOUD_TOKEN" \
  --header "Content-Type: application/vnd.api+json" \
  "https://app.terraform.io/api/v2/workspaces/$WORKSPACE_ID/state-versions"

# Download specific state version via API
curl \
  --header "Authorization: Bearer $TF_CLOUD_TOKEN" \
  "https://app.terraform.io/api/v2/state-versions/$STATE_VERSION_ID/download" \
  --output terraform.tfstate.recovered
```

#### 🎯 Remote State Best Practices

**🔐 Security Best Practices:**
- **Encryption**: Always encrypt state at rest and in transit
- **Access Control**: Use IAM/RBAC to limit state access
- **Audit Logging**: Enable access logging for compliance
- **Network Security**: Use VPC endpoints or private networks when possible

**🔄 Operational Best Practices:**
- **State Locking**: Always use state locking for team environments
- **Versioning**: Enable versioning for recovery capabilities
- **Backup Strategy**: Regular automated backups to separate locations
- **Monitoring**: Alert on state lock timeouts and access patterns

**👥 Team Collaboration:**
- **Shared Backend**: Use centralized remote backend for all team members
- **Consistent Configuration**: Standardize backend configuration across projects
- **Access Management**: Implement proper role-based access controls
- **Change Management**: Use proper workflows for state modifications

---

## 💻 **Exercise 10.1**: State Management Hands-On
**Duration**: 25 minutes

⚠️ **Important Note**: This exercise assumes **local state** or **reachable remote state** (like S3/Azure backends). Many of these operations **will NOT work** with **Terraform Cloud** remote backend due to security restrictions. For Terraform Cloud users, use the UI for state management operations.

Let's practice essential state management operations.

**Step 1: Create Infrastructure**
```bash
mkdir terraform-state-demo
cd terraform-state-demo

cat > main.tf << EOF
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = { Name = "state-demo-vpc" }
}

resource "aws_instance" "web" {
  count         = 2
  ami           = "ami-12345"  # Update with valid AMI
  instance_type = "t2.micro"
  
  tags = {
    Name = "web-\${count.index + 1}"
  }
}
EOF

terraform init
terraform apply
```

**Step 2: Practice State Commands**
```bash
# List all resources
terraform state list

# Show specific resource
terraform state show aws_instance.web[0]

# Create backup
terraform state pull > backup.tfstate

# Rename resource
terraform state mv aws_instance.web[0] aws_instance.primary

# Remove from state
terraform state rm aws_instance.web[1]

# View changes
terraform plan
```

**Step 3: Recovery Operations**
```bash
# Restore backup if needed (LOCAL STATE ONLY)
terraform state push backup.tfstate

# Re-import removed resource (works with all backends)
terraform import 'aws_instance.web[1]' i-1234567890abcdef0

# Clean up
terraform destroy
```

**Step 4: Remote State Considerations**
```bash
# If using S3 backend, these operations work:
terraform state list                    # ✅ Works
terraform state show aws_instance.web[0] # ✅ Works  
terraform state mv aws_instance.web[0] aws_instance.primary # ✅ Works
terraform state rm aws_instance.web[1]  # ✅ Works
terraform import aws_instance.web i-123 # ✅ Works

# These operations have limitations:
terraform state pull > backup.tfstate   # ✅ S3/Azure, ❌ Terraform Cloud
terraform state push backup.tfstate     # ✅ S3/Azure, ❌ Terraform Cloud

# For Terraform Cloud users:
# - Use the web UI for state history and rollback
# - Use API calls for advanced state operations
# - State pull/push operations are restricted for security
```

💡 **Pro Tip**: Always backup state before risky operations. For remote backends, use versioning (S3) or the platform's built-in state history (Terraform Cloud)!

---

## ✅ Module 10 Summary

**🎯 Learning Objectives Achieved:**
- ✅ Understood **Terraform state** and its critical role in infrastructure tracking
- ✅ Mastered **state commands** including `list`, `show`, `mv`, `rm`, and `pull/push`
- ✅ Implemented **state backup** strategies and recovery procedures
- ✅ Applied **state CLI commands** for troubleshooting and management
- ✅ Learned **state best practices** for team collaboration and security
- ✅ Handled **state conflicts** and corruption recovery scenarios

**🔑 Key Concepts Covered:**
- **State File Structure**: JSON format, resources, metadata, dependencies
- **State Commands**: Inspection, manipulation, and recovery operations
- **State Backups**: Automatic and manual backup strategies
- **State Security**: Remote backends, encryption, and access control
- **State Operations**: Import, export, move, and remove procedures

**💼 Professional Skills Developed:**
- **State Management**: Effective state file administration and maintenance
- **Troubleshooting**: Diagnosing and resolving state-related issues
- **Disaster Recovery**: Backup and restoration procedures for state files
- **Team Collaboration**: Shared state management best practices
- **Security Implementation**: State encryption and access control

**➡️ Next Steps**: Ready to explore **Terraform Initialization** where you'll master `terraform init`, provider installation, and project setup!

---

---

## 🔗 **Next Steps**

Ready to continue your Terraform journey? Proceed to the next module:

**➡️ [Module 28: TF Initialization](./module_11_tf_initialization.md)**

Learn the terraform init process and dependency management.

---
