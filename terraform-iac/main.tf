data "azurerm_client_config" "current" {}

# ======================================================================================
# Resource Group
# ======================================================================================
resource "azurerm_resource_group" "current_ressources_group" {
  location = "${var.current_location}"
  name     = "${var.environment}-rg"
}
resource "azurerm_key_vault" "current_key_vault" {
  name                        = "${var.environment}-keyvault"
  location                    = "${azurerm_resource_group.current_ressources_group.location}"
  resource_group_name         = "${azurerm_resource_group.current_ressources_group.name}"
  tenant_id                   = "${data.azurerm_client_config.current.tenant_id}"
  enabled_for_disk_encryption = true
  sku {
    name = "standard"
  }
  access_policy {
    tenant_id = "${data.azurerm_client_config.current.tenant_id}"
    object_id = "${data.azurerm_client_config.current.service_principal_object_id}"
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
  address_space       = "${var.current_vnet_address_space}"
  location            = "${azurerm_resource_group.current_ressources_group.location}"
  resource_group_name = "${azurerm_resource_group.current_ressources_group.name}"
}
