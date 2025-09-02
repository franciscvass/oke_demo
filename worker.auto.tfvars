worker_pools = {
  #gpu_node_pool = {
  #  description = "OKE-managed Node Pool GPU",
  #  create      = true,
  #  mode        = "node-pool",
  #  shape       = "VM.GPU.A10.1",
  #  size        = 1,
  #  size_max    = 1,
  #  os          = "Oracle Linux",
  #  os_version  = "8",
  #  autoscale   = true,
  #  boot_volume_size = 250
  #}
  non_gpu_node_pool = {
    description = "OKE-managed Node Pool",
    create      = true,
    mode        = "node-pool",
    size        = 1,
    size_max    = 3,
    os          = "Oracle Linux",
    os_version  = "8",
    image_type  = "oke",
    autoscale   = true,
    shape       = "VM.Standard.E5.Flex",
    ocpus       =  "2",
    memory      = "16"
  }
}
