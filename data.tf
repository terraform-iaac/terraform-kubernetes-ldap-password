data "template_file" "settings" {
  template = file("${path.module}/settings.ini.tpl")
  vars = {
    # html
    PAGE_TITLE = var.page_title
    # ldap
    LDAP_HOST = var.ldap_host
    LDAP_PORT = var.ldap_port
    USE_SSL = var.use_ssl
    LDAP_BASE = var.ldap_base
    # For AD / Samba 4
    DC_TYPE = var.dc_type
    AD_DOMAIN = var.ad_domain
    AD_SEARCH_FILTER = var.ad_search_filter
    # ldappasswd server
    SERVER = var.server
    SERVER_HOST = var.server_host
    SERVER_PORT = var.server_port
  }
}