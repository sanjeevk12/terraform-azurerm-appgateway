resource "azurerm_resource_group" "rg" {
  name     = "${var.resource_group_name}"
  location = "${var.location}"
  tags     = "${var.tags}"     
}
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.vnet_name}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  location            = "${var.location}"
  address_space       = ["${var.appgw_vnet_address_space}"] 
  tags                = "${var.tags}"
}

resource "azurerm_subnet" "frontend_subnet" {
  name                 = "${var.vnet_name}-frontend"
  resource_group_name  = "${var.resource_group_name}"
  virtual_network_name = "${azurerm_virtual_network.vnet.name}"
  address_prefix       = "${var.appgw_fe_subnet_prefix}"
}
resource "azurerm_subnet" "backend_subnet" {
  name                 = "${var.vnet_name}-backend"
  resource_group_name  = "${var.resource_group_name}"
  virtual_network_name = "${azurerm_virtual_network.vnet.name}"
  address_prefix       = "${var.appgw_be_subnet_prefix}"
}

resource "azurerm_public_ip" "app_gw" {
  name                = "appgw-pip"
  location                     = "${var.location}"
  resource_group_name          = "${azurerm_resource_group.rg.name}"
  allocation_method   = "Dynamic"
}

resource "azurerm_application_gateway" "app_gw" {
  name                = "${var.prefix}-appgw"
  location                     = "${var.location}"
  resource_group_name          = "${var.resource_group_name}"

  sku {
    name     = "Standard_Small"
    tier     = "Standard"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "gateway-ip-configuration"
    subnet_id = "${azurerm_subnet.frontend_subnet.id}"
  }

  frontend_ip_configuration {
    name                 = "${local.frontend_ip_configuration_name}"
    public_ip_address_id = "${azurerm_public_ip.app_gw.id}"
  }

  frontend_port {
    name = "${local.frontend_port_name}-1"
    port = 80
  }

  backend_address_pool {
    name = "bepool1-${local.backend_address_pool_name}"

  }
  backend_address_pool {
    name = "bepool2-${local.backend_address_pool_name}"

  }
  backend_address_pool {
    name = "bepool3-${local.backend_address_pool_name}"

  }
  backend_address_pool {
    name = "bepool4-${local.backend_address_pool_name}"

  }
  backend_http_settings {
    name                  = "8080-${local.http_setting_name}"
    cookie_based_affinity = "Disabled"
    port                  = 8080
    protocol              = "Http"
    request_timeout       = 1
  }

  backend_http_settings {
    name                  = "8001-${local.http_setting_name}"
    cookie_based_affinity = "Disabled"
    port                  = 8001
    protocol              = "Http"
    request_timeout       = 1
  }

  backend_http_settings {
    name                  = "8003-${local.http_setting_name}"
    cookie_based_affinity = "Disabled"
    port                  = 8003
    protocol              = "Http"
    request_timeout       = 1
  }

  backend_http_settings {
    name                  = "8005-${local.http_setting_name}"
    cookie_based_affinity = "Disabled"
    port                  = 8005
    protocol              = "Http"
    request_timeout       = 1
  }

  backend_http_settings {
    name                  = "8007-${local.http_setting_name}"
    cookie_based_affinity = "Disabled"
    port                  = 8007
    protocol              = "Http"
    request_timeout       = 1
  }


  http_listener {
    name                           = "${local.listener_name}-1"
    frontend_ip_configuration_name = "${local.frontend_ip_configuration_name}"
    frontend_port_name             = "${local.frontend_port_name}-1"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "${local.request_routing_rule_name}-1"
    rule_type                  = "PathBasedRouting"
    http_listener_name         = "${local.listener_name}-1"
    url_path_map_name          = "pathsample"
  }

    url_path_map {
     name    = "pathsample"
     default_backend_address_pool_name  = "bepool1-${local.backend_address_pool_name}"
     default_backend_http_settings_name = "8080-${local.http_setting_name}"
  
          path_rule {
            name = "path1"
            paths = ["/path1"]
            backend_address_pool_name = "bepool1-${local.backend_address_pool_name}"
            backend_http_settings_name = "8001-${local.http_setting_name}"
  }
          path_rule {
            name = "path2"
            paths = ["/path2"]
            backend_address_pool_name = "bepool2-${local.backend_address_pool_name}"
            backend_http_settings_name = "8003-${local.http_setting_name}"
  }
           path_rule {
            name = "path3"
            paths = ["/path3"]
            backend_address_pool_name = "bepool3-${local.backend_address_pool_name}"
            backend_http_settings_name = "8005-${local.http_setting_name}"
  }
          path_rule {
            name = "path4"
            paths = ["/path4"]
            backend_address_pool_name = "bepool4-${local.backend_address_pool_name}"
            backend_http_settings_name = "8007-${local.http_setting_name}"
  }
        
    }
  }


     

