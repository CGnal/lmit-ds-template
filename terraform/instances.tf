resource "google_compute_address" "internal_exec" {
  name         = "${var.INSTANCENAME}-int-ip"
  project      = var.PROJECT
  region       = var.REGION
  address_type = "INTERNAL"
  subnetwork   = var.SUBNET
}


resource "google_compute_instance" "execution" {
  name         = var.INSTANCENAME
  machine_type = var.NODETYPE
  zone         = var.ZONE
  project      = var.PROJECT
  description  = "Execution instance"
  tags         = ["adeo", "internet", "ssh", "teradata"]

  boot_disk {
    initialize_params {
      image = var.OS_IMAGE
      size  = var.BOOT_SIZE
    }
  }

  network_interface {
    network    = var.NETWORK
    subnetwork = var.SUBNET
    network_ip = google_compute_address.internal_exec.address
  }

  service_account {
    email  = var.COMPUTESERVICEACCOUNT
    scopes = ["cloud-platform"]
  }

  shielded_instance_config {
        enable_integrity_monitoring = true
        enable_secure_boot          = false
        enable_vtpm                 = true
    }
}


resource "google_compute_address" "internal_train" {
  name         = "${var.TRAIN_INSTANCENAME}-int-ip"
  project      = var.PROJECT
  region       = var.REGION
  address_type = "INTERNAL"
  subnetwork   = var.SUBNET
}


resource "google_compute_instance" "train" {
  name         = var.TRAIN_INSTANCENAME
  machine_type = var.TRAIN_NODETYPE
  zone         = var.ZONE
  project      = var.PROJECT
  description  = "Train instance"
  tags         = ["adeo", "internet", "ssh", "teradata"]

  boot_disk {
    initialize_params {
      image = var.OS_IMAGE
      size  = var.TRAIN_BOOT_SIZE
    }
  }

  network_interface {
    network    = var.NETWORK
    subnetwork = var.SUBNET
    network_ip = google_compute_address.internal_train.address
  }

  service_account {
    email  = var.COMPUTESERVICEACCOUNT
    scopes = ["cloud-platform"]
  }

  shielded_instance_config {
        enable_integrity_monitoring = true
        enable_secure_boot          = false
        enable_vtpm                 = true
    }
}