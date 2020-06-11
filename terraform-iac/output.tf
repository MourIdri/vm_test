output "subscription_id" {
  value = "${data.azurerm_client_config.current.subscription_id}"
}
output "current_ressources_group_name" {
  value = "${azurerm_resource_group.current_ressources_group.name}"
}
output "current_ressources_group_id" {
  value = "${azurerm_resource_group.current_ressources_group.id}"
}
output "current_key_vault_uri" {
  value = "${azurerm_key_vault.current_key_vault.vault_uri}"
}