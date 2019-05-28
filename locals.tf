locals {
  backend_address_pool_name      = "${var.vnet_name}-bepool"
  frontend_port_name             = "${var.vnet_name}-feport"
  frontend_ip_configuration_name = "${var.vnet_name}-feip"
  http_setting_name              = "httpset-${var.vnet_name}"
  listener_name                  = "${var.vnet_name}-listener"
  request_routing_rule_name      = "rrule-${var.vnet_name}"
}