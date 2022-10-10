terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "=2.5.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "tfstate-rg"
    storage_account_name = "tfstate"
    container_name       = "core-tfstate"
    key = "tfstate"
  }

}

provider "azurerm" {
  subscription_id = var.subscription_id
  client_id       = var.serviceprinciple_id
  client_secret   = var.serviceprinciple_key
  tenant_id       = var.tenant_id

  features {}
}

module "service_principal" {
}

module "gitops_pipeline" {
}

module "cluster" {
  source                = "./modules/cluster/"
  serviceprinciple_id   = var.serviceprinciple_id
  serviceprinciple_key  = var.serviceprinciple_key
  ssh_key               = var.ssh_key
  location              = var.location
  kubernetes_version    = var.kubernetes_version  
}

module "helm" {
  source                = "./modules/helm/"
  host                  = "${module.cluster.host}"
  client_certificate    = "${base64decode(module.cluster.client_certificate)}"
  client_key            = "${base64decode(module.cluster.client_key)}"
  cluster_ca_certificate= "${base64decode(module.cluster.cluster_ca_certificate)}"
}
