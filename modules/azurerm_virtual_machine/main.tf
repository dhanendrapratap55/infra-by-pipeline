resource "azurerm_public_ip" "pip" {
name = var.pip_name
resource_group_name = var.rg_name
location = var.location
allocation_method = "Static"    # s shoulc be upper case

}


resource "azurerm_network_interface" "nic1" {


name = var.nic_name
location = var.location
resource_group_name = var.rg_name

ip_configuration {
    name   = "internal"
    subnet_id  = var.subnet_id   

    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip.id   # it is implcit depedendancy if resoruce in the same file folder then implcit dependency wll work no output and data block are requrired.
  }                                                            #terraform pehle public ip bananyega and phir uske id ko kya use karega

}



resource "azurerm_linux_virtual_machine" "vm" {
  name                  = var.vm_name
  resource_group_name   = var.rg_name         
  location              = var.location
  size                  = "Standard_F2"
  admin_username        = "ot905874"
  admin_password        = "orchid@12345"   # 👈 Must follow Azure complexity rules
  disable_password_authentication = false

  network_interface_ids = [azurerm_network_interface.nic1.id]   #implicit dependency on network interface (value NIC id se aaye and VM uske baad bane)
   

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"

  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}

