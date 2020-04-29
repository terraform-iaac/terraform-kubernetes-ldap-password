resource "kubernetes_namespace" "namespace" {
 count = var.create_namespace == true ? 1 : 0
  metadata {
    annotations = {
      name = var.app_namespace
    }
    labels = var.namespace_labels
    name = var.app_namespace
  }
}

resource "kubernetes_config_map" "settings" {
  metadata {
    name = "settings.ini"
    namespace = var.app_namespace
  }
  data = {
    "settings.ini" = data.template_file.settings.rendered
  }
}

module "deploy" {
  source = "git::https://github.com/greg-solutions/terraform_k8s_deploy.git"
  name = var.app_name
  namespace = var.create_namespace == true ? kubernetes_namespace.namespace[0].id : var.app_namespace
  image = "magnaz/ldap-passwd-webui:${var.image_tag}"
  internal_port = var.ports
  volume_nfs = var.volume_nfs
  volume_host_path = var.volume_host_path
  volume_config_map = var.volume_config_map
  volume_mount = var.volume_mount
  env = var.env
}

module "service" {
  source = "git::https://github.com/greg-solutions/terraform_k8s_service.git"
  app_name = var.app_name
  app_namespace = var.create_namespace == true ? kubernetes_namespace.namespace[0].id : var.app_namespace
  port_mapping = var.ports
}

module "ingress" {
  source = "git::https://github.com/greg-solutions/terraform_k8s_ingress.git"
  app_name = var.app_name
  app_namespace = var.create_namespace == true ? kubernetes_namespace.namespace[0].id : var.app_namespace
  domain_name = var.domain
  web_internal_port = var.web_internal_port
  tls = var.tls
  annotations = var.ingress_annotations
}
