# NIC
resource "azurerm_network_interface" "main" {
  name                      = var.web01-network_interface_name
  location                  = var.location
  resource_group_name       = azurerm_resource_group.resource_group.name
  network_security_group_id = azurerm_network_security_group.main.id

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = azurerm_subnet.Public.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.main.id
  }
}

# IP
resource "azurerm_public_ip" "main" {
  name                = var.web01-publicip
  location            = var.location
  resource_group_name = azurerm_resource_group.resource_group.name
  allocation_method   = "Static"
}

# Fire Wall
resource "azurerm_network_security_group" "main" {
  name                = var.web01-securitygroup
  location            = var.location
  resource_group_name = azurerm_resource_group.resource_group.name
}

# SG for Remote Desktop Protocol
resource "azurerm_network_security_rule" "RDP" {
  name                        = "RDP"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "3389"
  source_address_prefix       = "*"
  destination_address_prefix  = "VirtualNetwork"
  resource_group_name         = azurerm_resource_group.resource_group.name
  network_security_group_name = azurerm_network_security_group.main.name
}

# SG for HTTP
resource "azurerm_network_security_rule" "HTTP" {
  name                        = "HTTP"
  priority                    = 110
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.resource_group.name
  network_security_group_name = azurerm_network_security_group.main.name
}


# VM
resource "azurerm_virtual_machine" "main" {
  name                  = var.web01-vmname
  location              = var.location
  resource_group_name   = azurerm_resource_group.resource_group.name
  network_interface_ids = [azurerm_network_interface.main.id]
  vm_size               = "Standard_DS1_v2"

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
  storage_os_disk {
    name              = var.web01-storagename
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = var.web01-hostname
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }
  os_profile_windows_config {
    provision_vm_agent        = true
    enable_automatic_upgrades = true
  }
}

resource "azurerm_virtual_machine_extension" "IIS" {
  name                  = "IIS"
  location              = var.location
  resource_group_name   = azurerm_resource_group.resource_group.name
  virtual_machine_name  = azurerm_virtual_machine.main.name
  publisher             = "Microsoft.Compute"
  type                  = "CustomScriptExtension"
  type_handler_version  = "1.9"

  settings = <<SETTINGS
    {
        "commandToExecute" : "powershell.exe -Command Add-WindowsFeature Web-Server"
    }
  SETTINGS
}

