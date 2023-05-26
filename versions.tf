terraform {
  required_version = ">=1.0.0"

  required_providers {
    google = {
      source  = "hashicorp/azurerm"
      version = ">=3.1.0"
    }
  }
}
