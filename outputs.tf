
output "mongo_pw" {
  value       = var.mongo_password
  description = "mongo admin pw"
  depends_on  = [
    null_resource.deploy_instance
  ]
}

output "mongo_namespace" {
  value       = var.mongo_namespace
  description = "Namespace mongo is located in cluster"
  depends_on  = [
    null_resource.deploy_instance
  ]
}

output "mongo_servicename" {
  description = "Name of mongo service to connect to"
  depends_on  = [
    null_resource.deploy_instance
  ]
  value       = data.local_file.svcname.content
}

