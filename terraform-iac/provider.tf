provider "azurerm" {
  version="2.0.0"
  features {}
  #subscription_id = "${var.azure-subscription-id}"
  #client_id       = "${var.azure-client-app-id}"
  #client_secret   = "${var.azure-client-secret-password}"
  #tenant_id       = "${var.azure-tenant-id}"
}

terraform {
  required_version = "0.12.24"
  backend "azurerm" {
    storage_account_name = "srvmdcld__current_application__tfsa"
    container_name       = "terraform"
    key                  = "terraform-__current_environment__.tfstate"
    access_key           = "__tf_storage_account_key__"
  }
}
