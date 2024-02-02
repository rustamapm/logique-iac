resource "google_secret_manager_secret" "github_token_secret" {
    project =  var.project_id
    secret_id = "github_token_id"

    replication {
        auto {}
    }
}

resource "google_secret_manager_secret_version" "github_token_version" {
  secret  = google_secret_manager_secret.github_token_secret.id
  secret_data = var.github_token
}


data "google_iam_policy" "serviceagent_secretAccessor" {
    binding {
        role = "roles/secretmanager.secretAccessor"
        members = ["serviceAccount:service-223144838879@gcp-sa-cloudbuild.iam.gserviceaccount.com"]
    }
}

resource "google_secret_manager_secret_iam_policy" "policy" {
  project = google_secret_manager_secret.github_token_secret.project
  secret_id = google_secret_manager_secret.github_token_secret.secret_id
  policy_data = data.google_iam_policy.serviceagent_secretAccessor.policy_data
}

resource "google_cloudbuildv2_connection" "github_connection" {
  name     = "github_connection"
  project =  var.project_id
  location = var.region

  github_config {
    app_installation_id = 32453791
    authorizer_credential {
      oauth_token_secret_version = "projects/223144838879/secrets/github_token_id/versions/latest"
    }
  }
depends_on = [
    google_secret_manager_secret_version.github_token_version
 ]
}

resource "google_cloudbuildv2_repository" "app_nodejs_repository" {
  project           =  var.project_id
  location          = var.region
  name              = "logique_app_nodejs"
  parent_connection = google_cloudbuildv2_connection.github_connection.id
  remote_uri        = "https://github.com/rustamapm/logique-app-nodejs.git"
}

resource "google_cloudbuildv2_repository" "app_reactjs_repository" {
  project           =  var.project_id
  location          = var.region
  name              = "logique_app_reactjs"
  parent_connection = google_cloudbuildv2_connection.github_connection.id
  remote_uri        = "https://github.com/rustamapm/logique-app-reactjs.git"
}

resource "google_cloudbuild_trigger" "trigger_app_reactjs" {
  project           =  var.project_id
  name        = "trigger-app-reactjs"
  description = "A trigger for changes on the master branch"
  location    = var.region

  repository_event_config {
    repository = google_cloudbuildv2_repository.app_reactjs_repository.id
    push {
      branch = "main"
    }
  }
  build {
    step {
      name       = "gcr.io/cloud-builders/docker"
      args       = ["build", "-t", "asia-southeast2-docker.pkg.dev/logique-devops/logique-registry/app-reactjs:$BRANCH_NAME", "."]
    }
    images = ["asia-southeast2-docker.pkg.dev/logique-devops/logique-registry/app-reactjs:$BRANCH_NAME"]
  }
}

resource "google_cloudbuild_trigger" "trigger_app_nodejs" {
  project     =  var.project_id
  name        = "trigger-app-nodejs"
  description = "A trigger for changes on the master branch"
  location    = var.region

  repository_event_config {
    repository = google_cloudbuildv2_repository.app_nodejs_repository.id
    push {
      branch = "main"
    }
  }
  build {
    step {
      name       = "gcr.io/cloud-builders/docker"
      args       = ["build", "-t", "asia-southeast2-docker.pkg.dev/logique-devops/logique-registry/app-nodejs:$BRANCH_NAME", "."]
    }
    images = ["asia-southeast2-docker.pkg.dev/logique-devops/logique-registry/app-nodejs:$BRANCH_NAME"]
  }
}