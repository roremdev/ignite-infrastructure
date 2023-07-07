terraform {
  required_providers {
    doppler = {
      source  = "dopplerhq/doppler"
      version = "1.2.2"
    }
  }
}

provider "doppler" {
  doppler_token = "dp.st.srv_development.CDH2C6DBSEgWT6xQRzk5liR6bddlt6jat9gUaY73c2s"
  alias         = "server"
}

data "doppler_secrets" "server" {
  provider = doppler.server
}