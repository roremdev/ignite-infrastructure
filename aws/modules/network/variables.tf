variable "globals" {
  description = "Global variables for all modules"
  type        = object({
    account = string
    product = string
    project = string
  })
}

variable "environment" {
  description = "Environment to deploy"
  type        = string
  default     = "local"
}

variable "network" {
  description = "Network specification for the environment"
  type        = object({
    vpc = object({
      overview   = string
      name       = string
      cidr_block = string
    })
    subnet = object({
      zone_a = object({
        overview          = string
        name              = string
        cidr_block        = string
        availability_zone = string
        scope             = string
      })
      zone_b = object({
        overview          = string
        name              = string
        cidr_block        = string
        availability_zone = string
        scope             = string
      })
    })
    internet_gateway = object({
      overview = string
      name     = string
    })
    security_group = object({
      load_balancer = object({
        overview    = string
        name        = string
        description = string
        ingress     = list(object({
          description = string
          from_port   = number
          to_port     = number
          protocol    = string
          cidr_blocks = list(string)
        }))
      })
      server = object({
        overview    = string
        name        = string
        description = string
      })
    })
    load_balancer = object({
      server = object({
        overview     = string
        name         = string
        target_group = object({
          overview = string
          name     = string
        })
        listener = object({
          overview = string
          name     = string
        })
      })
    })
    route_table = object({
      public = object({
        name = string
      })
    })
  })
}

locals {
  environment = var.environment

  network = {
    vpc = {
      name       = var.network.vpc.name
      cidr_block = var.network.vpc.cidr_block
    }
    subnet = {
      zone_a = {
        name              = var.network.subnet.zone_a.name
        cidr_block        = var.network.subnet.zone_a.cidr_block
        availability_zone = var.network.subnet.zone_a.availability_zone
        scope             = var.network.subnet.zone_a.scope
      }
      zone_b = {
        name              = var.network.subnet.zone_b.name
        cidr_block        = var.network.subnet.zone_b.cidr_block
        availability_zone = var.network.subnet.zone_b.availability_zone
        scope             = var.network.subnet.zone_b.scope
      }
    }
    internet_gateway = {
      name = var.network.internet_gateway.name
    }
    security_group = {
      load_balancer = {
        name        = var.network.security_group.load_balancer.name
        description = var.network.security_group.load_balancer.description
        ingress     = var.network.security_group.load_balancer.ingress
      }
      server = {
        name        = var.network.security_group.server.name
        description = var.network.security_group.server.description
      }
    }
    load_balancer = {
      server = {
        overview     = var.network.load_balancer.server.overview
        name         = var.network.load_balancer.server.name
        target_group = {
          name = var.network.load_balancer.server.target_group.name
        }
        listener = {
          name = var.network.load_balancer.server.listener.name
        }
      }
    }
    route_table = {
      public = {
        name = var.network.route_table.public.name
      }
    }
  }
}
