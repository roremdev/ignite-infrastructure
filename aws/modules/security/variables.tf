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

variable "security" {
  description = "Security specification for the environment"
  type        = object({
    iam_role = object({
      server = object({
        name        = string
        description = string
      })
    })
  })
}

locals {
  environment = var.environment

  security = {
    iam_role = {
      server = {
        name        = var.security.iam_role.server.name
        description = var.security.iam_role.server.description
      }
    }
  }
}
