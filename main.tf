locals {
  bin_dir = module.setup_clis.bin_dir
  tmp_dir = "${path.cwd}/.tmp"
}


module setup_clis {
  source = "github.com/cloud-native-toolkit/terraform-util-clis.git"

  clis = ["helm"]
}

resource "null_resource" "deploy_MongoCRD" {
  triggers = {
    namespace = var.mas_mongo_namespace
    kubeconfig = var.cluster_config_file
  }

  provisioner "local-exec" {
    command = "${path.module}/scripts/deployMongoCRD.sh ${self.triggers.namespace}"

    environment = {
      KUBECONFIG = self.triggers.kubeconfig
    }
  }

  provisioner "local-exec" {
    when = destroy
    command = "${path.module}/scripts/deployMongoCRD.sh ${self.triggers.namespace} destroy"

    environment = {
      KUBECONFIG = self.triggers.kubeconfig
    }
  }
} 

resource "null_resource" "deploy_mongoClusterRole" {
  triggers = {
    namespace = var.mas_mongo_namespace
    msaname = var.mas_mongo_serviceaccount
    kubeconfig = var.cluster_config_file
  }

  provisioner "local-exec" {
    command = "${path.module}/scripts/configMongoClusterRole.sh ${self.triggers.msaname} ${self.triggers.namespace}"

    environment = {
      KUBECONFIG = self.triggers.kubeconfig
    }
  }

  provisioner "local-exec" {
    when = destroy
    command = "${path.module}/scripts/configMongoClusterRole.sh ${self.triggers.msaname} ${self.triggers.namespace} destroy"

    environment = {
      KUBECONFIG = self.triggers.kubeconfig
    }
  }
} 