variable "globals" {
  default = {
    account = "fronity"
    product = "ignite"
    project = "dashboard"
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "user"

  default_tags {
    tags = {
      account = var.globals.account
      product = var.globals.product
      project = var.globals.project
    }
  }
}