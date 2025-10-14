# 🧮 Module 12: Expressions

## _Duration: 2 hours | Labs: 3_ | Difficulty: 🟡 Intermediate\*

**⏱️ Duration**: 70 minutes  
**🎯 Difficulty**: Advanced  
**📋 Prerequisites**: Completed Modules 1-9

## 🎯 Learning Objectives

By the end of this module, you will be able to:

- ✅ **Master Terraform data types** and value handling
- ✅ **Create dynamic string templates** with interpolation and directives
- ✅ **Implement conditional logic** using ternary operators
- ✅ **Build complex transformations** with for expressions
- ✅ **Simplify iterations** using splat expressions
- ✅ **Generate dynamic configurations** with dynamic blocks
- ✅ **Apply mathematical and logical operators** effectively

---

## 📚 What Are Expressions?

**Expressions** are the building blocks of Terraform configurations that **compute and return values**. They can reference variables, perform calculations, transform data, and implement complex logic.

**🔧 Expression Categories:**

- **🎯 Types and Values** - Data type handling
- **📝 String Templates** - Dynamic string construction
- **🔢 Operators** - Mathematical and logical operations
- **❓ Conditional Expressions** - If/else logic
- **🔄 For Expressions** - Data transformation loops
- **⭐ Splat Expressions** - Collection element extraction
- **🧱 Dynamic Blocks** - Dynamic resource configuration

```hcl
# Expression examples
locals {
  # Simple value expression
  environment = "production"

  # Mathematical expression
  instance_count = var.base_count * 2

  # Conditional expression
  instance_type = var.environment == "prod" ? "t3.large" : "t2.micro"

  # For expression
  subnet_cidrs = [for i in range(3) : "10.0.${i + 1}.0/24"]

  # String template
  bucket_name = "${var.project}-${local.environment}-${random_id.suffix.hex}"
}
```

---

## 🎯 Types and Values

Terraform supports **primitive types**, **complex types**, and **structural types** for handling different kinds of data.

### 🔤 Primitive Types

```hcl
# String type
variable "environment" {
  description = "Environment name"
  type        = string
  default     = "development"
}

# Number type (integer or float)
variable "instance_count" {
  description = "Number of instances"
  type        = number
  default     = 3
}

variable "cpu_credits" {
  description = "CPU credits per hour"
  type        = number
  default     = 24.5
}

# Boolean type
variable "enable_monitoring" {
  description = "Enable detailed monitoring"
  type        = bool
  default     = true
}

# Using primitive types
resource "aws_instance" "web" {
  count = var.instance_count  # number

  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  monitoring = var.enable_monitoring  # bool

  tags = {
    Name        = "web-${count.index + 1}"
    Environment = var.environment  # string
  }
}
```

### 📋 Collection Types

```hcl
# List type - ordered collection
variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["us-west-2a", "us-west-2b", "us-west-2c"]
}

# Set type - unordered unique collection
variable "allowed_ports" {
  description = "Set of allowed ports"
  type        = set(number)
  default     = [80, 443, 22]
}

# Map type - key-value pairs
variable "instance_tags" {
  description = "Map of instance tags"
  type        = map(string)
  default = {
    Environment = "production"
    Project     = "web-app"
    Owner       = "platform-team"
  }
}

# Using collection types
resource "aws_subnet" "public" {
  count = length(var.availability_zones)  # list length

  vpc_id            = aws_vpc.main.id
  availability_zone = var.availability_zones[count.index]  # list access
  cidr_block        = "10.0.${count.index + 1}.0/24"

  tags = var.instance_tags  # map assignment
}

resource "aws_security_group" "web" {
  name_prefix = "web-sg-"
  vpc_id      = aws_vpc.main.id

  # Dynamic ingress using set
  dynamic "ingress" {
    for_each = var.allowed_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}
```

### 🏗️ Structural Types

```hcl
# Object type - structured data
variable "database_config" {
  description = "Database configuration"
  type = object({
    engine_version    = string
    instance_class    = string
    allocated_storage = number
    backup_enabled    = bool
    backup_window     = string
    maintenance_window = string
    multi_az          = bool
  })

  default = {
    engine_version     = "8.0"
    instance_class     = "db.t3.micro"
    allocated_storage  = 20
    backup_enabled     = true
    backup_window      = "03:00-04:00"
    maintenance_window = "sun:04:00-sun:05:00"
    multi_az          = false
  }
}

# Tuple type - ordered collection of different types
variable "server_specs" {
  description = "Server specifications [name, cpu, memory, storage]"
  type        = tuple([string, number, number, number])
  default     = ["web-server", 2, 4096, 100]
}

# Using structural types
resource "aws_db_instance" "main" {
  identifier = "main-database"

  engine         = "mysql"
  engine_version = var.database_config.engine_version
  instance_class = var.database_config.instance_class

  allocated_storage = var.database_config.allocated_storage
  storage_type      = "gp2"
  storage_encrypted = true

  backup_retention_period = var.database_config.backup_enabled ? 7 : 0
  backup_window          = var.database_config.backup_window
  maintenance_window     = var.database_config.maintenance_window

  multi_az = var.database_config.multi_az

  tags = {
    Name = "main-database"
    Type = "mysql"
  }
}

# Using tuple
locals {
  server_name    = var.server_specs[0]  # string
  server_cpu     = var.server_specs[1]  # number
  server_memory  = var.server_specs[2]  # number
  server_storage = var.server_specs[3]  # number
}
```

---

## 📝 String Templates

String templates enable **dynamic string construction** with interpolation and conditional logic.

### 🔗 String Interpolation

```hcl
# Basic interpolation
locals {
  project_name = "my-app"
  environment  = "production"
  region       = "us-west-2"

  # Simple interpolation
  bucket_name = "${local.project_name}-${local.environment}-bucket"

  # Complex interpolation with functions
  resource_name = "${upper(local.project_name)}-${lower(local.environment)}-${replace(local.region, "-", "")}"

  # Interpolation with expressions
  instance_name = "${local.project_name}-${local.environment}-${formatdate("YYYY-MM-DD", timestamp())}"
}

# Multi-line string with interpolation
resource "local_file" "config" {
  filename = "app-config.yaml"
  content = <<-EOT
    application:
      name: ${local.project_name}
      environment: ${local.environment}
      region: ${local.region}
      version: ${var.app_version}

    database:
      host: ${aws_db_instance.main.endpoint}
      port: ${aws_db_instance.main.port}
      name: ${aws_db_instance.main.db_name}

    cache:
      host: ${aws_elasticache_cluster.main.cache_nodes[0].address}
      port: ${aws_elasticache_cluster.main.cache_nodes[0].port}
  EOT
}

# Interpolation in resource arguments
resource "aws_instance" "web" {
  count = 3

  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  user_data = base64encode(templatefile("${path.module}/user_data.sh", {
    instance_name = "${local.project_name}-web-${count.index + 1}"
    environment   = local.environment
    app_version   = var.app_version
    db_endpoint   = aws_db_instance.main.endpoint
  }))

  tags = {
    Name = "${local.project_name}-web-${count.index + 1}"
    FQDN = "${local.project_name}-web-${count.index + 1}.${local.environment}.example.com"
  }
}
```

### 🎛️ String Directives

