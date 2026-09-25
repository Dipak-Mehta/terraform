resource "google_compute_firewall" "ssh_public" {
  name    = "${var.project_name}-allow-ssh"
  network = google_compute_network.this.name

  direction = "INGRESS"
  priority  = 1000

  source_ranges = [var.allowed_ssh_cidr]
  target_tags   = ["public-vm"]

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}

resource "google_compute_firewall" "ssh_private" {
  name    = "${var.project_name}-allow-private-ssh"
  network = google_compute_network.this.name

  direction = "INGRESS"
  priority  = 1000

  source_tags = ["public-vm"]
  target_tags = ["private-vm"]

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}
