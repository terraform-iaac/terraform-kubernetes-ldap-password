variable "domain" {
  description = "(Required) Domain for the url. Generating url: change-passwd.[domain]"
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
      sub_domain = "change-passwd."
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
    "nginx.ingress.kubernetes.io/whitelist-source-range" = "10.0.0.0/8, 91.225.201.161/32"
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
variable "PAGE_TITLE" {
  description = "(REQUIRED)Message which will be displayed on page header"
  default = "Change your password on example.com domain"
}
variable "LDAP_HOST" {
  description = "(REQUIRED)IP adress or DNS name which will be connected to"
  default = "10.10.0.89"
}
variable "LDAP_PORT" {
  description = "(REQUIRED) Port on ldap server, if USE_SSL=true need to use port 636"
  default = "389"
}
variable "USE_SSL" {
  description = "(REQUIRED) True or False if is used False then connection is going to be insecure"
  default = "false"
}
variable "LDAP_BASE" {
  description = "(REQUIRED) LDAP base example(dc=example,dc=com)"
  default = "dc=example,dc=com"
}
/*
variable "LDAP_SEARCH_FILTER" {
  description = "(OPTIONAL) SHOULD SPECIFY AND UNCOMMENT IN ../SETTINGS.INI ONLY IF YOU INTEND TO USE NOT AD OR SAMBA 4 DC TYPE - Ldap filrter that is used to find user"
  default = ""
}
*/
# For AD / Samba 4
variable "DC_TYPE" {
  description = "(OPTIONAL) If need to use AD or Samba 4 - Domain controller type"
  default = "ad"
}
variable "AD_DOMAIN" {
  description = "(OPTIONAL) If need to use AD or Samba 4 - Directory domain"
  default = "example.com"
}
variable "AD_SEARCH_FILTER" {
  description = "(OPTIONAL) If need to use AD or Samba 4 - Ldap filrter that is used to find user"
  default = "sAMAccountName={uid}"
}
# ldappasswd server
variable "SERVER" {
  description = "(REQUIRED) - ldap-passwd application mode"
  default = "auto"
}
variable "SERVER_HOST" {
  description = "(REQUIRED) - ldap-passwd server host"
  default = "0.0.0.0"
}
variable "SERVER_PORT" {
  description = "(REQUIRED) - ldap-passwd server port"
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
