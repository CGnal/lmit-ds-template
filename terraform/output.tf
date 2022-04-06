output "service_account" {
  description = "The service account."
  value       = module.service_accounts
}

output "ip" {
  description = "Instance IP"
  value = "${google_compute_instance.default.network_interface[0].network_ip}"
}