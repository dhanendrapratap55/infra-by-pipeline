variable "database_name" {
  type        = string
  description = "The name of the SQL database to create"
}

variable "server_id" {
  type        = string
  description = "The ID of the SQL Server (azurerm_mssql_server.id)"
}
