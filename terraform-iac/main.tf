data "azurerm_client_config" "current" {}
output "current_client_id" {
  value = data.azurerm_client_config.current.client_id
}
output "current_tenant_id" {
  value = data.azurerm_client_config.current.tenant_id
}
output "current_subscription_id" {
  value = data.azurerm_client_config.current.subscription_id
}
output "current_object_id" {
  value = data.azurerm_client_config.current.object_id
}

# ======================================================================================
# Resource Group
# ======================================================================================
resource "azurerm_resource_group" "current_ressources_group" {
  location = "${var.current_location}"
  name     = "${var.current_environment}-rg"
}
resource "azurerm_key_vault" "current_key_vault" {
  name                        = "${var.current_environment}-keyvault"
  location                    = "${azurerm_resource_group.current_ressources_group.location}"
  resource_group_name         = "${azurerm_resource_group.current_ressources_group.name}"
  tenant_id                   = "${data.azurerm_client_config.current.tenant_id}"
  enabled_for_disk_encryption = true
  sku {
    name = "standard"
  }
  access_policy {
    tenant_id = "${data.azurerm_client_config.current.tenant_id}"
    object_id = "${data.azurerm_client_config.current.object_id}"
    key_permissions = [
      "get",
      "list",
      "create",
      "delete"
    ]
    secret_permissions = [
      "get",
      "list",
      "set",
      "delete"
    ]
  }
}

# ======================================================================================
# create vnet
# ======================================================================================
resource "azurerm_virtual_network" "vnet" {
  name                = "test_vnet"
  address_space       = ["${var.current_vnet_address_space}"]
  location            = "${azurerm_resource_group.current_ressources_group.location}"
  resource_group_name = "${azurerm_resource_group.current_ressources_group.name}"
}
