# ⚡ Module 04: Terraform Basics - Lab Setup

*Duration: 3 hours | Labs: 4 | Difficulty: 🟢 Beginner*

---

## 🎯 Learning Objectives

By completing these lab setup instructions, you will be able to:

- ✅ Install and configure Terraform on your system
- ✅ Set up VS Code with HashiCorp Terraform extensions
- ✅ Configure cloud provider CLI tools (AWS/Azure/GCP)
- ✅ Verify your development environment is ready for Terraform labs
- ✅ Create an organized workspace for hands-on exercises

---

## 🛠️ Required Software Installation

### 📋 Installation Checklist

Before starting the Module 04 labs, you must have the following software installed:

- [ ] **Terraform** (Latest version)
- [ ] **VS Code** with Terraform extensions
- [ ] **Cloud Provider CLI** (AWS CLI, Azure CLI, or GCP SDK)
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

### ☁️ Step 3: Install Cloud Provider CLI

**You need at least ONE of the following cloud CLIs:**

#### 🟠 AWS CLI v2 Installation

**macOS:**
```bash
curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
sudo installer -pkg AWSCLIV2.pkg -target /
```

**Windows:**
```powershell
# Download and run the MSI installer from:
# https://awscli.amazonaws.com/AWSCLIV2.msi
```

**Linux:**
```bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
```

**Verify AWS CLI:**
```bash
aws --version
```

**Configure AWS CLI:**
```bash
aws configure
# You'll need:
# - AWS Access Key ID
# - AWS Secret Access Key  
# - Default region (e.g., us-west-2)
# - Output format (json recommended)
```

#### 🔵 Azure CLI Installation

**macOS:**
```bash
brew install azure-cli
```

**Windows:**
```powershell
# Download and run the MSI installer from:
# https://aka.ms/installazurecliwindows
```

**Linux:**
```bash
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
```

**Verify Azure CLI:**
```bash
az --version
```

**Login to Azure:**
```bash
az login
```

#### 🟡 Google Cloud SDK Installation

**macOS:**
```bash
# Option 1: Using Homebrew
brew install --cask google-cloud-sdk

# Option 2: Manual installation
curl https://sdk.cloud.google.com | bash
exec -l $SHELL
```

**Windows:**
```powershell
# Download and run the installer from:
# https://dl.google.com/dl/cloudsdk/channels/rapid/GoogleCloudSDKInstaller.exe
```

**Linux:**
```bash
# Add Google Cloud SDK repository
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

# Import Google Cloud public key
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -

# Update and install
sudo apt-get update && sudo apt-get install google-cloud-cli
```

**Verify Google Cloud SDK:**
```bash
gcloud --version
```

**Initialize Google Cloud SDK:**
```bash
gcloud init
```

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

# Verify cloud CLI (choose the one you installed)
aws --version          # AWS CLI
az --version           # Azure CLI
gcloud --version       # Google Cloud SDK

# Verify optional tools
jq --version           # JSON processor
curl --version         # HTTP client (usually pre-installed)
```

### 🎯 Expected Output Examples

```bash
$ terraform --version
Terraform v1.6.0
on darwin_amd64

$ aws --version  
aws-cli/2.13.25 Python/3.11.5 Darwin/23.1.0 source/x86_64 prompt/off

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

# Create a simple test file
cat > test.tf << 'EOF'
terraform {
  required_version = ">= 1.0"
  
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

resource "random_integer" "test" {
  min = 1
  max = 100
}

output "random_number" {
  value = random_integer.test.result
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

# Apply the configuration (creates the random number)
terraform apply -auto-approve

# View outputs
terraform output

# Clean up
terraform destroy -auto-approve
```

**Expected workflow success indicates your environment is ready!**

---

## 🎯 Lab Setup Success Criteria

### ✅ Checklist: Verify You Can...

- [ ] **Run `terraform --version`** and see version 1.x.x or later
- [ ] **Run `terraform init`** in a directory with a .tf file
- [ ] **Open VS Code** and see Terraform syntax highlighting in .tf files
- [ ] **Run cloud CLI commands** (aws/az/gcloud --version)
- [ ] **Execute the test workflow** above without errors
- [ ] **Navigate between lab directories** you created
- [ ] **Format Terraform code** using `terraform fmt`
- [ ] **Validate Terraform code** using `terraform validate`

### 🚨 Troubleshooting Common Issues

**Problem**: "terraform: command not found"
- **Solution**: Ensure Terraform is in your system PATH, restart terminal

**Problem**: VS Code doesn't highlight .tf files
- **Solution**: Install HashiCorp Terraform extension, restart VS Code

**Problem**: Cloud CLI authentication fails
- **Solution**: Run `aws configure`, `az login`, or `gcloud auth login`

**Problem**: Permission denied errors
- **Solution**: Check cloud account permissions and credentials

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