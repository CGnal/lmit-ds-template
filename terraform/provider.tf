// see https://registry.terraform.io/providers/hashicorp/google/latest/docs
provider "google-beta" {
  project = var.PROJECT
  region  = var.REGION
  zone    = var.ZONE
}

provider "google" {
  project = var.PROJECT
  region  = var.REGION
  zone    = var.ZONE
}
