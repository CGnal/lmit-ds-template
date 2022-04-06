resource "google_compute_address" "internal" {
  name         = "${var.INSTANCENAME}-int-ip"
  project      = var.PROJECT
  region       = var.REGION
  address_type = "INTERNAL"
  subnetwork   = var.SUBNET
}


resource "google_compute_instance" "default" {
  name         = var.INSTANCENAME
  machine_type = var.NODETYPE
  zone         = var.ZONE
  project      = var.PROJECT
  tags = ["adeo", "internet", "ssh", "teradata"]

  boot_disk {
    initialize_params {
      image = var.OS_IMAGE
      size = var.BOOT_SIZE
    }
  }
  
  network_interface {
    network = var.NETWORK
    subnetwork = var.SUBNET
    network_ip = google_compute_address.internal.address
  }

  service_account {
    email = var.COMPUTESERVICEACCOUNT
    scopes = ["cloud-platform"]
  }

}


resource "google_compute_instance" "default" {
  name         = var.TRAIN_INSTANCENAME
  machine_type = var.TRAIN_NODETYPE
  zone         = var.ZONE
  project      = var.PROJECT
  tags = ["adeo", "internet", "ssh", "teradata"]

  boot_disk {
    initialize_params {
      image = var.OS_IMAGE
      size = var.TRAIN_BOOT_SIZE
    }
  }

  network_interface {
    network = var.NETWORK
    subnetwork = var.SUBNET
    network_ip = google_compute_address.internal.address
  }

  service_account {
    email = var.COMPUTESERVICEACCOUNT
    scopes = ["cloud-platform"]
  }

}