```hcl
# Conditional directives
locals {
  environment = "production"
  debug_mode  = false
  features    = ["auth", "analytics", "monitoring"]
}

# If/else directives
resource "local_file" "nginx_config" {
  filename = "nginx.conf"
  content = <<-EOT
    server {
        listen 80;
        server_name example.com;

        %{if local.environment == "production"}
        # Production configuration
        access_log /var/log/nginx/access.log;
        error_log /var/log/nginx/error.log;
        %{else}
        # Development configuration
        access_log /dev/stdout;
        error_log /dev/stderr;
        %{endif}

        %{if local.debug_mode}
        # Debug headers
        add_header X-Debug-Mode "enabled";
        add_header X-Environment "${local.environment}";
        %{endif}

        location / {
            proxy_pass http://backend;
            %{if contains(local.features, "auth")}
            proxy_set_header Authorization $http_authorization;
            %{endif}
        }

        %{if contains(local.features, "monitoring")}
        location /health {
            access_log off;
            return 200 "healthy\n";
        }
        %{endif}
    }
  EOT
}

# For directives for iteration
resource "local_file" "docker_compose" {
  filename = "docker-compose.yml"
  content = <<-EOT
    version: '3.8'
    services:
      %{for service in ["web", "api", "worker"]}
      ${service}:
        image: ${local.project_name}/${service}:${var.app_version}
        environment:
          - ENV=${local.environment}
          - SERVICE=${service}
        %{if service == "web"}
        ports:
          - "80:8080"
        %{endif}
        %{if service == "api"}
        ports:
          - "8080:8080"
        %{endif}
      %{endfor}
  EOT
}

# Advanced directive usage
locals {
  environments = {
    dev = {
      instance_type = "t2.micro"
      min_size     = 1
      max_size     = 2
    }
    staging = {
      instance_type = "t3.small"
      min_size     = 2
      max_size     = 4
    }
    prod = {
      instance_type = "t3.medium"
      min_size     = 3
      max_size     = 10
    }
  }
}

resource "local_file" "terraform_vars" {
  filename = "auto.tfvars"
  content = <<-EOT
    # Auto-generated Terraform variables for ${local.environment}

    %{for env, config in local.environments}
    %{if env == local.environment}
    # Configuration for ${env} environment
    instance_type = "${config.instance_type}"
    min_size      = ${config.min_size}
    max_size      = ${config.max_size}

    # Environment-specific settings
    %{if env == "prod"}
    enable_monitoring = true
    backup_retention  = 30
    multi_az         = true
    %{else}
    enable_monitoring = false
    backup_retention  = 7
    multi_az         = false
    %{endif}
    %{endif}
    %{endfor}
  EOT
}
```

---

## 🔢 Operators

Terraform supports **arithmetic**, **comparison**, and **logical operators** for expressions.

### ➕ Arithmetic Operators

```hcl
locals {
  # Basic arithmetic
  base_count = 5
  multiplier = 2

  # Addition and subtraction
  total_instances = local.base_count + 3        # 8
  reduced_count   = local.base_count - 1        # 4

  # Multiplication and division
  scaled_count    = local.base_count * local.multiplier  # 10
  half_count      = local.base_count / 2                 # 2.5

  # Modulo
  remainder = local.base_count % 3              # 2

  # Complex calculations
  memory_gb = var.memory_mb / 1024
  storage_cost = var.storage_gb * var.cost_per_gb * 24 * 30  # Monthly cost

  # CPU calculations
  total_cpu = var.instance_count * var.cpu_per_instance
  cpu_utilization = (local.total_cpu / var.max_cpu) * 100
}

# Using arithmetic in resource configuration
resource "aws_instance" "web" {
  count = local.total_instances

  ami           = data.aws_ami.ubuntu.id
  instance_type = local.memory_gb > 8 ? "t3.large" : "t3.medium"

  root_block_device {
    volume_size = var.base_storage + (count.index * 10)  # Increasing storage
    volume_type = "gp3"
  }

  tags = {
    Name = "web-${count.index + 1}"
    Cost = "$${local.storage_cost}"
  }
}
```

### 🔍 Comparison Operators

```hcl
locals {
  environment = "production"
  instance_count = 5
  cpu_threshold = 80
  memory_gb = 16

  # Equality and inequality
  is_production = local.environment == "production"      # true
  not_dev       = local.environment != "development"     # true

  # Numerical comparisons
  high_capacity    = local.instance_count > 3           # true
  low_capacity     = local.instance_count < 10          # true
  meets_minimum    = local.instance_count >= 5          # true
  under_maximum    = local.instance_count <= 20         # true

  # Complex comparisons
  needs_scaling = local.cpu_threshold > 75 && local.memory_gb < 32
  is_enterprise = local.instance_count >= 10 || local.memory_gb >= 64
}

# Using comparisons in conditionals
resource "aws_autoscaling_group" "web" {
  name = "web-asg"

  min_size         = local.is_production ? 3 : 1
  max_size         = local.high_capacity ? 20 : 10
  desired_capacity = local.instance_count

  # Conditional scaling policies
  enabled_metrics = local.needs_scaling ? [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupTotalInstances"
  ] : []

  tag {
    key                 = "Environment"
    value               = local.environment
    propagate_at_launch = true
  }

  tag {
    key                 = "Tier"
    value               = local.is_enterprise ? "enterprise" : "standard"
    propagate_at_launch = true
  }
}
```

### 🧠 Logical Operators

```hcl
locals {
  environment     = "production"
  enable_backup   = true
  enable_monitoring = true
  instance_count  = 5
  region         = "us-west-2"

  # AND operator
  production_ready = local.environment == "production" && local.enable_backup
  fully_monitored  = local.enable_monitoring && local.instance_count > 1

  # OR operator
  needs_backup = local.environment == "production" || local.instance_count > 3
  multi_region = local.region == "us-west-2" || local.region == "us-east-1"

  # NOT operator
  not_development = !startswith(local.environment, "dev")
  backup_disabled = !local.enable_backup

  # Complex logical expressions
  high_availability = (
    local.environment == "production" &&
    local.instance_count >= 3 &&
    local.enable_monitoring
  )

  cost_optimized = (
    local.environment != "production" ||
    (local.instance_count <= 5 && !local.enable_backup)
  )
}

# Using logical operators in resource configuration
resource "aws_db_instance" "main" {
  identifier = "main-database"

  engine         = "mysql"
  engine_version = "8.0"
  instance_class = local.high_availability ? "db.t3.medium" : "db.t3.micro"

  # Conditional backup configuration
  backup_retention_period = local.needs_backup ? 7 : 0
  backup_window          = local.needs_backup ? "03:00-04:00" : null

  # Multi-AZ for high availability
  multi_az = local.high_availability

  # Monitoring configuration
  monitoring_interval = local.fully_monitored ? 60 : 0
  monitoring_role_arn = local.fully_monitored ? aws_iam_role.rds_monitoring[0].arn : null

  # Performance insights
  performance_insights_enabled = local.production_ready && local.fully_monitored

  tags = {
    Environment      = local.environment
    HighAvailability = local.high_availability ? "true" : "false"
    CostOptimized    = local.cost_optimized ? "true" : "false"
  }
}

# Conditional resources based on logical expressions
resource "aws_iam_role" "rds_monitoring" {
  count = local.fully_monitored ? 1 : 0

  name = "rds-monitoring-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "monitoring.rds.amazonaws.com"
        }
      }
    ]
  })
}
```

---

## ❓ Conditional Expressions

Conditional expressions implement **if/else logic** using the ternary operator pattern.

### 🎯 Basic Conditionals

