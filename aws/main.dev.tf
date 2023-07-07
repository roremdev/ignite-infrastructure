locals {
  development = {
    description = "Architecture for development environment"
    network     = {
      vpc = {
        overview   = "Virtual Private Cloud (global)"
        name       = "dev-${var.globals.project}-vpc"
        cidr_block = "172.31.0.0/16"
      }
      subnet = {
        zone_a = {
          overview          = "Public Subnet (zone A)"
          name              = "dev-${var.globals.project}-subnet-1a"
          availability_zone = "us-east-1a"
          cidr_block        = "172.31.0.0/20"
          scope             = "public"
        }
        zone_b = {
          overview          = "Public Subnet (zone B)"
          name              = "dev-${var.globals.project}-subnet-1b"
          cidr_block        = "172.31.32.0/20"
          availability_zone = "us-east-1b"
          scope             = "public"
        }
      }
      internet_gateway = {
        overview = "Internet Gateway (global)"
        name     = "dev-${var.globals.project}-igw"
      }
      security_group = {
        load_balancer = {
          overview    = "Security Group (load balancer)"
          name        = "dev-${var.globals.project}-lb-sg"
          description = "Allow HTTP and HTTPS inbound traffic to load balancer"
          ingress     = [
            {
              description = "Allow HTTP from anywhere"
              from_port   = 80
              to_port     = 80
              protocol    = "tcp"
              cidr_blocks = ["0.0.0.0/0"]
            }
          ]
        }
        server = {
          overview    = "Security Group (server)"
          name        = "dev-${var.globals.project}-srv-sg"
          description = "Allow HTTP inbound traffic to server"
        }
      }
      load_balancer = {
        server = {
          overview     = "Load Balancer (server)"
          name         = "dev-${var.globals.project}-srv-lb"
          target_group = {
            overview = "Load Balancer Target Group (server)"
            name     = "dev-${var.globals.project}-srv-lb"
          }
          listener = {
            overview = "Load Balancer Listener (server)"
            name     = "dev-${var.globals.project}-srv-lb"
          }
        }
      }
      route_table = {
        public = {
          overview = "Route Table (public)"
          name     = "dev-${var.globals.project}-rtb-public"
        }
      }
    }
    security = {
      iam_role = {
        server = {
          overview    = "IAM Role (server)"
          name        = "AWSTaskDefinitionForECS"
          description = "Role to have execution tasks for AWS ECR and ECS"
        }
      }
    }
    storage = {
      repository = {
        server = {
          overview  = "Elastic Container Registry (global)"
          name      = var.globals.project
          container = {
            name = "development"
          }
        }
      }
    }
    monitor = {
      server = {
        log = {
          overview = "CloudWatch for logging (server)"
          group    = {
            name = "dev-${var.globals.project}-srv"
          }
          stream = {
            name = "development"
          }
        }
      }
    }
    compute = {
      server = {
        overview = "Elastic Container Service (server)"
        cluster  = {
          name = var.globals.project
        }
        task = {
          name = "development"
        }
        service = {
          name = "development"
        }
      }
    }
  }
}


module "dev_network" {
  source      = "./modules/network"
  globals     = var.globals
  environment = "development"
  network     = local.development.network
}

module "dev_security" {
  source      = "./modules/security"
  globals     = var.globals
  environment = "development"
  security    = local.development.security
}

module "dev_repository" {
  source      = "./modules/storage"
  globals     = var.globals
  environment = "development"
  storage     = local.development.storage
}

module "dev_monitor" {
  source      = "./modules/monitor"
  globals     = var.globals
  environment = "development"
  monitor     = local.development.monitor
}

module "dev_secrets" {
  source = "./modules/secrets"
}

module "dev_compute" {
  source      = "./modules/compute"
  globals     = var.globals
  environment = "development"
  network     = local.development.network
  security    = local.development.security
  storage     = local.development.storage
  monitor     = local.development.monitor
  secrets     = module.dev_secrets.secrets
  compute     = local.development.compute

  depends_on = [
    module.dev_network,
    module.dev_security,
    module.dev_repository
  ]
}

output "development" {
  description = "Development environment modules"
  value       = {
    network  = module.dev_network.network
    security = module.dev_security.security
    storage  = module.dev_repository.storage
    monitor  = module.dev_monitor.monitor
    secrets  = module.dev_secrets.secrets
    compute  = module.dev_compute.compute
  }
}