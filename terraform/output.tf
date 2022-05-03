output "train_ip" {
  description = "TrainInstance IP"
  value       = google_compute_instance.train.network_interface[0].network_ip
}

output "exec_ip" {
  description = "ExecInstance IP"
  value       = google_compute_instance.execution.network_interface[0].network_ip
}