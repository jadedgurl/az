resource "azurerm_resource_group" "azureresourcegroup" {
  name     = "mcit_resource_group"
  location = "Canada Central"
}
resource "azurerm_storage_account" "azurestorageaccount" {
  name                     = "${var.prefix}storageaccount"
  resource_group_name      = azurerm_resource_group.azureresourcegroup.name
  location                 = azurerm_resource_group.azureresourcegroup.location
  account_tier             = var.account_tier
  account_replication_type = "LRS"
}
resource "azurerm_storage_container" "azurestoragecontainer" {
  name                  = "mcitcontent"
  storage_account_name  = azurerm_storage_account.azurestorageaccount.name
  container_access_type = "private"
}
resource "azurerm_storage_blob" "azurestorageblob" {
  name                   = "my-awesome-content.zip"
  storage_account_name   = azurerm_storage_account.azurestorageaccount.name
  storage_container_name = azurerm_storage_container.azurestoragecontainer.name
  type                   = "Block"
  source                 = "some-local-file.zip"
}
