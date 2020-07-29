#Data Disk for Virtual Machine
resource "azurerm_managed_disk" "datadisk" {
  count                = var.numbercount
  name                 = "datadisk_existing_${count.index}"
  location             = var.location
  resource_group_name  = var.rgname
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = "50"
}

# Data template Bash bootstrapping file
data "template_file" "linux-vm-cloud-init" {
  template = file("monitsystem.sh")
}

#Aure Virtual machine
resource "azurerm_virtual_machine" "terravm" {
  name                  = "vm-stg-${count.index}"
  location              = var.location
  resource_group_name   = var.rgname
  count 		  = var.numbercount
  network_interface_ids = [element(azurerm_network_interface.terranic.*.id, count.index)]
  vm_size               = "Standard_B1ls"
  delete_os_disk_on_termination = true
  delete_data_disks_on_termination = true


  storage_os_disk {
    name                 = "osdisk-${count.index}"
    caching              = "ReadWrite"
    create_option        = "FromImage"
    managed_disk_type    = "Premium_LRS"
    disk_size_gb         = "30"
  }

  storage_data_disk {
    name              = element(azurerm_managed_disk.datadisk.*.name, count.index)
    managed_disk_id   = element(azurerm_managed_disk.datadisk.*.id, count.index)
    create_option     = "Attach"
    lun               = 1
    disk_size_gb      = element(azurerm_managed_disk.datadisk.*.disk_size_gb, count.index)
  }

  storage_image_reference {
    publisher       = "Canonical"
    offer           = "UbuntuServer"
    sku             = "16.04-LTS"
    version         = "latest"
  }
  os_profile {
    computer_name = "hostname"
    admin_username = "assignment"
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      path     = "/home/assignment/.ssh/authorized_keys"
      key_data = var.public_key
    }
  }

  connection {
    host = azurerm_public_ip.vmip.id
    user = "assignment"
    type = "ssh"
    private_key = "${file("./id_rsa")}"
    timeout = "1m"
    agent = true
  }
}