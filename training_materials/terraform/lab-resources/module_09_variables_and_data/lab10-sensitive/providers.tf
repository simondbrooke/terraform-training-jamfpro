terraform {
  required_providers {
    jamfpro = {
      source  = "deploymenttheory/jamfpro"
      version = "~> 0.24.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.1"
    }
  }
}

provider "jamfpro" {
  jamfpro_instance_fqdn = "https://lbgsandbox.jamfcloud.com"
  auth_method          = "oauth2"
  client_id            = "dummy-client-id"
  client_secret        = "dummy-client-secret"
}
