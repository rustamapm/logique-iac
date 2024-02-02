resource "google_artifact_registry_repository" "my-repo" {
  project       = var.project_id
  location      = var.region
  repository_id = "logique-registry"
  description   = "example docker repository"
  format        = "DOCKER"
}