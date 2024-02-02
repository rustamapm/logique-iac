resource "google_compute_firewall" "inbound-ip-ssh" {
    name        = "allow-incoming-ssh-from-iap"
    project     = var.project_id
    network     = "default"

    direction = "INGRESS"
    allow {
        protocol = "tcp"
        ports    = ["22"]  
    }
    source_ranges = [
        "35.235.240.0/20"
    ]
    target_service_accounts = ["725321523176-compute@developer.gserviceaccount.com"]
}

resource "google_iap_tunnel_iam_member" "allow-remote-access-to-iap" {
    project = var.project_id
    role    = "roles/iap.tunnelResourceAccessor"
    member  = "service_account:725321523176-compute@developer.gserviceaccount.com"

    condition {
      title = "allow_remote_access_to_iap"
      description = "Allow access to IAP tunnel for authorized users"
      expression = "\"accessPolicies/<access-policy-id>/accessLevels/<my-access-level-name>\" in request.auth.access_levels"
    }
}

locals {
    compute_roles = [ 
        "roles/compute.viewer",
        "roles/compute.osLogin",
    ]
}

# Apply the roles to a user account
resource "google_project_iam_member" "assign-roles" {
    count   = length(local.compute_roles)
    project = var.project_id
    role    = local.roles[count.index]
    member  = "service_account:725321523176-compute@developer.gserviceaccount.com"
}