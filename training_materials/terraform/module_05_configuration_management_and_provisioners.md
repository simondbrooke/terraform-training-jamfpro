
---

## 🛠️ Module 5: Configuration Management and Provisioners
*Duration: 3 hours | Labs: 5 | Difficulty: 🟡 Intermediate*

### 🎯 Learning Objectives
By the end of this module, you will be able to:
- ✅ **Implement Cloud-Init for reliable instance initialization**
- ✅ **Use Packer to build pre-configured machine images**  
- ✅ **Understand modern approaches to infrastructure configuration**
- ✅ Work with terraform_data resources for advanced workflows
- ✅ Identify when configuration management tools are appropriate
- ✅ Understand Terraform provisioners and their limitations
- ✅ Know when provisioners are still appropriate (edge cases)
- ✅ Configure provisioners only when modern approaches aren't suitable

### 📚 Topics Covered

## ⚡ Modern Infrastructure Configuration Approaches

**🎯 The Modern Way**: Instead of configuring resources after creation, modern infrastructure follows **immutable infrastructure** principles:

1. **☁️ Cloud-Init**: Built-in VM initialization (recommended for most cases)
2. **📦 Packer**: Pre-built golden images with software already installed  
3. **🔧 Configuration Management**: Dedicated tools for complex configuration
4. **📋 User Data**: Cloud-provider native initialization scripts

**⚠️ Why Avoid Provisioners?**
- **🐌 Slower**: Network-dependent, runs after resource creation
- **❌ Less Reliable**: Connection failures, timing issues
- **🔄 Not Idempotent**: May fail on re-runs
- **🤝 Coupling**: Creates tight coupling between infrastructure and configuration
- **🔐 Security**: Requires SSH/WinRM access and credentials

**✅ When Modern Approaches Are Better:**
- **📦 Software Installation**: Use pre-built images (Packer) or Cloud-Init
- **⚙️ Service Configuration**: Use Cloud-Init YAML or config management tools
- **📁 File Management**: Bake files into images or use Cloud-Init write_files
- **🔄 Service Management**: Use Cloud-Init runcmd or systemd units
- **🏗️ Initial Setup**: Always prefer Cloud-Init over provisioners

---

## ☁️ Cloud-Init: The Recommended Approach

**Cloud-Init** is an industry standard for cross-platform cloud instance initialization. It's the **first choice** for most instance setup tasks.

**🎯 Why Cloud-Init is Superior:**
- **🚀 Faster**: Runs during instance boot, no network setup delay
- **🔒 More Secure**: No SSH/WinRM credentials needed
- **✅ More Reliable**: Built into cloud images, handles retries automatically
- **🔄 Idempotent**: Safe to run multiple times
- **📱 Standardized**: Works across all major cloud providers
- **🔧 Feature-Rich**: Package management, file creation, user management, service control

**📝 Basic Cloud-Init with User Data:**
```hcl
# Modern approach - Cloud-Init handles everything
resource "aws_instance" "web" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"
  
  # Cloud-Init configuration - runs on first boot
  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd git nodejs npm
    systemctl start httpd
    systemctl enable httpd
    
    # Create web content
    cat > /var/www/html/index.html <<HTML
    <h1>Modern Web Server</h1>
    <p>Configured with Cloud-Init - No provisioners needed!</p>
    <p>Instance ID: $(curl -s http://169.254.169.254/latest/meta-data/instance-id)</p>
    HTML
    
    # Download and setup application
    git clone https://github.com/company/web-app.git /opt/app
    cd /opt/app && npm install
    systemctl restart httpd
  EOF
  
  tags = {
    Name = "cloud-init-web-server"
  }
}
```

**🔧 Advanced Cloud-Init with YAML Configuration:**
```hcl
# Advanced Cloud-Init with structured YAML
locals {
  cloud_init_config = <<-EOF
    #cloud-config
    package_update: true
    package_upgrade: true
    
    packages:
      - httpd
      - git
      - nodejs
      - npm
      - docker
    
    # Create users
    users:
      - name: appuser
        groups: wheel,docker
        shell: /bin/bash
        sudo: ['ALL=(ALL) NOPASSWD:ALL']
    
    # Write configuration files
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
        owner: root:root
      
      - path: /opt/app/config.json
        content: |
          {
            "environment": "${var.environment}",
            "database_url": "${var.db_connection_string}",
            "log_level": "info"
          }
        permissions: '0640'
        owner: appuser:appuser
    
    # Run commands in order
    runcmd:
      - systemctl enable httpd docker
      - systemctl start httpd docker
      - usermod -aG docker appuser
      - git clone https://github.com/company/web-app.git /opt/app
      - chown -R appuser:appuser /opt/app
      - cd /opt/app && npm install --production
      - systemctl restart httpd
      - docker pull nginx:alpine
    
    # Final message
    final_message: "Server setup completed successfully with Cloud-Init!"
  EOF
}

resource "aws_instance" "web_advanced" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"
  
  # Base64 encode for complex YAML configurations
  user_data = base64encode(local.cloud_init_config)
  
  tags = {
    Name = "advanced-cloud-init-server"
  }
}
```