```hcl
# Basic ternary operator: condition ? true_value : false_value
locals {
  environment = "production"

  # Simple conditionals
  instance_type = var.environment == "prod" ? "t3.large" : "t2.micro"
  storage_size  = var.environment == "prod" ? 100 : 20
  backup_enabled = var.environment == "prod" ? true : false

  # String conditionals
  log_level = var.debug_mode ? "DEBUG" : "INFO"
  domain    = var.environment == "prod" ? "example.com" : "dev.example.com"

  # Numeric conditionals
  instance_count = var.environment == "prod" ? 5 : 1
  timeout        = var.environment == "prod" ? 300 : 60
}

resource "aws_instance" "web" {
  count = local.instance_count

  ami           = data.aws_ami.ubuntu.id
  instance_type = local.instance_type

  root_block_device {
    volume_size = local.storage_size
    volume_type = "gp3"
    encrypted   = var.environment == "prod" ? true : false
  }

  tags = {
    Name        = "web-${count.index + 1}"
    Environment = var.environment
    Backup      = local.backup_enabled ? "enabled" : "disabled"
  }
}
```

### 🔗 Nested Conditionals

```hcl
locals {
  environment = "staging"
  region      = "us-west-2"
  team_size   = 10

  # Nested conditionals
  instance_type = (
    var.environment == "prod" ? "t3.large" :
    var.environment == "staging" ? "t3.medium" :
    "t2.micro"
  )

  # Complex nested logic
  backup_retention = (
    var.environment == "prod" ? 30 :
    var.environment == "staging" ? 7 :
    var.environment == "dev" ? 1 :
    0
  )

  # Multi-condition evaluation
  monitoring_level = (
    var.environment == "prod" && local.team_size > 5 ? "comprehensive" :
    var.environment == "prod" ? "standard" :
    var.environment == "staging" ? "basic" :
    "minimal"
  )

  # Region-specific conditionals
  availability_zones = (
    local.region == "us-west-2" ? ["us-west-2a", "us-west-2b", "us-west-2c"] :
    local.region == "us-east-1" ? ["us-east-1a", "us-east-1b", "us-east-1c"] :
    local.region == "eu-west-1" ? ["eu-west-1a", "eu-west-1b", "eu-west-1c"] :
    []
  )
}

# Using nested conditionals in resources
resource "aws_db_instance" "main" {
  identifier = "main-database"

  engine         = "mysql"
  engine_version = "8.0"

  # Nested conditional for instance class
  instance_class = (
    var.environment == "prod" && local.team_size > 20 ? "db.r5.xlarge" :
    var.environment == "prod" ? "db.t3.medium" :
    var.environment == "staging" ? "db.t3.small" :
    "db.t3.micro"
  )

  allocated_storage = (
    var.environment == "prod" ? 500 :
    var.environment == "staging" ? 100 :
    20
  )

  backup_retention_period = local.backup_retention

  # Conditional multi-AZ
  multi_az = var.environment == "prod" ? true : false

  # Conditional encryption
  storage_encrypted = (
    var.environment == "prod" ||
    (var.environment == "staging" && local.team_size > 10)
  ) ? true : false

  tags = {
    Environment     = var.environment
    MonitoringLevel = local.monitoring_level
    TeamSize        = local.team_size
  }
}
```

### 📋 Conditionals with Collections

```hcl
locals {
  environment = "production"
  features = ["auth", "monitoring", "backup"]
  regions  = ["us-west-2", "us-east-1"]

  # Conditional lists
  security_groups = var.environment == "prod" ? [
    aws_security_group.web.id,
    aws_security_group.database.id,
    aws_security_group.monitoring.id
  ] : [
    aws_security_group.web.id
  ]

  # Conditional maps
  instance_tags = var.environment == "prod" ? {
    Environment = "production"
    Backup      = "enabled"
    Monitoring  = "comprehensive"
    Compliance  = "required"
  } : {
    Environment = var.environment
    Backup      = "disabled"
    Monitoring  = "basic"
  }

  # Feature-based conditionals
  enabled_services = [
    "web",
    contains(local.features, "auth") ? "auth-service" : null,
    contains(local.features, "monitoring") ? "monitoring-service" : null,
    contains(local.features, "backup") ? "backup-service" : null,
  ]

  # Filter out null values
  active_services = compact(local.enabled_services)
}

# Using conditionals with for_each
resource "aws_instance" "services" {
  for_each = toset(local.active_services)

  ami           = data.aws_ami.ubuntu.id
  instance_type = each.key == "web" ? "t3.medium" : "t3.small"

  vpc_security_group_ids = each.key == "web" ? local.security_groups : [aws_security_group.internal.id]

  user_data = base64encode(templatefile("${path.module}/user_data/${each.key}.sh", {
    environment = var.environment
    service     = each.key
    features    = join(",", local.features)
  }))

  tags = merge(local.instance_tags, {
    Name    = "${each.key}-service"
    Service = each.key
  })
}
```

---

## 🔄 For Expressions

For expressions enable **data transformation** and **collection manipulation** with powerful iteration capabilities.

### 📋 List Transformations

```hcl
locals {
  # Source data
  environments = ["dev", "staging", "prod"]
  base_ports   = [80, 443, 8080]
  users        = ["alice", "bob", "charlie", "diana"]

  # Basic list transformations
  environment_buckets = [
    for env in local.environments : "${var.project}-${env}-bucket"
  ]

  # List with conditionals
  production_buckets = [
    for env in local.environments : "${var.project}-${env}-bucket"
    if env == "prod" || env == "staging"
  ]

  # Numeric transformations
  https_ports = [
    for port in local.base_ports : port + 8000
    if port != 80
  ]

  # String transformations
  user_emails = [
    for user in local.users : "${user}@example.com"
  ]

  # Complex transformations
  user_configs = [
    for i, user in local.users : {
      username = user
      user_id  = i + 1000
      email    = "${user}@example.com"
      home_dir = "/home/${user}"
      groups   = user == "alice" ? ["admin", "users"] : ["users"]
    }
  ]
}

# Using transformed lists in resources
resource "aws_s3_bucket" "environment_buckets" {
  for_each = toset(local.environment_buckets)

  bucket = each.key

  tags = {
    Environment = regex("-(\\w+)-bucket$", each.key)[0]
    Purpose     = "application-storage"
  }
}

resource "aws_iam_user" "users" {
  for_each = {
    for config in local.user_configs : config.username => config
  }

  name = each.value.username
  path = "/users/"

  tags = {
    Email  = each.value.email
    UserID = each.value.user_id
  }
}
```

### 🗺️ Map Transformations

```hcl
locals {
  # Source maps
  environments = {
    dev = {
      instance_type = "t2.micro"
      min_size     = 1
      max_size     = 2
    }
    staging = {
      instance_type = "t3.small"
      min_size     = 2
      max_size     = 4
    }
    prod = {
      instance_type = "t3.medium"
      min_size     = 3
      max_size     = 10
    }
  }

  # Transform map values
  environment_configs = {
    for env, config in local.environments : env => {
      instance_type = config.instance_type
      min_size     = config.min_size
      max_size     = config.max_size
      storage_size = config.instance_type == "t3.medium" ? 100 : 50
      backup_enabled = env == "prod"
    }
  }

  # Filter and transform
  production_configs = {
    for env, config in local.environments : env => config
    if env == "prod" || env == "staging"
  }

  # Create new map structure
  instance_types_by_env = {
    for env, config in local.environments :
    upper(env) => config.instance_type
  }

  # Complex map transformations
  detailed_configs = {
    for env, config in local.environments : env => {
      # Basic config
      instance_type = config.instance_type
      scaling = {
        min_size = config.min_size
        max_size = config.max_size
        desired  = config.min_size
      }

      # Conditional features
      features = {
        monitoring = env == "prod"
        backup     = env != "dev"
        encryption = env == "prod"
        multi_az   = env == "prod"
      }

      # Computed values
      cost_estimate = (
        config.min_size *
        (config.instance_type == "t3.medium" ? 50 :
         config.instance_type == "t3.small" ? 25 : 10) *
        24 * 30
      )
    }
  }
}

# Using transformed maps
resource "aws_launch_template" "app" {
  for_each = local.detailed_configs

  name_prefix   = "${each.key}-app-"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = each.value.instance_type

  monitoring {
    enabled = each.value.features.monitoring
  }

  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      volume_size = each.key == "prod" ? 100 : 50
      volume_type = "gp3"
      encrypted   = each.value.features.encryption
    }
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Environment   = each.key
      CostEstimate  = "$${each.value.cost_estimate}/month"
      Monitoring    = each.value.features.monitoring ? "enabled" : "disabled"
    }
  }
}
```

