terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 3.0"
    }
  }
}

provider "google" {
  #credentials = var.creds_file
  project     = var.gcp_project_id
  region      = var.region
  zone        = var.zone
}

resource "google_compute_address" "static" {
  name = "ipv4-address"
}

resource "google_compute_instance" "default" {
  name         = var.vm_name
  machine_type = var.vm_type

  tags = ["iap-tunnels"]

  boot_disk {
    initialize_params {
      image = var.vm_image
      type = var.vm_image_type
    }
  }

  network_interface {
    network = "vpc-logique"
    subnetwork = "subnet-vm"
  }

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = var.service_account_email
    scopes = ["cloud-platform"]
  }

  metadata_startup_script = file(var.metadata_script)
}