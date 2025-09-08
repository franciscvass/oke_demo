# Terraform OKE for Oracle Cloud Infrastructure

- The code will use the OCI OKE terraform module from [here](https://registry.terraform.io/modules/oracle-terraform-modules/oke/oci/latest)
- The github code is published [here](https://github.com/oracle-terraform-modules/terraform-oci-oke)

## What will be deploy

- a VCN in which will create the Operator, Bastion and OKE
- 2 VM, one Bastion in a public subnet, one Operator in a private VCN from where you can manage the OKE
- an OKE cluster with node pools (depends on how *worker_pools* var is set)

## Variables

- There are 3 files **auto.tfvars* where you must provides variables values
- Var are described below

**provider_oci**

```
variable "provider_oci" {
  type = any
  default = {}
}
```
- Can be used instead of *config_profile_home_reg* and *config_profile_deploy_reg* to provide auth details
- Or use the below as example
```
provider_oci = {
  tenancy       = ".."
  user_id       = ".."
  fingerprint   = ".."
  key_file_path = ".."
  region        = ".." #The region where you deploy the OKE
  home_region   = ".." #The Tenancy home region
}
```
**worker_pools**

```
variable "worker_pools" {
  default     = {}
  description = "Tuple of OKE worker pools where each key maps to the OCID of an OCI resource, and value contains its definition."
  type        = any
}
```
- Used to provides details about the worker nodes in a pool

**kubernetes_version**

```
variable "kubernetes_version" {
  type    = string
  default = "v1.29.1"
}
```
- To provides the K8S version

**state_id**
```
variable "state_id" {
  type    = string
  default = "oke1"
}
```
- It will add this string to the name of Bastion,Operator, worker nodes and VCN.
- you will be able to identified the bastion,operator for each deployment

**compartment_id**

```
variable "compartment_id" {
  type    = string
  default = null
}
```
- The compartment where will. deploy the resources (Bastion, Operator, Cluster, VCN)

**bastion_allowed_cidrs**
```
variable "bastion_allowed_cidrs" {
  type = list
  default = ["0.0.0.0/0"]
}
```
- To allow ssh to Bastion from this network.
- the default is 0.0.0.0/0 (all networks) but it's not recommended

**vcn_name**

```
variable "vcn_name" {
  type = string
  default = "oke1"
}
```
- The name of VCN

**ssh_private_key_path**
**ssh_public_key_path**

```
variable "ssh_private_key_path" {
  type = string
}

variable "ssh_public_key_path" {
  type = string
}
```
- The path to ssh keys

**cluster_name**

```
variable "cluster_name" {
  type = string
  default = "oke1"
}
```
- The name of the cluster

**cluster_type**

```
variable "cluster_type" {
  type = string
  default = "enhanced"
}
```
- The type of cluster (basic or enhanced)

**cni_type**

```
variable "cni_type" {
  type = string
  default = "flannel"
}  
```

- The type of CNI (npn or flannel)

**config_profile_home_reg**
**config_profile_deploy_reg**

```
variable "config_profile_home_reg" {
  type = string  
}

variable "config_profile_deploy_reg" {
  type = string  
}
```
- The profile in your .oci/config to use for home region or for where you deploy the cluster (config_profile_deploy_reg) 
  
