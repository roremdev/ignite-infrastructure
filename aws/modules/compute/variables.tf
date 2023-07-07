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
  description = "Network for the environment"
  type        = object({
    vpc = object({
      name = string
    })
    security_group = object({
      server = object({
        name = string
      })
    })
    load_balancer = object({
      server = object({
        target_group = object({
          name = string
        })
      })
    })
  })
}

variable "security" {
  description = "Security for the environment"
  type        = object({
    iam_role = object({
      server = object({
        name        = string
        description = string
      })
    })
  })
}

variable "storage" {
  description = "Storage for the environment"
  type        = object({
    repository = object({
      server = object({
        name = string
      })
    })
  })
}

variable "monitor" {
  description = "Monitor for the environment"
  type        = object({
    server = object({
      log = object({
        group = object({
          name = string
        })
        stream = object({
          name = string
        })
      })
    })
  })
}

variable "secrets" {
  description = "Secrets for the environment"
  type        = object({
    server = object({
      DOMAIN      = string
      ENVIRONMENT = string
      PORT        = string
      SERVER_URL  = string
    })
  })
}

variable "compute" {
  description = "Compute specification for the environment"
  type        = object({
    server = object({
      cluster = object({
        name = string
      })
      task = object({
        name = string
      })
      service = object({
        name = string
      })
    })
  })
}

locals {
  environment = var.environment

  network = {
    vpc = {
      name = var.network.vpc.name
    }
    security_group = {
      server = {
        name = var.network.security_group.server.name
      }
    }
    load_balancer = {
      server = {
        target_group = {
          name = var.network.load_balancer.server.target_group.name
        }
      }
    }
  }
  security = {
    iam_role = {
      server = {
        name        = var.security.iam_role.server.name
        description = var.security.iam_role.server.description
      }
    }
  }
  storage = {
    repository = {
      server = {
        name = var.storage.repository.server.name
      }
    }
  }
  monitor = {
    server = {
      log = {
        group = {
          name = var.monitor.server.log.group.name
        }
        stream = {
          name = var.monitor.server.log.stream.name
        }
      }
    }
  }
  compute = {
    server = {
      cluster = {
        name = var.compute.server.cluster.name
      }
      task = {
        name = var.compute.server.task.name
      }
      service = {
        name = var.compute.server.service.name
      }
    }
  }
}