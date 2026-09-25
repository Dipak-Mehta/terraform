data "google_compute_image" "ubuntu" {
  project = var.image_project
  family  = var.image_family
}

resource "google_compute_instance" "public" {
  name         = "${var.project_name}-public-vm"
  machine_type = var.machine_type
  zone         = var.zone

  tags = ["public-vm"]

  boot_disk {
    initialize_params {
      image = data.google_compute_image.ubuntu.self_link
      size  = 20
      type  = "pd-balanced"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.public.id

    access_config {
      # Ephemeral public IPv4 address.
    }
  }

  metadata = {
    ssh-keys = "${var.ssh_username}:${var.ssh_public_key}"
  }

  labels = {
    project = var.project_name
    tier    = "public"
  }
}

resource "google_compute_instance" "private" {
  name         = "${var.project_name}-private-vm"
  machine_type = var.machine_type
  zone         = var.zone

  tags = ["private-vm"]

  boot_disk {
    initialize_params {
      image = data.google_compute_image.ubuntu.self_link
      size  = 20
      type  = "pd-balanced"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.private.id
  }

  metadata = {
    ssh-keys = "${var.ssh_username}:${var.ssh_public_key}"
  }

  labels = {
    project = var.project_name
    tier    = "private"
  }
}
