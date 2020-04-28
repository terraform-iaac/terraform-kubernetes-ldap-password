module "ldap_passwd" {
  source = "../"
  domain = "example.com"
  app_name = "ldap-passwd"
  app_namespace = "ldap-passwd"
  #VARIABLES FOR SETTINGS.INI
  PAGE_TITLE = "Change your password on example.com domain"
  LDAP_HOST = "10.10.0.89"
  LDAP_PORT = "389"
  USE_SSL = "false"
  LDAP_BASE = "dc=example,dc=com"
  # For AD / Samba 4
  DC_TYPE = "ad"
  AD_DOMAIN = "example.com"
  AD_SEARCH_FILTER = "sAMAccountName={uid}"
  # ldappasswd server
  SERVER = "auto"
  SERVER_HOST = "0.0.0.0"
  SERVER_PORT = "8080"
  #END OF VARIABLES FOR SETTINGS.INI
  env = [
    {
      name = "CONF_FILE"
      value = "/opt/settings.ini"
    }
  ]
}