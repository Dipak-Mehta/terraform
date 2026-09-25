output "resource_group_name" {
  value = azurerm_resource_group.this.name
}

output "vnet_id" {
  value = azurerm_virtual_network.this.id
}

output "public_vm_public_ip" {
  value = azurerm_public_ip.public_vm.ip_address
}

output "public_vm_private_ip" {
  value = azurerm_network_interface.public.private_ip_address
}

output "private_vm_private_ip" {
  value = azurerm_network_interface.private.private_ip_address
}

output "nat_public_ip" {
  value = azurerm_public_ip.nat.ip_address
}
