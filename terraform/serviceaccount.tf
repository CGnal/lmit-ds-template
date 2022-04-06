module "service_accounts" {
  source        = "terraform-google-modules/service-accounts/google"
  version       = "~> 2.0"
  project_id    = var.PROJECT
  names         = ["datafinder"]
  generate_keys = "true"
  project_roles = ["${var.PROJECT}=>roles/bigquery.admin"]
}

module "service_accounts" {
  source        = "terraform-google-modules/service-accounts/google"
  version       = "~> 2.0"
  project_id    = var.PROJECT
  names         = ["compute_engine"]
  generate_keys = "false"
  project_roles = ["${var.PROJECT}=>roles/compute.admin"]
}
