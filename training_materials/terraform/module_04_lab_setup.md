# ⚡ Module 04: Terraform Basics - Lab Setup

*Duration: 3 hours | Labs: 4 | Difficulty: 🟢 Beginner*

---

## 🎯 Learning Objectives

By completing these lab setup instructions, you will be able to:

- ✅ Install and configure Terraform on your system
- ✅ Set up VS Code with HashiCorp Terraform extensions
- ✅ Configure Jamf Pro API client credentials
- ✅ Verify your development environment is ready for Terraform labs
- ✅ Create an organized workspace for hands-on exercises

---

## 🛠️ Required Software Installation

### 📋 Installation Checklist

Before starting the Module 04 labs, you must have the following software installed:

- [ ] **Terraform** (Latest version)
- [ ] **VS Code** with Terraform extensions
- [ ] **Jamf Pro API Client Credentials** (Client ID and Secret)
- [ ] **Git** for version control
- [ ] **curl/wget** for testing (usually pre-installed)

### 🔷 Step 1: Install Terraform

**Choose your operating system:**

#### 🍎 macOS Installation

```bash
# Option 1: Using Homebrew (Recommended)
brew tap hashicorp/tap
brew install hashicorp/tap/terraform

# Option 2: Using MacPorts
sudo port install terraform

# Verify installation
terraform --version
```

#### 🪟 Windows Installation

**Option 1: Using Chocolatey (Recommended)**
```powershell
# Install Chocolatey first if not installed
# Run as Administrator in PowerShell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# Install Terraform
choco install terraform

# Verify installation
terraform --version
```

