output "network_id" {
  value = google_compute_network.this.id
}

output "public_vm_public_ip" {
  value = google_compute_instance.public.network_interface[0].access_config[0].nat_ip
}

output "public_vm_private_ip" {
  value = google_compute_instance.public.network_interface[0].network_ip
}

output "private_vm_private_ip" {
  value = google_compute_instance.private.network_interface[0].network_ip
}

output "region" {
  value = var.region
}

output "zone" {
  value = var.zone
}
