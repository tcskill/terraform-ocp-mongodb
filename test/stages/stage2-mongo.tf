module "tools_mongo" {
  source = "./module"

  cluster_config_file      = module.cluster.config_file_path
  cluster_type             = module.cluster.platform.type_code
  cluster_ingress_hostname = module.cluster.platform.ingress
  tls_secret_name          = module.cluster.platform.tls_secret
  
  mongo_namespace    = var.mongo_namespace
}