### 🔄 Advanced For Expressions

```hcl
locals {
  # Complex nested data
  applications = {
    web = {
      environments = ["dev", "staging", "prod"]
      ports       = [80, 443]
      replicas    = { dev = 1, staging = 2, prod = 5 }
    }
    api = {
      environments = ["staging", "prod"]
      ports       = [8080, 8443]
      replicas    = { staging = 3, prod = 8 }
    }
    worker = {
      environments = ["prod"]
      ports       = []
      replicas    = { prod = 3 }
    }
  }

  # Flatten nested structure
  app_instances = flatten([
    for app_name, app_config in local.applications : [
      for env in app_config.environments : {
        app         = app_name
        environment = env
        replicas    = app_config.replicas[env]
        ports       = app_config.ports
        key         = "${app_name}-${env}"
      }
    ]
  ])

  # Convert to map for for_each
  app_instances_map = {
    for instance in local.app_instances : instance.key => instance
  }

  # Group by environment
  instances_by_env = {
    for env in distinct([for instance in local.app_instances : instance.environment]) : env => [
      for instance in local.app_instances : instance if instance.environment == env
    ]
  }

  # Calculate totals
  total_instances = sum([
    for instance in local.app_instances : instance.replicas
  ])

  # Environment summaries
  env_summaries = {
    for env, instances in local.instances_by_env : env => {
      total_instances = sum([for instance in instances : instance.replicas])
      applications    = length(instances)
      total_ports     = length(distinct(flatten([for instance in instances : instance.ports])))
    }
  }
}

# Create resources from transformed data
resource "aws_autoscaling_group" "app_instances" {
  for_each = local.app_instances_map

  name                = each.value.key
  vpc_zone_identifier = data.aws_subnets.private.ids

  min_size         = each.value.replicas
  max_size         = each.value.replicas * 2
  desired_capacity = each.value.replicas

  launch_template {
    id      = aws_launch_template.app[each.value.app].id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = each.value.key
    propagate_at_launch = true
  }

  tag {
    key                 = "Application"
    value               = each.value.app
    propagate_at_launch = true
  }

  tag {
    key                 = "Environment"
    value               = each.value.environment
    propagate_at_launch = true
  }
}

# Output summaries
output "environment_summaries" {
  description = "Summary of instances by environment"
  value       = local.env_summaries
}

output "total_instances" {
  description = "Total number of instances across all environments"
  value       = local.total_instances
}
```

---

## ⭐ Splat Expressions

Splat expressions provide a **concise syntax** for extracting values from collections, serving as shorthand for common for expressions.

### 📋 Basic Splat Operations

```hcl
# Sample data
locals {
  servers = [
    { name = "web1", ip = "10.0.1.10", type = "web" },
    { name = "web2", ip = "10.0.1.11", type = "web" },
    { name = "api1", ip = "10.0.2.10", type = "api" },
    { name = "api2", ip = "10.0.2.11", type = "api" }
  ]

  # Splat expressions - extract single attribute
  server_names = local.servers[*].name    # ["web1", "web2", "api1", "api2"]
  server_ips   = local.servers[*].ip      # ["10.0.1.10", "10.0.1.11", "10.0.2.10", "10.0.2.11"]
  server_types = local.servers[*].type    # ["web", "web", "api", "api"]

  # Equivalent for expressions (more verbose)
  server_names_verbose = [for server in local.servers : server.name]
  server_ips_verbose   = [for server in local.servers : server.ip]
}

# Using splat with resources
resource "aws_instance" "servers" {
  for_each = {
    for server in local.servers : server.name => server
  }

  ami           = data.aws_ami.ubuntu.id
  instance_type = each.value.type == "web" ? "t3.small" : "t3.medium"
  private_ip    = each.value.ip

  tags = {
    Name = each.value.name
    Type = each.value.type
  }
}

# Splat with resource references
output "instance_ids" {
  description = "All instance IDs"
  value       = values(aws_instance.servers)[*].id
}

output "instance_public_ips" {
  description = "All public IP addresses"
  value       = values(aws_instance.servers)[*].public_ip
}
```

### 🔄 Advanced Splat Usage

```hcl
locals {
  # Complex nested data
  applications = {
    web = {
      instances = [
        { name = "web1", az = "us-west-2a", size = "small" },
        { name = "web2", az = "us-west-2b", size = "small" }
      ]
      load_balancer = { name = "web-lb", port = 80 }
    }
    api = {
      instances = [
        { name = "api1", az = "us-west-2a", size = "medium" },
        { name = "api2", az = "us-west-2b", size = "medium" },
        { name = "api3", az = "us-west-2c", size = "medium" }
      ]
      load_balancer = { name = "api-lb", port = 8080 }
    }
  }

  # Extract nested values with splat
  all_instance_names = flatten([
    for app in values(local.applications) : app.instances[*].name
  ])

  # Load balancer names
  lb_names = values(local.applications)[*].load_balancer.name

  # All availability zones used
  all_azs = distinct(flatten([
    for app in values(local.applications) : app.instances[*].az
  ]))

  # Instance sizes by application
  instance_sizes_by_app = {
    for app_name, app_config in local.applications :
    app_name => app_config.instances[*].size
  }
}

# Create subnets for all AZs
resource "aws_subnet" "app_subnets" {
  for_each = toset(local.all_azs)

  vpc_id            = aws_vpc.main.id
  availability_zone = each.key
  cidr_block        = "10.0.${index(local.all_azs, each.key) + 1}.0/24"

  tags = {
    Name = "app-subnet-${each.key}"
    AZ   = each.key
  }
}

# Create instances for each application
resource "aws_instance" "app_instances" {
  for_each = {
    for app_name, app_config in local.applications :
    app_name => app_config
  }

  # Use splat to count instances
  count = length(each.value.instances)

  ami               = data.aws_ami.ubuntu.id
  instance_type     = each.value.instances[count.index].size == "small" ? "t3.small" : "t3.medium"
  availability_zone = each.value.instances[count.index].az
  subnet_id         = aws_subnet.app_subnets[each.value.instances[count.index].az].id

  tags = {
    Name        = each.value.instances[count.index].name
    Application = each.key
    Size        = each.value.instances[count.index].size
  }
}
```

### 🎯 Splat with Conditionals

