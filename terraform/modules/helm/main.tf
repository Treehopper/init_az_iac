provider "helm" {
  kubernetes {
    host                   =  var.host
    client_certificate     =  var.client_certificate
    client_key             =  var.client_key
    cluster_ca_certificate =  var.cluster_ca_certificate
  }
}

resource "helm_release" "example-app" {
  name       = "example-app"
  chart      = "./modules/helm/charts/example-app"

  values = [
    "${file("./modules/helm/charts/example-app/example-app-01.values.yml")}"
  ]
}