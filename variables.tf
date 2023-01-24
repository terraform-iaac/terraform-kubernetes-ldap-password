variable "domain" {
  type        = string
  description = "(Required) Domain for the url. Generating url: ldap-passwd.[domain]"
}
variable "app_name" {
  type        = string
  description = "(Optional) Application name"
  default     = "ldap-passwd"
}
variable "app_namespace" {
  type        = string
  description = "(Optional) Namespace name"
  default     = "ldap-passwd"
}
variable "namespace_labels" {
  description = "(Optional) Add labels for namespace"
  default     = null
}
variable "create_namespace" {
  type        = bool
  description = "(Optional) Default 'false' value will create namespace in cluster. If you want use exist namespace set 'false' "
  default     = true
}
variable "ports" {
  description = "(Optional) Port mapping"
  default = [
    {
      name          = "web-access"
      internal_port = "8080"
      external_port = "80"
    }
  ]
}
variable "subdomain" {
  default = "ldap-passwd."
}
variable "tls_secrets_name" {
  type        = list(string)
  description = "(Optional) Secrets name with SSL certificate for all domains in ingress"
  default     = []
}
variable "tls_secret_name" {
  description = "(Optional) Secret name with SSL certificate for main domain only in ingress"
  type        = string
  default     = null
}
variable "ingress_class_name" {
  description = "(Optional) Ingress Class name in ingress"
  default     = "nginx"
  type        = string
}
variable "ingress_annotations" {
  description = "(Optional) Set additional annontations for ingress"
  default = {
    "kubernetes.io/ingress.class" = "nginx"
  }
}
variable "image_tag" {
  type        = string
  description = "(Optional) Docker image tag for ldap-passwd-webui"
  default     = "latest"
}
variable "volume_host_path" {
  description = "(Optional) Create HostPath volume"
  default     = []
}
variable "volume_nfs" {
  description = "(Optional) Create NFS volume"
  default     = []
}
variable "volume_config_map" {
  description = "(Optional) Create ConfigMap volume"
  default = [
    {
      mode        = "0400"
      name        = "settings.ini"
      volume_name = "settings-ini"
    }
  ]
}
variable "volume_mount" {
  default = [
    {
      mount_path  = "/opt/settings.ini"
      sub_path    = "settings.ini"
      volume_name = "settings-ini"
    }
  ]
}
#VARIABLES FOR SETTINGS.INI
variable "page_title" {
  type        = string
  description = "(Required) Message which will be displayed on page header"
}
variable "ldap_host" {
  type        = string
  description = "(Required) IP adress or DNS name which will be connected to"
}
variable "ldap_port" {
  type        = string
  description = "(Required) Port on ldap server, if USE_SSL=true need to use port 636"
}
variable "use_ssl" {
  type        = bool
  description = "(Required) True or False if is used False then connection is going to be insecure"
}
variable "ldap_base" {
  type        = string
  description = "(Required) LDAP base example: dc=example,dc=com"
}
# For AD / Samba 4
variable "dc_type" {
  type        = string
  description = "(OPTIONAL) If need to use AD or Samba 4 - Domain controller type"
  default     = "ad"
}
variable "ad_domain" {
  type        = string
  description = "(Required)  If need to use AD or Samba 4 - Directory domain e.g. example.com"
}
variable "ad_search_filter" {
  type        = string
  description = "(Optional) If need to use AD or Samba 4 - Ldap filrter that is used to find user"
  default     = "sAMAccountName={uid}"
}
# ldappasswd server
variable "server" {
  type        = string
  description = "(Optional) - ldap-passwd application mode"
  default     = "auto"
}
variable "server_host" {
  type        = string
  description = "(Optional) - ldap-passwd server host"
  default     = "0.0.0.0"
}
variable "server_port" {
  type        = string
  description = "(Optional) - ldap-passwd server port"
  default     = "8080"
}
#END OF VARIABLES FOR SETTINGS.INI
variable "env" {
  default = {
    "CONF_FILE" = "/opt/settings.ini"
  }
}
variable "node_selector" {
  description = "(Optional) Specify node selector for pod"
  type        = map(string)
  default     = null
}