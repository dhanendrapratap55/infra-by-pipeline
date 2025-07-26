resource "azurerm_mssql_database" "todo_app_database" {
  name           = var.database_name
  server_id      = var.server_id
  sku_name       = "Basic"                       
}
