
variable "cluster_config_file" {
  type        = string
  description = "Cluster config file for Kubernetes cluster."
}

variable "cluster_ingress_hostname" {
  type        = string
  description = "Ingress hostname of the IKS cluster."
}

variable "cluster_type" {
  description = "The cluster type (openshift or ocp3 or ocp4 or kubernetes)"
  default = "ocp4"
}

variable "tls_secret_name" {
  type        = string
  description = "The secret containing the tls certificates"
  default = ""
}

variable "mas_mongo_namespace" {
  type        = string
  description = "Namespace where MongoDB is deployed"
  default = "mongo"
}

variable "mas_mongo_storageclass" {
  type        = string
  description = "Storageclass for MongoDB"
  default = "ibmc-vpc-block-10iops-tier"
}
