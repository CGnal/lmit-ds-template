// see https://www.terraform.io/docs/providers/google/provider_reference.html 
provider "google-beta" {
  project = var.PROJECT
  region  = var.LOCATION
  zone    = var.ZONE
  version = "~> 2.18.0"
}

provider "google" {
  version = "~> 2.18.0"
}

provider "kubernetes" {
  version                = "1.10.0" // On 2020.02.25 version 1.11.0 (latest) causes error
  load_config_file       = false
  host                   = "https://${google_container_cluster.k8smain.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(google_container_cluster.k8smain.master_auth.0.cluster_ca_certificate)
}