```hcl
locals {
  # Server configurations with different attributes
  all_servers = [
    { name = "web1", type = "web", public = true, backup = false },
    { name = "web2", type = "web", public = true, backup = true },
    { name = "db1", type = "database", public = false, backup = true },
    { name = "cache1", type = "cache", public = false, backup = false },
    { name = "api1", type = "api", public = true, backup = true }
  ]

  # Filter then splat
  public_servers = [
    for server in local.all_servers : server if server.public
  ]
  public_server_names = local.public_servers[*].name

  # Backup-enabled servers
  backup_servers = [
    for server in local.all_servers : server if server.backup
  ]
  backup_server_names = local.backup_servers[*].name

  # Group by type, then use splat
  servers_by_type = {
    for type in distinct(local.all_servers[*].type) : type => [
      for server in local.all_servers : server if server.type == type
    ]
  }

  # Extract names by type using splat
  web_server_names = local.servers_by_type["web"][*].name
  db_server_names  = local.servers_by_type["database"][*].name
}

# Create security groups based on server types
resource "aws_security_group" "server_type_sgs" {
  for_each = local.servers_by_type

  name_prefix = "${each.key}-sg-"
  vpc_id      = aws_vpc.main.id
  description = "Security group for ${each.key} servers"

  # Dynamic ingress based on server type
  dynamic "ingress" {
    for_each = each.key == "web" ? [80, 443] : each.key == "api" ? [8080] : each.key == "database" ? [3306] : []
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = each.key == "database" ? ["10.0.0.0/8"] : ["0.0.0.0/0"]
    }
  }

  tags = {
    Name        = "${each.key}-security-group"
    ServerCount = length(each.value)
    ServerNames = join(",", each.value[*].name)
  }
}

# Outputs using splat expressions
output "all_server_info" {
  description = "Summary of all servers"
  value = {
    total_servers    = length(local.all_servers)
    public_servers   = local.public_server_names
    backup_servers   = local.backup_server_names
    web_servers      = local.web_server_names
    database_servers = local.db_server_names
    server_types     = distinct(local.all_servers[*].type)
  }
}
```

---

## 🧱 Dynamic Blocks

Dynamic blocks enable **programmatic generation** of nested configuration blocks, making configurations more flexible and maintainable.

### 🔧 Basic Dynamic Blocks

```hcl
# Traditional static configuration (repetitive)
resource "aws_security_group" "web_static" {
  name_prefix = "web-static-"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/8"]
  }
}

# Dynamic configuration (flexible)
locals {
  ingress_rules = [
    { port = 80, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"], description = "HTTP" },
    { port = 443, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"], description = "HTTPS" },
    { port = 22, protocol = "tcp", cidr_blocks = ["10.0.0.0/8"], description = "SSH" }
  ]
}

resource "aws_security_group" "web_dynamic" {
  name_prefix = "web-dynamic-"
  vpc_id      = aws_vpc.main.id
  description = "Dynamic security group for web servers"

  dynamic "ingress" {
    for_each = local.ingress_rules
    content {
      description = ingress.value.description
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-dynamic-sg"
    Rules = length(local.ingress_rules)
  }
}
```

### 🎛️ Complex Dynamic Blocks

```hcl
locals {
  # Environment-specific configurations
  environments = {
    dev = {
      instance_type = "t2.micro"
      ports = [
        { port = 80, source = "0.0.0.0/0", description = "HTTP" },
        { port = 22, source = "10.0.0.0/8", description = "SSH" }
      ]
      block_devices = [
        { device_name = "/dev/sda1", volume_size = 20, volume_type = "gp2" }
      ]
      monitoring = false
    }
    staging = {
      instance_type = "t3.small"
      ports = [
        { port = 80, source = "0.0.0.0/0", description = "HTTP" },
        { port = 443, source = "0.0.0.0/0", description = "HTTPS" },
        { port = 22, source = "10.0.0.0/8", description = "SSH" }
      ]
      block_devices = [
        { device_name = "/dev/sda1", volume_size = 50, volume_type = "gp3" },
        { device_name = "/dev/sdb", volume_size = 100, volume_type = "gp3" }
      ]
      monitoring = true
    }
    prod = {
      instance_type = "t3.medium"
      ports = [
        { port = 80, source = "0.0.0.0/0", description = "HTTP" },
        { port = 443, source = "0.0.0.0/0", description = "HTTPS" },
        { port = 8080, source = "10.0.0.0/8", description = "Admin" },
        { port = 22, source = "10.0.0.0/8", description = "SSH" }
      ]
      block_devices = [
        { device_name = "/dev/sda1", volume_size = 100, volume_type = "gp3" },
        { device_name = "/dev/sdb", volume_size = 500, volume_type = "gp3" },
        { device_name = "/dev/sdc", volume_size = 1000, volume_type = "gp3" }
      ]
      monitoring = true
    }
  }
}

# Dynamic security groups for each environment
resource "aws_security_group" "app" {
  for_each = local.environments

  name_prefix = "${each.key}-app-sg-"
  vpc_id      = aws_vpc.main.id
  description = "Security group for ${each.key} application servers"

  # Dynamic ingress rules
  dynamic "ingress" {
    for_each = each.value.ports
    content {
      description = ingress.value.description
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = "tcp"
      cidr_blocks = [ingress.value.source]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${each.key}-app-sg"
    Environment = each.key
    PortCount   = length(each.value.ports)
  }
}

# Dynamic launch templates
resource "aws_launch_template" "app" {
  for_each = local.environments

  name_prefix   = "${each.key}-app-lt-"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = each.value.instance_type

  vpc_security_group_ids = [aws_security_group.app[each.key].id]

  # Dynamic block device mappings
  dynamic "block_device_mappings" {
    for_each = each.value.block_devices
    content {
      device_name = block_device_mappings.value.device_name
      ebs {
        volume_size           = block_device_mappings.value.volume_size
        volume_type           = block_device_mappings.value.volume_type
        encrypted             = each.key == "prod"
        delete_on_termination = true
      }
    }
  }

  # Conditional monitoring
  dynamic "monitoring" {
    for_each = each.value.monitoring ? [1] : []
    content {
      enabled = true
    }
  }

  user_data = base64encode(templatefile("${path.module}/user_data.sh", {
    environment = each.key
    ports       = jsonencode(each.value.ports[*].port)
  }))

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name         = "${each.key}-app-instance"
      Environment  = each.key
      InstanceType = each.value.instance_type
      Monitoring   = each.value.monitoring ? "enabled" : "disabled"
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}
```

### 🔄 Nested Dynamic Blocks