**Option 2: Manual Installation**
1. Download Terraform from [https://www.terraform.io/downloads.html](https://www.terraform.io/downloads.html)
2. Extract the binary to a folder (e.g., `C:\terraform`)
3. Add the folder to your system PATH
4. Open new PowerShell window and run `terraform --version`

#### 🐧 Linux Installation (Ubuntu/Debian)

```bash
# Update package index
sudo apt-get update

# Install required packages
sudo apt-get install -y gnupg software-properties-common curl

# Add HashiCorp GPG key
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -

# Add HashiCorp repository
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

# Update and install Terraform
sudo apt-get update && sudo apt-get install terraform

# Verify installation
terraform --version
```

### 💻 Step 2: Install VS Code and Extensions

#### Install VS Code

**Download and install VS Code from:** [https://code.visualstudio.com/](https://code.visualstudio.com/)

#### Required VS Code Extensions

After installing VS Code, install these **required** extensions:

```bash
# Install extensions via command line
code --install-extension HashiCorp.terraform
code --install-extension ms-vscode.vscode-json
code --install-extension redhat.vscode-yaml
```

**Or install via VS Code GUI:**
1. Open VS Code
2. Click Extensions icon (Ctrl+Shift+X)
3. Search and install:
   - **HashiCorp Terraform** (Syntax highlighting, validation, formatting)
   - **JSON** (JSON file support)
   - **YAML** (YAML file support)

#### Optional but Recommended Extensions

```bash
# Enhanced development experience
code --install-extension GitHub.copilot                   # AI assistance
code --install-extension ms-vscode.powershell             # PowerShell support  
code --install-extension ms-vscode-remote.remote-ssh      # Remote development
code --install-extension eamodio.gitlens                  # Enhanced Git features
code --install-extension ms-python.python                 # Python support
```

### 🔐 Step 3: Setup Jamf Pro API Client Credentials

**Terraform for Jamf Pro requires API client credentials to authenticate with your Jamf Pro server.**

#### 📋 Prerequisites

- Access to a Jamf Pro server (version 10.49.0 or later)
- Administrator privileges to create API roles and clients
- Your Jamf Pro server URL (e.g., `https://your-jamf-server.jamfcloud.com`)

#### 🔧 Create API Role in Jamf Pro

1. **Login to Jamf Pro** as an administrator
2. Navigate to **Settings** → **System** → **API Roles and Clients**
3. Click **+ New** to create a new API Role
4. **Configure the API Role:**
   - **Display Name**: `Terraform Management Role`
   - **Privileges**: Select the required API endpoints for your Terraform configurations
   - **Recommended minimum privileges** for basic operations:
     - `Read Categories`
     - `Create Categories` 
     - `Update Categories`
     - `Delete Categories`
     - `Read Policies`
     - `Create Policies`
     - `Update Policies`
     - `Delete Policies`
     - `Read Computer Groups`
     - `Create Computer Groups`
     - `Update Computer Groups`
     - `Delete Computer Groups`

💡 **Pro Tip**: Start with minimal permissions and add more as needed for your specific Terraform configurations.

#### 🔑 Create API Client in Jamf Pro

1. In **API Roles and Clients**, click the **API Clients** tab
2. Click **+ New** to create a new API Client
3. **Configure the API Client:**
   - **Display Name**: `Terraform Client`
   - **Access Token Lifetime**: `30 minutes` (recommended)
   - **API Roles**: Assign the `Terraform Management Role` created above
4. **Click Create**
5. **Important**: Copy and securely store the **Client ID** and **Client Secret** - you cannot retrieve the secret again

#### 🔒 Secure Storage of Credentials

**Create environment variables for your credentials:**

**macOS/Linux:**
```bash
# Add to your ~/.bashrc, ~/.zshrc, or ~/.profile
export JAMF_PRO_URL="https://your-jamf-server.jamfcloud.com"
export JAMF_PRO_CLIENT_ID="your-client-id-here"
export JAMF_PRO_CLIENT_SECRET="your-client-secret-here"

# Reload your shell configuration
source ~/.bashrc  # or ~/.zshrc
```

**Windows (PowerShell):**
```powershell
# Set environment variables for current session
$env:JAMF_PRO_URL = "https://your-jamf-server.jamfcloud.com"
$env:JAMF_PRO_CLIENT_ID = "your-client-id-here"
$env:JAMF_PRO_CLIENT_SECRET = "your-client-secret-here"

# Or set permanently using System Properties > Environment Variables
# Or add to your PowerShell profile
```

#### ✅ Test API Access

**Verify your credentials work by getting an access token:**

```bash
# Test API authentication (replace with your actual server URL)
curl -X POST "https://your-jamf-server.jamfcloud.com/api/oauth/token" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "client_id=${JAMF_PRO_CLIENT_ID}" \
  -d "grant_type=client_credentials" \
  -d "client_secret=${JAMF_PRO_CLIENT_SECRET}"
```

**Expected successful response:**
```json
{
  "access_token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9...",
  "token_type": "Bearer",
  "expires_in": 1800
}
```

#### 🔄 Credential Management Best Practices

- **Never commit credentials** to version control
- **Use environment variables** instead of hardcoding values
- **Rotate client secrets** regularly
- **Use minimum required privileges** for API roles
- **Monitor API usage** in Jamf Pro logs

### 🔧 Step 4: Install Additional Tools

#### Git Installation

**macOS:**
```bash
# Git is usually pre-installed, but you can update it
brew install git
```

**Windows:**
```powershell
# Download from https://git-scm.com/download/win
# Or use Chocolatey
choco install git
```

**Linux:**
```bash
sudo apt-get install git
```

#### JSON Processor (jq) - Optional but Helpful

**macOS:**
```bash
brew install jq
```

**Windows:**
```powershell
choco install jq
```

**Linux:**
```bash
sudo apt-get install jq
```

---

## ✅ Environment Verification

### 🔍 Step 5: Verify Your Installation

Run these commands to verify everything is installed correctly:

```bash
# Verify Terraform
terraform --version
# Expected: Terraform v1.x.x or later

# Verify VS Code (should open VS Code)
code --version

# Verify Git
git --version

# Verify Jamf Pro credentials are set
echo $JAMF_PRO_URL
echo $JAMF_PRO_CLIENT_ID
# Note: Don't echo the client secret for security

# Verify optional tools
jq --version           # JSON processor
curl --version         # HTTP client (usually pre-installed)
```

### 🎯 Expected Output Examples

```bash
$ terraform --version
Terraform v1.6.0
on darwin_amd64

$ echo $JAMF_PRO_URL
https://your-jamf-server.jamfcloud.com

$ echo $JAMF_PRO_CLIENT_ID
12345678-abcd-1234-efgh-123456789012

$ code --version
1.84.0
97dec172d3256f8ca4bfb2143f3f76b503ca0534
x64
```

---

## 📂 Step 6: Create Lab Workspace

### 🔧 Configure VS Code for Terraform

1. **Open your workspace in VS Code:**
```bash
cd ~/terraform-labs/module-04
code .
```

2. **Configure Terraform settings in VS Code:**
   - Open VS Code Settings (Ctrl+,)
   - Search for "terraform"
   - Enable these settings:
     - ✅ `Terraform: Validate on save`
     - ✅ `Terraform: Format on save`
     - ✅ `Terraform: Language server`

3. **Create a VS Code workspace file (optional):**
```bash
# In ~/terraform-labs/module-04/
cat > terraform-labs.code-workspace << EOF
{
  "folders": [
    {
      "path": "."
    }
  ],
  "settings": {
    "terraform.experimentalFeatures.validateOnSave": true,
    "terraform.experimentalFeatures.prefillRequiredFields": true,
    "[terraform]": {
      "editor.formatOnSave": true,
      "editor.formatOnSaveMode": "file"
    }
  }
}
EOF
```

---

## 🧪 Step 7: Test Your Setup

### Create a Simple Test Configuration

Let's verify everything works with a minimal Terraform configuration:

```bash
# Navigate to test directory
cd ~/terraform-labs/module-04/lab1-first-config

# Create a simple test file for Jamf Pro
cat > test.tf << 'EOF'
terraform {
  required_version = ">= 1.0"
  
  required_providers {
    jamfpro = {
      source  = "deploymenttheory/jamfpro"
      version = "~> 0.0.50"
    }
  }
}

# Configure the Jamf Pro provider
provider "jamfpro" {
  jamfpro_url         = var.jamfpro_url
  client_id           = var.client_id
  client_secret       = var.client_secret
}

# Variables for configuration
variable "jamfpro_url" {
  description = "Jamf Pro server URL"
  type        = string
  default     = ""
}

variable "client_id" {
  description = "Jamf Pro API client ID"
  type        = string
  default     = ""
  sensitive   = true
}

variable "client_secret" {
  description = "Jamf Pro API client secret"
  type        = string
  default     = ""
  sensitive   = true
}

# Create a test category
resource "jamfpro_category" "test" {
  name     = "Terraform Test Category"
  priority = 10
}

output "category_info" {
  value = {
    name = jamfpro_category.test.name
    id   = jamfpro_category.test.id
  }
}
EOF
```

### Test Terraform Workflow

```bash
# Initialize Terraform (downloads providers)
terraform init

# Validate configuration
terraform validate

# Format the configuration
terraform fmt

# Create execution plan
terraform plan

# Apply the configuration with your Jamf Pro credentials
terraform apply \
  -var="jamfpro_url=$JAMF_PRO_URL" \
  -var="client_id=$JAMF_PRO_CLIENT_ID" \
  -var="client_secret=$JAMF_PRO_CLIENT_SECRET" \
  -auto-approve

# View outputs
terraform output

# Clean up - destroy the test category
terraform destroy \
  -var="jamfpro_url=$JAMF_PRO_URL" \
  -var="client_id=$JAMF_PRO_CLIENT_ID" \
  -var="client_secret=$JAMF_PRO_CLIENT_SECRET" \
  -auto-approve
```

**Expected workflow success indicates your environment is ready!**

---

## 🎯 Lab Setup Success Criteria

### ✅ Checklist: Verify You Can...

- [ ] **Run `terraform --version`** and see version 1.x.x or later
- [ ] **Run `terraform init`** in a directory with a .tf file
- [ ] **Open VS Code** and see Terraform syntax highlighting in .tf files
- [ ] **Verify Jamf Pro credentials** are set in environment variables
- [ ] **Execute the test workflow** above without errors
- [ ] **Navigate between lab directories** you created
- [ ] **Format Terraform code** using `terraform fmt`
- [ ] **Validate Terraform code** using `terraform validate`

### 🚨 Troubleshooting Common Issues

**Problem**: "terraform: command not found"
- **Solution**: Ensure Terraform is in your system PATH, restart terminal

**Problem**: VS Code doesn't highlight .tf files
- **Solution**: Install HashiCorp Terraform extension, restart VS Code

**Problem**: Jamf Pro API authentication fails
- **Solution**: Verify your client credentials and server URL are correct, test with curl command

**Problem**: Permission denied errors
- **Solution**: Check Jamf Pro API role permissions and ensure user has admin access

**Problem**: Provider download fails
- **Solution**: Check internet connection and firewall settings

---

## 🚀 Next Steps

Once you've completed this setup successfully, you're ready to begin the Module 04 hands-on labs:

1. **[Lab 1]**: First Terraform Configuration (30 min)
2. **[Lab 2]**: Working with Variables and Outputs (45 min)  
3. **[Lab 3]**: Resource Dependencies and State (45 min)
4. **[Lab 4]**: Complete Infrastructure Lifecycle (60 min)

**💡 Pro Tip**: Keep this setup guide handy - you might need to refer back to it if you encounter environment issues during the labs!

**🎉 Congratulations!** Your Terraform development environment is now ready for hands-on learning!