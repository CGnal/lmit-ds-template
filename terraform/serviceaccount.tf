module "datafinder_sa" {
  source        = "terraform-google-modules/service-accounts/google"
  version       = "~> 2.0"
  project_id    = var.PROJECT
  names         = ["datafinder"]
  generate_keys = "true"
  project_roles = ["${var.PROJECT}=>roles/bigquery.admin"]
}

module "compute_engine_sa" {
  source        = "terraform-google-modules/service-accounts/google"
  version       = "~> 2.0"
  project_id    = var.PROJECT
  names         = ["compute-engine"]
  generate_keys = "false"
  project_roles = ["${var.PROJECT}=>roles/compute.admin"]
}

module "gdrive_sa" {
  source        = "terraform-google-modules/service-accounts/google"
  version       = "~> 2.0"
  project_id    = var.PROJECT
  names         = ["gdrive"]
  generate_keys = "true"
  project_roles = ["${var.PROJECT}=>roles/viewer"]
}