```hcl
locals {
  # Complex application configuration
  applications = {
    web = {
      environments = ["dev", "staging", "prod"]
      load_balancer = {
        listeners = [
          { port = 80, protocol = "HTTP", target_port = 8080 },
          { port = 443, protocol = "HTTPS", target_port = 8080, certificate_arn = var.ssl_cert_arn }
        ]
        health_check = {
          path     = "/health"
          port     = 8080
          protocol = "HTTP"
          matcher  = "200"
        }
      }
      auto_scaling = {
        min_size = 2
        max_size = 10
        target_groups = ["web-tg-80", "web-tg-443"]
      }
    }
    api = {
      environments = ["staging", "prod"]
      load_balancer = {
        listeners = [
          { port = 8080, protocol = "HTTP", target_port = 8080 },
          { port = 8443, protocol = "HTTPS", target_port = 8080, certificate_arn = var.ssl_cert_arn }
        ]
        health_check = {
          path     = "/api/health"
          port     = 8080
          protocol = "HTTP"
          matcher  = "200,202"
        }
      }
      auto_scaling = {
        min_size = 3
        max_size = 15
        target_groups = ["api-tg-8080", "api-tg-8443"]
      }
    }
  }
}

# Application Load Balancers with nested dynamic blocks
resource "aws_lb" "app" {
  for_each = local.applications

  name               = "${each.key}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb[each.key].id]
  subnets            = data.aws_subnets.public.ids

  enable_deletion_protection = each.key == "prod" ? true : false

  tags = {
    Name        = "${each.key}-alb"
    Application = each.key
  }
}

# Target groups with dynamic health checks
resource "aws_lb_target_group" "app" {
  for_each = {
    for app_name, app_config in local.applications :
    app_name => app_config
  }

  name     = "${each.key}-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  # Dynamic health check configuration
  dynamic "health_check" {
    for_each = [each.value.load_balancer.health_check]
    content {
      enabled             = true
      healthy_threshold   = 2
      unhealthy_threshold = 2
      timeout             = 5
      interval            = 30
      path                = health_check.value.path
      port                = health_check.value.port
      protocol            = health_check.value.protocol
      matcher             = health_check.value.matcher
    }
  }

  tags = {
    Name        = "${each.key}-target-group"
    Application = each.key
  }
}

# Load balancer listeners with nested dynamic blocks
resource "aws_lb_listener" "app" {
  for_each = {
    for pair in flatten([
      for app_name, app_config in local.applications : [
        for listener in app_config.load_balancer.listeners : {
          app      = app_name
          port     = listener.port
          protocol = listener.protocol
          target_port = listener.target_port
          certificate_arn = lookup(listener, "certificate_arn", null)
          key = "${app_name}-${listener.port}"
        }
      ]
    ]) : pair.key => pair
  }

  load_balancer_arn = aws_lb.app[each.value.app].arn
  port              = each.value.port
  protocol          = each.value.protocol

  # Conditional SSL certificate
  dynamic "certificate_arn" {
    for_each = each.value.certificate_arn != null ? [each.value.certificate_arn] : []
    content {
      certificate_arn = certificate_arn.value
    }
  }

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app[each.value.app].arn
  }

  tags = {
    Application = each.value.app
    Port        = each.value.port
    Protocol    = each.value.protocol
  }
}

# Auto Scaling Groups with dynamic target group attachments
resource "aws_autoscaling_group" "app" {
  for_each = local.applications

  name                = "${each.key}-asg"
  vpc_zone_identifier = data.aws_subnets.private.ids

  min_size         = each.value.auto_scaling.min_size
  max_size         = each.value.auto_scaling.max_size
  desired_capacity = each.value.auto_scaling.min_size

  target_group_arns = [aws_lb_target_group.app[each.key].arn]

  launch_template {
    id      = aws_launch_template.app[each.key].id
    version = "$Latest"
  }

  # Dynamic tags
  dynamic "tag" {
    for_each = {
      Name        = "${each.key}-asg-instance"
      Application = each.key
      Environment = "multi"
    }
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}
```

---

## 💻 **Exercise 9.1**: Advanced Expressions Implementation

**Duration**: 50 minutes

Let's build a comprehensive multi-environment application using all expression types.

**Step 1: Project Structure**

```bash
mkdir terraform-expressions
cd terraform-expressions

# Create file structure
touch {main,variables,outputs,locals}.tf
mkdir -p templates
```

**Step 2: Variables (`variables.tf`)**

```hcl
variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "expressions-demo"
}

variable "environments" {
  description = "Environment configurations"
  type = map(object({
    instance_type     = string
    min_instances     = number
    max_instances     = number
    enable_monitoring = bool
    backup_retention  = number
    allowed_ports     = list(number)
    features         = set(string)
    database_config = object({
      instance_class = string
      storage_gb     = number
      multi_az       = bool
    })
  }))

  default = {
    dev = {
      instance_type     = "t2.micro"
      min_instances     = 1
      max_instances     = 3
      enable_monitoring = false
      backup_retention  = 1
      allowed_ports     = [80, 22]
      features         = ["basic"]
      database_config = {
        instance_class = "db.t3.micro"
        storage_gb     = 20
        multi_az       = false
      }
    }
    staging = {
      instance_type     = "t3.small"
      min_instances     = 2
      max_instances     = 6
      enable_monitoring = true
      backup_retention  = 7
      allowed_ports     = [80, 443, 22]
      features         = ["basic", "analytics"]
      database_config = {
        instance_class = "db.t3.small"
        storage_gb     = 100
        multi_az       = false
      }
    }
    prod = {
      instance_type     = "t3.medium"
      min_instances     = 3
      max_instances     = 12
      enable_monitoring = true
      backup_retention  = 30
      allowed_ports     = [80, 443, 8080, 22]
      features         = ["basic", "analytics", "monitoring", "backup"]
      database_config = {
        instance_class = "db.r5.large"
        storage_gb     = 500
        multi_az       = true
      }
    }
  }
}

variable "regions" {
  description = "AWS regions for deployment"
  type        = list(string)
  default     = ["us-west-2", "us-east-1"]
}

variable "team_members" {
  description = "Team member configurations"
  type = list(object({
    name  = string
    role  = string
    email = string
  }))

  default = [
    { name = "alice", role = "admin", email = "alice@example.com" },
    { name = "bob", role = "developer", email = "bob@example.com" },
    { name = "charlie", role = "developer", email = "charlie@example.com" },
    { name = "diana", role = "operator", email = "diana@example.com" }
  ]
}
```

**Step 3: Locals with Complex Expressions (`locals.tf`)**

```hcl
locals {
  # String template expressions
  timestamp = formatdate("YYYY-MM-DD-hhmm", timestamp())

  # Conditional expressions
  primary_region = var.regions[0]
  is_multi_region = length(var.regions) > 1

  # For expressions - transform environments
  environment_configs = {
    for env, config in var.environments : env => {
      # Basic config
      instance_type = config.instance_type
      scaling = {
        min = config.min_instances
        max = config.max_instances
        desired = config.min_instances
      }

      # Conditional features
      monitoring_enabled = config.enable_monitoring
      backup_enabled = contains(config.features, "backup")
      analytics_enabled = contains(config.features, "analytics")

      # Computed values
      estimated_cost = (
        config.min_instances *
        (config.instance_type == "t3.medium" ? 40 :
         config.instance_type == "t3.small" ? 20 : 10) *
        24 * 30
      )

      # String interpolation
      bucket_name = "${var.project_name}-${env}-${local.timestamp}"
      log_group = "/aws/ec2/${var.project_name}/${env}"

      # Database configuration with conditionals
      database = {
        instance_class = config.database_config.instance_class
        storage_gb = config.database_config.storage_gb
        backup_retention = config.backup_retention
        multi_az = config.database_config.multi_az
        encrypted = env == "prod" ? true : false
        identifier = "${var.project_name}-${env}-db"
      }
    }
  }

  # Splat expressions
  all_ports = distinct(flatten(values(var.environments)[*].allowed_ports))
  all_features = distinct(flatten(values(var.environments)[*].features))
  environment_names = keys(var.environments)

  # For expression with filtering
  production_envs = [
    for env, config in var.environments : env
    if config.enable_monitoring && config.backup_retention > 7
  ]

  # Team member transformations
  team_by_role = {
    for role in distinct(var.team_members[*].role) : role => [
      for member in var.team_members : member if member.role == role
    ]
  }

  admin_emails = [
    for member in var.team_members : member.email
    if member.role == "admin"
  ]

  # Complex nested expressions
  security_rules = flatten([
    for env, config in var.environments : [
      for port in config.allowed_ports : {
        env = env
        port = port
        description = (
          port == 80 ? "HTTP" :
          port == 443 ? "HTTPS" :
          port == 8080 ? "Admin" :
          port == 22 ? "SSH" :
          "Custom-${port}"
        )
        source = (
          port == 22 ? "10.0.0.0/8" :
          port == 8080 ? "10.0.0.0/8" :
          "0.0.0.0/0"
        )
        key = "${env}-${port}"
      }
    ]
  ])

  # Map for for_each usage
  security_rules_map = {
    for rule in local.security_rules : rule.key => rule
  }

  # Calculate totals using expressions
  total_min_instances = sum(values(var.environments)[*].min_instances)
  total_max_instances = sum(values(var.environments)[*].max_instances)
  total_estimated_cost = sum(values(local.environment_configs)[*].estimated_cost)

  # Environment summary with complex expressions
  environment_summary = {
    for env, config in local.environment_configs : env => {
      resources = {
        instances = "Min: ${config.scaling.min}, Max: ${config.scaling.max}"
        database = config.database.identifier
        storage = "${config.database.storage_gb}GB"
        bucket = config.bucket_name
      }
      features = {
        monitoring = config.monitoring_enabled ? "✅" : "❌"
        backup = config.backup_enabled ? "✅" : "❌"
        analytics = config.analytics_enabled ? "✅" : "❌"
        multi_az = config.database.multi_az ? "✅" : "❌"
      }
      cost = "$${config.estimated_cost}/month"
    }
  }
}
```

