# LDAP password changer

Terraform module for deploy & configure ldap-passwd-webui in K8S Cluster

## Wokrflow

Module deploy WebUI for manage LDAP password. Its comfortable resource for fast and flexible changing user's LDAP credentials inside your kubernetes cluster.

## Software Requirements

Name | Description
--- | --- |
Terraform | >= v1.0.0
Helm provider | >= 2.8.0
Kubernetes provider | >= 2.17.0

## Usage

```shell script
module "ldap_passwd" {
  source = "git::https://github.com/terraform-iaac/terraform-kubernetes-ldap-password.git"
  
  domain = "example.com"
  app_name = "ldap-passwd"
  app_namespace = "ldap-passwd"
  
  #VARIABLES FOR SETTINGS.INI
  page_title = "Change your password on example.com domain"
  ldap_host = "10.10.0.89"
  ldap_port = "389"
  use_ssl = "false"
  ldap_base = "dc=example,dc=com"
  
  # For AD / Samba 4
  dc_type = "ad"
  ad_domain = "example.com"
  ad_search_filter = "sAMAccountName={uid}"
  
  # ldappasswd server
  server = "auto" 
  server_host = "0.0.0.0" 
  server_port = "8080" 
  #END OF VARIABLES FOR SETTINGS.INI
}
```

## Inputs

Name | Description                                                                                        | Type                                                                                                               | Default                                                                                                                                      | Example              | Required
--- |----------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------|----------------------|--- 
env | Environment variables                                                                              | <pre>list(object({<br>    name = string<br>    value = string<br>  }))</pre>                                       | <pre>[<br>  {<br>    name  = "CONF_FILE"<br>    value = "/opt/settings.ini"<br>  }<br>]</pre>                                                | n/a                  | no
node_selector | Specify node selector for pod                                                                      | `map(string)`                                                                                                      | `null`                                                                                                                                       | n/a                  | no
domain | Domain for the url.                                            | `string`                                                                                                           | n/a                                                                                                                                          | `example.com`        | yes
subdomain | Subdomain for the domain. Generating url: ldap-passwd.[domain]                                     | `string`                                                                                                           | ldap-passwd.                                                                                                                                 | `cusomsub.`          | no
app_name | Application name                                                                                   | `string`                                                                                                           | `ldap-passwd`                                                                                                                                | n/a                  | no |
app_namespace | (Optional) Namespace name                                                                          | `string`                                                                                                           | `ldap-passwd`                                                                                                                                | n/a                  | no |
namespace_labels | Add labels for namespace                                                                           | `string`                                                                                                           | `null`                                                                                                                                       | n/a                  | no
create_namespace | Default 'false' value will create namespace in cluster. If you want use exist namespace set 'false' | `bool`                                                                                                             | true                                                                                                                                         | n/a                  | no
ports | Port mapping                                                                                       | <pre>list(object({<br>    name = string<br>    internal_port = string<br>    external_port = string<br>  }))</pre> | <pre>[<br>  {<br>    name  = "web-access"<br>    internal_port = "8080"<br>   external_port = "80"<br>  }<br>]</pre>                         | n/a                  | no
tls_secrets_name | (Optional) Secrets name with SSL certificate for domains in ingress                                | `list(string)`                                                                                                     | `[]`                                                                                                                                         | `[secret1, secret2]` | no
tls_secret_name | (Optional) Secret name with SSL certificate for main domain only in ingress                        | `string`                                                                                                           | `null`                                                                                                                                       | mysecret             | no
ingress_annotations | (Optional) Set additional annontations for ingress                                                   | <pre>object({<br>   name = value<br>})</pre>                                                                       | <pre>{<br>   "kubernetes.io/ingress.class" = "nginx"<br>}</pre>                                                                              | n/a                  | no
ingress_class_name | (Optional) Ingress Class name in ingress                                                   | `string`                                                                                                           | `nginx`                                                                                                                                      | `nginx-controller` | no
image_tag | Docker image tag for ldap-passwd-webui                                                             | `string`                                                                                                           | `latest`                                                                                                                                     | `v1.0abc`            | no
volume_host_path | Create HostPath volume                                                                             | `list(string)`                                                                                                     | `[]`                                                                                                                                         | n/a                  | no
volume_nfs | Create NFS volume                                                                                  | `list(string)`                                                                                                     | `[]`                                                                                                                                         | n/a                  | no
volume_config_map | Create ConfigMap volume                                                                            | <pre>list(object({<br>    mode = string<br>    name = string<br>    volume_name = string<br>  }))</pre>            | <pre>[<br>  {<br>    mode = "0400"<br>    name = "settings.ini"<br>    volume_name = "settings-ini"<br>  }<br>]</pre>                        | n/a                  | no
volume_mount | Volume mount to deployment                                                                         | <pre>list(object({<br>    mount_path = string<br>    sub_path = string<br>    volume_name = string<br>  }))</pre>  | <pre>[<br>  {<br>    mount_path = "/opt/settings.ini"<br>    sub_path = "settings.ini"<br>    volume_name = "settings-ini"<br>  }<br>]</pre> | n/a                  | no

### VARIABLES FOR SETTINGS.INI
Name | Description | Type | Default | Example | Required
--- | --- | --- | --- |--- |--- 
page_title | Message which will be displayed on page header | `string` | n/a | `Change your password on example.com domain` | yes
ldap_host | IP adress or DNS name which will be connected to | `string` | n/a | "10.10.0.89" | yes
ldap_port | Port on ldap server, if USE_SSL=true need to use port 636 | `string` | n/a | `389` | yes
use_ssl | True or False if is used False then connection is going to be insecure | `string` | n/a | `false` | yes
ldap_base | LDAP base | `string` | n/a | `dc=example,dc=com` | yes

### For AD / Samba 4
Name | Description | Type | Default | Example | Required
--- | --- | --- | --- |--- |--- 
dc_type | If need to use AD or Samba 4 - Domain controller type | `string` | `ad` | n/a | no
ad_domain | If need to use AD or Samba 4 - Directory domain e.g. example.com | `string` | n/a | `example.com` | yes
ad_search_filter | If need to use AD or Samba 4 - Ldap filrter that is used to find user | `string` | `sAMAccountName={uid}` | n/a | no

### LDAPpasswd server
Name | Description | Type | Default | Example | Required
--- | --- | --- | --- |--- |--- 
server | Application mode | `string` | `auto` | n/a | no
server_host | Server host | `string` | `0.0.0.0` | n/a | no
server_port | Server port | `string` | `8080` | `12345` | no

## Outputs
Name | Description
--- | --- 
namespace | Name of namespace where dashboard deployed
urls | URL for access to 'LDAP password change' via web-browser