**💡 Cloud-Init Best Practices:**
- ✅ Use YAML format for complex configurations
- ✅ Leverage package management instead of manual installs
- ✅ Use write_files for configuration templates
- ✅ Set proper file permissions and ownership
- ✅ Use runcmd for ordered command execution
- ✅ Test configurations with cloud-init validate

---

## 📦 Packer: Pre-Built Golden Images

**Packer** is HashiCorp's tool for building immutable, pre-configured machine images. This is the **ultimate solution** for complex software stacks.

**🎯 Why Packer is Superior:**
- **⚡ Fastest Deployment**: Everything pre-installed, just boot and run
- **🏗️ Immutable Infrastructure**: Same image = same result every time
- **🔒 Security**: No runtime configuration = reduced attack surface  
- **📊 Consistency**: Identical environments across dev/stage/prod
- **🧪 Testable**: Test images before deployment
- **📦 Reusable**: One image, many instances

**📝 Basic Packer Template:**
```json
{
  "variables": {
    "aws_access_key": "{{env `AWS_ACCESS_KEY_ID`}}",
    "aws_secret_key": "{{env `AWS_SECRET_ACCESS_KEY`}}",
    "region": "us-west-2",
    "app_version": "{{env `APP_VERSION`}}"
  },
  
  "builders": [
    {
      "type": "amazon-ebs",
      "access_key": "{{user `aws_access_key`}}",
      "secret_key": "{{user `aws_secret_key`}}",
      "region": "{{user `region`}}",
      "source_ami": "ami-12345",
      "instance_type": "t2.micro",
      "ssh_username": "ec2-user",
      "ami_name": "web-app-{{user `app_version`}}-{{timestamp}}"
    }
  ],
  
  "provisioners": [
    {
      "type": "shell",
      "inline": [
        "sudo yum update -y",
        "sudo yum install -y httpd nodejs npm docker git",
        "sudo systemctl enable httpd docker"
      ]
    },
    {
      "type": "file",
      "source": "./app/",
      "destination": "/tmp/app/"
    },
    {
      "type": "shell",
      "inline": [
        "sudo mv /tmp/app /opt/",
        "sudo chown -R ec2-user:ec2-user /opt/app",
        "cd /opt/app && npm install --production",
        "sudo systemctl start httpd",
        "sudo docker pull nginx:alpine",
        "sudo systemctl stop httpd"
      ]
    }
  ],
  
  "post-processors": [
    {
      "type": "manifest",
      "output": "manifest.json"
    }
  ]
}
```

**🔄 Using Packer Images with Terraform:**
```hcl
# Data source to find latest Packer-built AMI
data "aws_ami" "web_app" {
  most_recent = true
  owners      = ["self"]
  
  filter {
    name   = "name"
    values = ["web-app-*"]
  }
  
  filter {
    name   = "state"
    values = ["available"]
  }
  
  # Optional: filter by tag
  filter {
    name   = "tag:Environment"
    values = [var.environment]
  }
}

# Deploy using pre-built image - minimal configuration needed
resource "aws_instance" "web" {
  ami           = data.aws_ami.web_app.id
  instance_type = "t2.micro"
  
  # Minimal user data - just environment-specific config
  user_data = <<-EOF
    #!/bin/bash
    # Everything is pre-installed, just configure environment
    sed -i 's/ENVIRONMENT_PLACEHOLDER/${var.environment}/g' /opt/app/config.json
    systemctl start httpd
    systemctl start docker
    
    # Optional: Pull latest application data
    cd /opt/app && git pull origin main
    systemctl reload httpd
  EOF
  
  tags = {
    Name = "packer-web-server"
    Version = data.aws_ami.web_app.tags["Version"]
  }
}
```

**💡 Packer + Terraform Workflow:**
1. **🔨 Build Phase**: Packer creates golden images with all software
2. **🚀 Deploy Phase**: Terraform deploys instances from those images  
3. **⚡ Result**: Fastest, most reliable deployments possible

**🛠️ Packer Best Practices:**
- ✅ Version your images with timestamps or git commits
- ✅ Test images before tagging as production-ready
- ✅ Use multiple builders for different environments
- ✅ Keep sensitive data in runtime configuration, not images
- ✅ Automate image building in CI/CD pipelines

---

## 🔧 When to Use Configuration Management Tools

