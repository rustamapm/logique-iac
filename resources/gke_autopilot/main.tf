locals {
  cluster_type           = "cluster-autopilot-logique"
  network_name           = "vpc-logique"
  subnet_name            = "subnet-gke"
  master_auth_subnetwork = "subnet-vm"
  pods_range_name        = "ip-range-pods-subnet-gke"
  svc_range_name         = "ip-range-svc-subnet-gke"
  subnet_names           = [for subnet_self_link in module.gcp-network.subnets_self_links : split("/", subnet_self_link)[length(split("/", subnet_self_link)) - 1]]
}


data "google_client_config" "default" {}

provider "kubernetes" {
  host                   = "https://${module.gke.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke.ca_certificate)
}

module "gke" {
  source  = "terraform-google-modules/kubernetes-engine/google//modules/beta-autopilot-private-cluster"
  version = "~> 29.0"

  project_id                      = var.project_id
  name                            = "${local.cluster_type}-cluster"
  regional                        = true
  region                          = var.region
  network                         = module.gcp-network.network_name
  subnetwork                      = local.subnet_names[index(module.gcp-network.subnets_names, local.subnet_name)]
  ip_range_pods                   = local.pods_range_name
  ip_range_services               = local.svc_range_name
  release_channel                 = "REGULAR"
  enable_vertical_pod_autoscaling = true
  enable_private_endpoint         = true
  enable_private_nodes            = true
  master_ipv4_cidr_block          = "172.16.0.0/28"
  network_tags                    = [local.cluster_type]
  deletion_protection             = false

  master_authorized_networks = [
    {
      cidr_block   = "10.60.0.0/17"
      display_name = "subnet-vm"
    },
  ]
}