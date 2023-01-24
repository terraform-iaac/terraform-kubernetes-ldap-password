resource "kubernetes_namespace" "namespace" {
  count = var.create_namespace == true ? 1 : 0

  metadata {
    annotations = {
      name = var.app_namespace
    }
    labels = var.namespace_labels
    name   = var.app_namespace
  }
}

resource "kubernetes_config_map" "settings" {
  metadata {
    name      = "settings.ini"
    namespace = var.create_namespace == true ? kubernetes_namespace.namespace[0].id : var.app_namespace
  }

  data = {
    "settings.ini" = local.settings
  }
}

module "deploy" {
  source  = "terraform-iaac/deployment/kubernetes"
  version = "1.4.2"

  name              = var.app_name
  namespace         = var.create_namespace == true ? kubernetes_namespace.namespace[0].id : var.app_namespace
  image             = "magnaz/ldap-passwd-webui:${var.image_tag}"
  internal_port     = var.ports
  volume_nfs        = var.volume_nfs
  volume_host_path  = var.volume_host_path
  volume_config_map = var.volume_config_map
  volume_mount      = var.volume_mount
  env               = var.env
  node_selector     = var.node_selector
}

module "service" {
  source  = "terraform-iaac/service/kubernetes"
  version = "1.0.4"

  app_name      = var.app_name
  app_namespace = var.create_namespace == true ? kubernetes_namespace.namespace[0].id : var.app_namespace
  port_mapping  = var.ports
}

module "ingress" {
  source  = "terraform-iaac/ingress/kubernetes"
  version = "2.0.1"

  service_name      = var.app_name
  service_namespace = var.create_namespace == true ? kubernetes_namespace.namespace[0].id : var.app_namespace
  domain_name       = "${var.subdomain}${var.domain}"
  rule              = var.ports

  tls               = var.tls_secrets_name
  tls_hosts         = var.tls_secret_name == null ? null : [
    {
      secret_name = var.tls_secret_name
      hosts       = ["${var.subdomain}${var.domain}"]
    }
  ]
  ingress_class_name = var.ingress_class_name
  annotations       = var.ingress_annotations
}
