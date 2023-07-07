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

variable "storage" {
  description = "Storage specification for the environment"
  type        = object({
    repository = object({
      server = object({
        name = string
      })
    })
  })
}

locals {
  environment = var.environment

  storage = {
    repository = {
      server = {
        name = var.storage.repository.server.name
      }
    }
  }
}