output "secrets" {
  description = "Secrets output by environment"
  value       = {
    server = {
      DOMAIN      = nonsensitive(data.doppler_secrets.server.map.DOMAIN)
      ENVIRONMENT = nonsensitive(data.doppler_secrets.server.map.ENVIRONMENT)
      PORT        = nonsensitive(data.doppler_secrets.server.map.PORT)
      SERVER_URL  = nonsensitive(data.doppler_secrets.server.map.SERVER_URL)
    }
  }
}