**Step 4: Main Configuration with Dynamic Blocks (`main.tf`)**

```hcl
# Data sources
data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

# VPC
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.project_name}-vpc"
    Environments = join(",", local.environment_names)
  }
}

# Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.project_name}-igw"
  }
}

# Subnets using for expressions
resource "aws_subnet" "public" {
  count = length(data.aws_availability_zones.available.names)

  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.${count.index + 1}.0/24"
  availability_zone = data.aws_availability_zones.available.names[count.index]

  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-public-${count.index + 1}"
    AZ   = data.aws_availability_zones.available.names[count.index]
  }
}

# Security groups with dynamic blocks
resource "aws_security_group" "app" {
  for_each = var.environments

  name_prefix = "${each.key}-app-sg-"
  vpc_id      = aws_vpc.main.id
  description = "Security group for ${each.key} application"

  # Dynamic ingress rules using complex expressions
  dynamic "ingress" {
    for_each = {
      for rule in local.security_rules : rule.key => rule
      if rule.env == each.key
    }
    content {
      description = ingress.value.description
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = "tcp"
      cidr_blocks = [ingress.value.source]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${each.key}-app-sg"
    Environment = each.key
    PortCount = length(each.value.allowed_ports)
    Features = join(",", each.value.features)
  }
}

# Launch templates with conditional blocks
resource "aws_launch_template" "app" {
  for_each = local.environment_configs

  name_prefix   = "${each.key}-app-lt-"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = each.value.instance_type

  vpc_security_group_ids = [aws_security_group.app[each.key].id]

  # Conditional monitoring block
  dynamic "monitoring" {
    for_each = each.value.monitoring_enabled ? [1] : []
    content {
      enabled = true
    }
  }

  # Dynamic block device mappings
  dynamic "block_device_mappings" {
    for_each = each.key == "prod" ? [
      { device = "/dev/sda1", size = 50 },
      { device = "/dev/sdb", size = 100 }
    ] : [
      { device = "/dev/sda1", size = 20 }
    ]
    content {
      device_name = block_device_mappings.value.device
      ebs {
        volume_size = block_device_mappings.value.size
        volume_type = "gp3"
        encrypted   = each.key == "prod"
        delete_on_termination = true
      }
    }
  }

  user_data = base64encode(templatefile("${path.module}/templates/user_data.sh.tpl", {
    environment = each.key
    project     = var.project_name
    features    = join(",", var.environments[each.key].features)
    log_group   = each.value.log_group
    bucket_name = each.value.bucket_name
  }))

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name        = "${each.key}-app-instance"
      Environment = each.key
      Project     = var.project_name
      Features    = join(",", var.environments[each.key].features)
      Cost        = each.value.estimated_cost
    }
  }
}

# S3 buckets using string templates
resource "aws_s3_bucket" "app" {
  for_each = local.environment_configs

  bucket = each.value.bucket_name

  tags = {
    Name        = each.value.bucket_name
    Environment = each.key
    Purpose     = "application-storage"
  }
}

# CloudWatch Log Groups with conditional creation
resource "aws_cloudwatch_log_group" "app" {
  for_each = {
    for env, config in local.environment_configs : env => config
    if config.monitoring_enabled
  }

  name              = each.value.log_group
  retention_in_days = each.key == "prod" ? 90 : 30

  tags = {
    Name        = each.value.log_group
    Environment = each.key
  }
}

# RDS instances with complex conditionals
resource "aws_db_instance" "app" {
  for_each = local.environment_configs

  identifier = each.value.database.identifier

  engine         = "mysql"
  engine_version = "8.0"
  instance_class = each.value.database.instance_class

  allocated_storage = each.value.database.storage_gb
  storage_type      = "gp2"
  storage_encrypted = each.value.database.encrypted

  db_name  = replace(var.project_name, "-", "_")
  username = "admin"
  password = "temporary-password-change-me"

  backup_retention_period = each.value.database.backup_retention
  backup_window          = "03:00-04:00"
  maintenance_window     = "sun:04:00-sun:05:00"

  multi_az = each.value.database.multi_az

  skip_final_snapshot = each.key != "prod"
  final_snapshot_identifier = each.key == "prod" ? "${each.value.database.identifier}-final-${local.timestamp}" : null

  tags = {
    Name        = each.value.database.identifier
    Environment = each.key
    MultiAZ     = each.value.database.multi_az ? "enabled" : "disabled"
    Encrypted   = each.value.database.encrypted ? "enabled" : "disabled"
  }
}
```

**Step 5: Create User Data Template (`templates/user_data.sh.tpl`)**

```bash
#!/bin/bash
# User data script for ${project} ${environment} environment

# Update system
apt-get update
apt-get upgrade -y

# Install CloudWatch agent if monitoring enabled
%{if contains(split(",", features), "monitoring")}
wget https://amazoncloudwatch-agent.s3.amazonaws.com/ubuntu/amd64/latest/amazon-cloudwatch-agent.deb
dpkg -i amazon-cloudwatch-agent.deb
%{endif}

# Install application dependencies
apt-get install -y nginx awscli jq

# Configure application
cat > /opt/app-config.json << EOF
{
  "environment": "${environment}",
  "project": "${project}",
  "features": [${jsonencode(split(",", features))}],
  "log_group": "${log_group}",
  "bucket_name": "${bucket_name}",
  "timestamp": "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
}
EOF

# Create nginx configuration
cat > /var/www/html/index.html << EOF
<!DOCTYPE html>
<html>
<head>
    <title>${project} - ${environment}</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; }
        .env-${environment} { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 20px; border-radius: 10px; }
        .info { background: #f0f8ff; padding: 15px; margin: 10px 0; border-radius: 5px; }
        .feature { display: inline-block; background: #4CAF50; color: white; padding: 5px 10px; margin: 2px; border-radius: 3px; }
    </style>
</head>
<body>
    <div class="env-${environment}">
        <h1>🧮 ${project} - ${upper(environment)} Environment</h1>
        <p>Terraform Expressions Demo Application</p>
    </div>

    <div class="info">
        <h2>Environment Information</h2>
        <p><strong>Environment:</strong> ${environment}</p>
        <p><strong>Project:</strong> ${project}</p>
        <p><strong>Instance ID:</strong> <span id="instance-id">Loading...</span></p>
        <p><strong>Availability Zone:</strong> <span id="az">Loading...</span></p>
    </div>

    <div class="info">
        <h2>Enabled Features</h2>
        %{for feature in split(",", features)}
        <span class="feature">${feature}</span>
        %{endfor}
    </div>

    <div class="info">
        <h2>Configuration</h2>
        <p><strong>Log Group:</strong> ${log_group}</p>
        <p><strong>S3 Bucket:</strong> ${bucket_name}</p>
        <p><strong>Deployment Time:</strong> $(date)</p>
    </div>

    <script>
        // Fetch instance metadata
        fetch('http://169.254.169.254/latest/meta-data/instance-id')
            .then(response => response.text())
            .then(data => document.getElementById('instance-id').textContent = data);

        fetch('http://169.254.169.254/latest/meta-data/placement/availability-zone')
            .then(response => response.text())
            .then(data => document.getElementById('az').textContent = data);
    </script>
</body>
</html>
EOF

# Start services
systemctl start nginx
systemctl enable nginx

# Log deployment
echo "$(date): ${environment} environment deployed for ${project}" >> /var/log/terraform-deployment.log

%{if contains(split(",", features), "monitoring")}
# Send custom metric to CloudWatch
aws cloudwatch put-metric-data --region $(curl -s http://169.254.169.254/latest/meta-data/placement/region) --namespace "${project}/${environment}" --metric-data MetricName=InstanceDeployment,Value=1,Unit=Count
%{endif}
```

