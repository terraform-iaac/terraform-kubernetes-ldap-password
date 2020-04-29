variable "domain" {
  description = "(Required) Domain for the url. Generating url: ldap-passwd.[domain]"
}
variable "app_name" {
  description = "(Optional) Application name"
  default = "ldap-passwd"
}
variable "app_namespace" {
  description = "(Optional) Namespace name"
  default = "ldap-passwd"
}
variable "namespace_labels" {
  description = "(Optional) Add labels for namespace"
  default = null
}
variable "create_namespace" {
  description = "(Optional) Default 'false' value will create namespace in cluster. If you want use exist namespace set 'false' "
  default = true
}
variable "ports" {
  description = "(Optional) Port mapping"
  default = [
    {
      name = "web-access"
      internal_port = "8080"
      external_port = "80"
    }
  ]
}
variable "web_internal_port" {
  description = "(Optional) Connect URL to Container internal port. !Note! If this value changed, need specify new ports in var.ports"
  default = [
    {
      sub_domain = "ldap-passwd."
      internal_port = "8080"
    }
  ]
}
variable "tls" {
  description = "(Optional) Define TLS , for use only HTTPS"
  default = []
}
variable "ingress_annotations" {
  description = "(Optional) Set addional annontations for ingress"
  default = {
    "kubernetes.io/ingress.class" = "nginx"
    "nginx.ingress.kubernetes.io/whitelist-source-range" = ""
  }
}
variable "image_tag" {
  description = "(Optional) Docker image tag for ldap-passwd-webui"
  default = "latest"
}
variable "volume_host_path" {
  description = "(Optional) Create HostPath volume"
  default = []
}
variable "volume_nfs" {
  description = "(Optional) Create NFS volume"
  default = []
}
variable "volume_config_map" {
  description = "(Optional) Create ConfigMap volume"
  default = [
    {
      mode = "0400"
      name = "settings.ini"
      volume_name = "settings-ini"
    }
  ]
}
variable "volume_mount" {
  default = [
    {
      mount_path = "/opt/settings.ini"
      sub_path = "settings.ini"
      volume_name = "settings-ini"
    }
  ]
}
#VARIABLES FOR SETTINGS.INI
variable "page_title" {
  description = "(REQUIRED)Message which will be displayed on page header"
  default = ""
}
variable "ldap_host" {
  description = "(REQUIRED)IP adress or DNS name which will be connected to"
  default = ""
}
variable "ldap_port" {
  description = "(REQUIRED) Port on ldap server, if USE_SSL=true need to use port 636"
  default = ""
}
variable "use_ssl" {
  description = "(REQUIRED) True or False if is used False then connection is going to be insecure"
  default = ""
}
variable "ldap_base" {
  description = "(REQUIRED) LDAP base example: dc=example,dc=com"
  default = ""
}
# For AD / Samba 4
variable "dc_type" {
  description = "(OPTIONAL) If need to use AD or Samba 4 - Domain controller type"
  default = "ad"
}
variable "ad_domain" {
  description = "(REQUIRED) If need to use AD or Samba 4 - Directory domain e.g. example.com"
  default = ""
}
variable "ad_search_filter" {
  description = "(OPTIONAL) If need to use AD or Samba 4 - Ldap filrter that is used to find user"
  default = "sAMAccountName={uid}"
}
# ldappasswd server
variable "server" {
  description = "(OPTIONAL) - ldap-passwd application mode"
  default = "auto"
}
variable "server_host" {
  description = "(OPTIONAL) - ldap-passwd server host"
  default = "0.0.0.0"
}
variable "server_port" {
  description = "(OPTIONAL) - ldap-passwd server port"
  default = "8080"
}
#END OF VARIABLES FOR SETTINGS.INI
variable "env" {
  default = [
    {
      name = "CONF_FILE"
      value = "/opt/settings.ini"
    }
  ]
}
