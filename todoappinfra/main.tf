module "resource_group" {
  source              = "../modules/azurerm_resource_group"
  rg_name             = "rg-todoapp"
  location            = "Central India"
}

module "virtual_network" {
  depends_on = [ module.resource_group ]           #yha explict use kar rhe hai kyonki dependent resource pehle se hi bane hai agar dependent resouce nhi bane hote to implict use kar sakte the kisi argument main jaise rg.
  source       = "../modules/azurerm_virtual_network"
  vnet_name    = "vnet1"
  rg_name      = "rg-todoapp"
  location     = "Central India"
  address_space = ["10.0.0.0/16"]
}

module "subnet" {
  depends_on = [ module.virtual_network ]  #depends on using after hardcoding the resource group and vnet name only for subnet made after vnet
  source            = "../modules/azurerm_subnet"
  subnet_name       = "frontend-subnet1"
  rg_name           = "rg-todoapp"
  vnet_name         = "vnet1"
  address_prefixes  = ["10.0.0.0/24"]
  
}

module "subnet_backend" {
  depends_on = [ module.virtual_network ]  #depends on using after hardcoding the resource group and vnet name only for subnet made after vnet
  source            = "../modules/azurerm_subnet"
  subnet_name       = "backend-subnet1"
  rg_name           = "rg-todoapp"
  vnet_name         = "vnet1"
  address_prefixes  = ["10.0.1.0/24"]
  
}

module "azurerm_virtual_machine_frontend" {
source = "../modules/azurerm_virtual_machine"
depends_on = [module.subnet]
pip_name = "pip-frontend-vm1"
nic_name = "frontend-vm1-nic"
vm_name = "frontend-vm1"
rg_name = "rg-todoapp"
location = "central india"
 subnet_id        = "/subscriptions/51b6ad96-2bb6-48e5-b566-1d3406221d56/resourceGroups/rg-todoapp/providers/Microsoft.Network/virtualNetworks/vnet1/subnets/frontend-subnet1"
}


module "azurerm_virtual_machine_backend" {
source = "../modules/azurerm_virtual_machine"
depends_on = [module.subnet]
pip_name = "pip-frontend-vm2"
nic_name = "frontend-vm2-nic"
vm_name = "frontend-vm2"
rg_name = "rg-todoapp"
location = "central india"
 subnet_id = "/subscriptions/51b6ad96-2bb6-48e5-b566-1d3406221d56/resourceGroups/rg-todoapp/providers/Microsoft.Network/virtualNetworks/vnet1/subnets/backend-subnet1"
}

module "azurerm_sql_server" {
  source = "../modules/azurerm_sql_server"
  server_name = "todoappsqlserver1"
  rg_name = "rg-todoapp"
  location = "central india"
  administrator_login = "ot905874"
  administrator_login_password = "orchid@12345"
}

module "azurerm_sql_database" {
  source        = "../modules/azurerm_sql_database"
  database_name = "todo-app-database"
server_id = "/subscriptions/51b6ad96-2bb6-48e5-b566-1d3406221d56/resourceGroups/rg-todoapp/providers/Microsoft.Sql/servers/todoappsqlserver1"
}