**Step 6: Outputs with Expression Examples (`outputs.tf`)**

```hcl
# Simple outputs
output "project_info" {
  description = "Basic project information"
  value = {
    name = var.project_name
    timestamp = local.timestamp
    regions = var.regions
    primary_region = local.primary_region
    is_multi_region = local.is_multi_region
  }
}

# Outputs using splat expressions
output "environment_summary" {
  description = "Summary of all environments"
  value = {
    environments = local.environment_names
    total_min_instances = local.total_min_instances
    total_max_instances = local.total_max_instances
    total_estimated_cost = "$${local.total_estimated_cost}/month"
    all_features = local.all_features
    all_ports = local.all_ports
    production_environments = local.production_envs
  }
}

# Complex outputs using for expressions
output "detailed_environment_info" {
  description = "Detailed information for each environment"
  value = local.environment_summary
}

# Team information using expressions
output "team_info" {
  description = "Team member information"
  value = {
    total_members = length(var.team_members)
    members_by_role = local.team_by_role
    admin_contacts = local.admin_emails
    all_members = var.team_members[*].name
  }
}

# Resource outputs using splat and for expressions
output "infrastructure_details" {
  description = "Infrastructure resource details"
  value = {
    vpc_id = aws_vpc.main.id
    subnet_ids = aws_subnet.public[*].id
    availability_zones = aws_subnet.public[*].availability_zone

    security_groups = {
      for env, sg in aws_security_group.app :
      env => {
        id = sg.id
        name = sg.name
      }
    }

    databases = {
      for env, db in aws_db_instance.app :
      env => {
        identifier = db.identifier
        endpoint = db.endpoint
        port = db.port
        multi_az = db.multi_az
      }
    }

    s3_buckets = values(aws_s3_bucket.app)[*].bucket

    log_groups = {
      for env, lg in aws_cloudwatch_log_group.app :
      env => lg.name
    }
  }
}

# Conditional outputs
output "monitoring_resources" {
  description = "Resources created for monitoring"
  value = {
    for env, config in local.environment_configs :
    env => {
      monitoring_enabled = config.monitoring_enabled
      log_group = config.monitoring_enabled ? aws_cloudwatch_log_group.app[env].name : "disabled"
    }
    if config.monitoring_enabled
  }
}
```

**Step 7: Deploy and Test**

```bash
# Initialize
terraform init

# Plan and review expressions
terraform plan

# Apply configuration
terraform apply

# Test expressions in Terraform console
terraform console

# Try these expressions in console:
# > local.environment_summary
# > local.security_rules_map
# > values(aws_s3_bucket.app)[*].bucket
# > [for env, config in var.environments : "${env}: ${config.instance_type}"]

# View outputs
terraform output

# Clean up
terraform destroy
```

**🔍 What This Exercise Demonstrates:**

1. **Types and Values**: Complex object and collection type handling
2. **String Templates**: Dynamic string construction with conditionals
3. **Operators**: Mathematical, comparison, and logical operations
4. **Conditional Expressions**: Nested ternary operators and feature flags
5. **For Expressions**: Data transformation and filtering
6. **Splat Expressions**: Efficient collection value extraction
7. **Dynamic Blocks**: Programmatic resource configuration

💡 **Pro Tip**: Expressions are the heart of Terraform's flexibility. Master them to create highly dynamic and maintainable infrastructure configurations!

---

## ✅ Module 9 Summary

**🎯 Learning Objectives Achieved:**

- ✅ Mastered **Terraform data types** including primitives, collections, and structural types
- ✅ Created **dynamic string templates** with interpolation and conditional directives
- ✅ Implemented **conditional logic** using ternary operators and complex nested conditions
- ✅ Built **complex transformations** with for expressions and data manipulation
- ✅ Simplified **iterations** using splat expressions for efficient value extraction
- ✅ Generated **dynamic configurations** with dynamic blocks and programmatic resource creation
- ✅ Applied **mathematical and logical operators** for complex calculations and comparisons

**🔑 Key Concepts Covered:**

- **Data Types**: Primitive (string, number, bool), Collection (list, set, map), Structural (object, tuple)
- **String Templates**: Interpolation with `${}`, conditional directives with `%{if}`, iteration with `%{for}`
- **Operators**: Arithmetic (+, -, \*, /, %), Comparison (==, !=, <, >, <=, >=), Logical (&&, ||, !)
- **Conditional Expressions**: Ternary operators, nested conditionals, feature-based conditions
- **For Expressions**: List transformations, map transformations, filtering, complex nested operations
- **Splat Expressions**: Collection value extraction, nested attribute access, filtering patterns
- **Dynamic Blocks**: Programmatic block generation, conditional block creation, nested dynamic structures

**💼 Professional Skills Developed:**

- **Advanced Configuration Management**: Creating flexible, data-driven infrastructure configurations
- **Template Engineering**: Building dynamic templates with conditional logic and iteration
- **Data Transformation**: Converting and manipulating complex data structures efficiently
- **Pattern Recognition**: Identifying when to use different expression types for optimal solutions
- **Code Optimization**: Writing maintainable and performant Terraform configurations
- **Complex Logic Implementation**: Handling sophisticated business requirements in infrastructure code

**🏗️ Technical Achievements:**

- Built comprehensive multi-environment application with all expression types
- Implemented dynamic security groups with conditional rules based on environment
- Created complex data transformations with nested for expressions and filtering
- Developed template-based user data scripts with conditional feature installation
- Established patterns for cost calculation, resource scaling, and feature management
- Demonstrated advanced splat usage for efficient collection manipulation

**🧮 Advanced Expression Patterns Mastered:**

- **Conditional Resource Creation**: Using expressions to control resource deployment
- **Dynamic Configuration Generation**: Template-based configuration file creation
- **Complex Data Structures**: Multi-level nested objects with computed values
- **Cost Estimation**: Mathematical expressions for infrastructure cost calculations
- **Feature Flag Implementation**: Boolean logic for conditional feature enablement
- **Multi-Environment Scaling**: Expression-based scaling policies across environments

**🎨 Expression Best Practices:**

- **Readability**: Breaking complex expressions into manageable local values
- **Performance**: Using splat expressions for efficient collection operations
- **Maintainability**: Organizing expressions logically with clear naming conventions
- **Flexibility**: Creating reusable expression patterns for common operations
- **Documentation**: Using descriptive variable names and comments for complex logic

**➡️ Next Steps**: Ready to explore **Terraform State Management** where you'll learn about state files, state commands, and state best practices!

---

---

## 🔗 **Next Steps**

Ready to continue your Terraform journey? Proceed to the next module:

**➡️ [Module 13: Terraform State](./module_13_terraform_state.md)**

Master state management, the foundation of Terraform operations.

---
