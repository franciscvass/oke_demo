
variable "provider_oci" {
  type = any
  default = {}
}

variable "worker_pools" {
  default     = {}
  description = "Tuple of OKE worker pools where each key maps to the OCID of an OCI resource, and value contains its definition."
  type        = any
}

variable "kubernetes_version" {
  type    = string
  default = "v1.29.1"
}

variable "state_id" {
  type    = string
  default = "oke1"
}

variable "compartment_id" {
  type    = string
  default = null
}

variable "bastion_allowed_cidrs" {
  type = list
  default = ["0.0.0.0/0"]
}

variable "vcn_name" {
  type = string
  default = "oke1"
}

variable "ssh_private_key_path" {
  type = string
}

variable "ssh_public_key_path" {
  type = string
}

variable "cluster_name" {
  type = string
  default = "oke1"
}

variable "cluster_type" {
  type = string
  default = "enhanced"
}

variable "cni_type" {
  type = string
  default = "flannel"
}  

variable "config_profile_home_reg" {
  type = string  
}

variable "config_profile_deploy_reg" {
  type = string  
}

  

