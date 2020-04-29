module "ldap_passwd" {
  source = "../"
  domain = "example.com"
  app_name = "ldap-passwd" #OPTIONAL
  app_namespace = "ldap-passwd" #OPTIONAL
  #VARIABLES FOR SETTINGS.INI
  page_title = "Change your password on example.com domain"
  ldap_host = "10.10.0.89"
  ldap_port = "389"
  use_ssl = "false"
  ldap_base = "dc=example,dc=com"
  # For AD / Samba 4
  dc_type = "ad"
  ad_domain = "example.com"
  ad_search_filter = "sAMAccountName={uid}" #OPTIONAL
  # ldappasswd server
  server = "auto" #OPTIONAL
  server_host = "0.0.0.0" #OPTIONAL
  server_port = "8080" #OPTIONAL
  #END OF VARIABLES FOR SETTINGS.INI