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

variable "monitor" {
  description = "Monitor specification for the environment"
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

locals {
  environment = var.environment

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
}