For **complex, ongoing configuration management**, dedicated tools are often better than Terraform:

**🎯 Popular Configuration Management Tools:**
- **📘 Ansible**: Agentless, YAML-based, great for ad-hoc tasks
- **🐙 Chef**: Ruby-based, powerful, enterprise-focused
- **🎭 Puppet**: Declarative, strong compliance features
- **🧂 Salt**: Fast, scalable, event-driven

**✅ Use Configuration Management When:**
- Complex application deployments across many servers
- Ongoing configuration drift remediation
- Compliance and security policy enforcement  
- Multi-stage application rollouts
- Integration with existing CM infrastructure

**🔄 Terraform + Configuration Management Pattern:**
```hcl
# Terraform provisions infrastructure
resource "aws_instance" "app_servers" {
  count         = var.server_count
  ami           = data.aws_ami.base.id
  instance_type = "t3.medium"
  
  # Minimal Cloud-Init for CM tool bootstrap
  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    
    # Install Ansible
    amazon-linux-extras install ansible2 -y
    
    # Download and run playbook
    cd /tmp
    git clone https://github.com/company/ansible-playbooks.git
    ansible-playbook -i localhost, -c local playbooks/web-server.yml
  EOF
  
  tags = {
    Name = "app-server-${count.index + 1}"
    Role = "web-server"
  }
}
```

---

## 🚀 terraform_data Resource (Modern Approach)

The `terraform_data` resource is the **modern replacement** for the deprecated `null_resource`. Use it for advanced Terraform workflows.

**📝 Basic Usage for Triggers:**
```hcl
# Use terraform_data to trigger actions based on changes
resource "terraform_data" "app_deployment" {
  input = {
    app_version    = var.app_version
    config_hash    = filemd5("configs/app.conf")
    deploy_trigger = var.force_redeploy ? timestamp() : null
  }
}

resource "aws_instance" "app" {
  ami           = data.aws_ami.app.id
  instance_type = "t2.micro"
  
  # Reference terraform_data to trigger replacement
  replace_triggered_by = [
    terraform_data.app_deployment.output
  ]
  
  # Modern approach: everything in Cloud-Init
  user_data = base64encode(templatefile("templates/cloud-init.yaml", {
    app_version = terraform_data.app_deployment.input.app_version
    config_hash = terraform_data.app_deployment.input.config_hash
  }))
  
  tags = {
    Name = "app-server"
    Version = terraform_data.app_deployment.input.app_version
  }
}
```

---

## ⚠️ Legacy Provisioners: Edge Cases Only

**🚨 Use provisioners ONLY when modern approaches won't work:**

### When Provisioners Might Still Be Needed:

**🔍 Rare Edge Cases:**
1. **🔧 Legacy Systems**: Working with very old systems that don't support Cloud-Init
2. **🌐 Non-Cloud Resources**: On-premise resources without modern initialization
3. **🔗 External Integrations**: Calling external APIs after resource creation
4. **📊 Custom Notifications**: Complex logging or monitoring integrations
5. **🧪 Testing/Development**: Quick one-off scripts during development

### ⚠️ Provisioner Types (Use Sparingly)

**🏠 Local Provisioners** (run on your local machine):
- `local-exec`: Execute commands locally - **use only for notifications/logging**

**🌐 Remote Provisioners** (run on the target resource):
- `remote-exec`: Execute commands on remote resource
- `file`: Copy files to remote resource

#### 💻 Local-Exec Provisioner

The `local-exec` provisioner executes commands on the machine running Terraform (your local machine or CI/CD server).

**📝 Basic Syntax:**
```hcl
resource "aws_instance" "web" {
  ami           = "ami-12345"
  instance_type = "t2.micro"
  
  provisioner "local-exec" {
    command = "echo 'Instance ${self.id} created!'"
  }
}
```

**🔧 Advanced Example:**
```hcl
resource "aws_instance" "web" {
  ami           = "ami-12345"
  instance_type = "t2.micro"
  
  tags = {
    Name = "web-server"
  }
  
  provisioner "local-exec" {
    command = "echo 'Instance Details:' > instance-info.txt"
  }
  
  provisioner "local-exec" {
    command = "echo 'ID: ${self.id}' >> instance-info.txt"
  }
  
  provisioner "local-exec" {
    command = "echo 'Public IP: ${self.public_ip}' >> instance-info.txt"
  }
  
  # Run a script with environment variables
  provisioner "local-exec" {
    command = "./notify-team.sh"
    
    environment = {
      INSTANCE_ID = self.id
      PUBLIC_IP   = self.public_ip
      ENVIRONMENT = "production"
    }
  }
  
  # Run only on destroy
  provisioner "local-exec" {
    when    = destroy
    command = "echo 'Instance ${self.id} is being destroyed'"
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
