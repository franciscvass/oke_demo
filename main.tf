locals {
  cinit = filebase64("${path.root}/global_cloud_init.sh")
}

# In case you are using oci config file
provider "oci" {
  config_file_profile = var.config_profile_home_reg
  alias = "home"
}

# In case you are using API key 

#provider "oci" {
#  region           = var.provider_oci.home_region
#  tenancy_ocid     = var.provider_oci.tenancy
#  user_ocid        = var.provider_oci.user_id
#  fingerprint      = var.provider_oci.fingerprint
#  private_key_path = var.provider_oci.key_file_path
#  alias = "home"
#}

# In case you are using oci config file
provider "oci" {
  config_file_profile = var.config_profile_deploy_reg
}

# In case you are using API key 

#provider "oci" {
#  region           = var.provider_oci.region
#  tenancy_ocid     = var.provider_oci.tenancy
#  user_ocid        = var.provider_oci.user_id
#  fingerprint      = var.provider_oci.fingerprint
#  private_key_path = var.provider_oci.key_file_path
#}



module "oke" {
  source                = "oracle-terraform-modules/oke/oci"
  kubernetes_version    = var.kubernetes_version
  state_id              = var.state_id
  providers             = { oci.home = oci.home }
  compartment_id        = var.compartment_id
  bastion_allowed_cidrs = var.bastion_allowed_cidrs
  vcn_name              = var.vcn_name
  
  ssh_private_key_path  = var.ssh_private_key_path
  ssh_public_key_path   = var.ssh_public_key_path
  # Change the shape if you do not have E5 flex
  bastion_shape         = { "boot_volume_size": 50, "memory": 4, "ocpus": 1, "shape": "VM.Standard.E5.Flex" }
  operator_shape        = { "boot_volume_size": 50, "memory": 4, "ocpus": 1, "shape": "VM.Standard.E5.Flex" }
  cluster_name          = var.cluster_name
  cluster_type          = var.cluster_type
  cni_type              = var.cni_type
  worker_pools          = var.worker_pools
  output_detail         = true
  allow_worker_ssh_access = true
  
  ##cloud init in case you need ...

  #worker_cloud_init = [
  #  {
  #    content      = filebase64("${path.root}/global_cloud_init.sh")
  #    content_type = "text/x-shellscript",
  #  }
  #]
  
  ## only need it if you deploy GPU node pool

  #cluster_addons = {
  #"NvidiaGpuPlugin" = {
  #  remove_addon_resources_on_delete = true
  #  override_existing = true           # Default is false if not specified
  #  }
  #}

}

output "apiserver_private_host" {
  value = module.oke.apiserver_private_host
}

output "bastion_public_ip" {
  value = module.oke.bastion_public_ip
}

output "operator_private_ip" {
  value = module.oke.operator_private_ip
}

output "ssh_to_operator" {
  value = module.oke.ssh_to_operator
}


