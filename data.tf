data "template_file" "settings" {
  template = "${file("${path.module}/settings.ini.tpl")}"
  vars = {
    # html
    PAGE_TITLE = var.PAGE_TITLE
    # ldap
    LDAP_HOST = var.LDAP_HOST
    LDAP_PORT = var.LDAP_PORT
    USE_SSL = var.USE_SSL
    LDAP_BASE = var.LDAP_BASE
    LDAP_SEARCH_FILTER = var.LDAP_SEARCH_FILTER
    # For AD / Samba 4
    DC_TYPE = var.DC_TYPE
    AD_DOMAIN = var.AD_DOMAIN
    AD_SEARCH_FILTER = var.AD_SEARCH_FILTER
    # ldappasswd server
    SERVER = var.SERVER
    SERVER_HOST = var.SERVER_HOST
    SERVER_PORT = var.SERVER_PORT
  }
}