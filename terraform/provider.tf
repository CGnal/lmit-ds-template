// see https://www.terraform.io/docs/providers/google/provider_reference.html 
provider "google-beta" {
  project = var.PROJECT
  region  = var.LOCATION
  zone    = var.ZONE
}

provider "google" {
}

provider "kubernetes" {
  load_config_file       = false
  host                   = "https://${google_container_cluster.k8smain.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(google_container_cluster.k8smain.master_auth.0.cluster_ca_certificate)
}