# How to Run Terraform to Create GCP Resource
Every feature GCP separated on each folder but some feature already included with another because dependency

### Enabled APIs & Services

```yaml
- cd resources/gcp_services_api
- terraform init
- terraform plan
- terraform apply
```

### Create GKE Cluster & VPC

```yaml
- cd resources/gke_autopilot
- terraform init
- terraform plan
- terraform apply
```

### Create Artifact Registry

```yaml
- cd resources/artifact_registry
- terraform init
- terraform plan
- terraform apply
```

### Create Cloud Build & Secret Manager

```yaml
- cd resources/cloudbuild
- terraform init
- terraform plan
- terraform apply
```

### Create Compute Engine

```yaml
- cd resources/compute_engine
- terraform init
- terraform plan
- terraform apply
```

### Create Identity Aware Proxy

```yaml
- cd resources/iap_tunnelling
- terraform init
- terraform plan
- terraform apply
```

### Create CloudSQL

```yaml
- cd resources/postgresql
- terraform init
- terraform plan
- terraform apply
```