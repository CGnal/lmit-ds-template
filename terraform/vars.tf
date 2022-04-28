variable "PROJECT" {
}

variable "ZONE" {
  default = "europe-west1-c"
}

variable "REGION" {
  default = "europe-west1"
}

variable "INSTANCENAME" {
  default = "execution"
}

variable "TRAIN_INSTANCENAME" {
  default = "train"
}

variable "NETWORK" {
  default = "https://www.googleapis.com/compute/v1/projects/lh-itlm/global/networks/lh-network"
}

variable "SUBNET" {
}

variable "NODETYPE" {
  default = "e2-standard-4"
}

variable "TRAIN_NODETYPE" {
  default = "n2-standard-64"
}

variable "BOOT_SIZE" {
  default = 100
}

variable "TRAIN_BOOT_SIZE" {
  default = 100
}

variable "OS_IMAGE" {
  default = "debian-cloud/debian-10"
}

variable "COMPUTESERVICEACCOUNT" {
}
