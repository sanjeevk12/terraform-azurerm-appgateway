variable "location" {
    default = "eastus2"
}

variable "tags" {
  description = "ARM resource tags to any resource types which accept tags"
  type = "map"

  default = {
    application = "Application Gateway"
  }
}
variable "resource_group_name" {
    default = "sample-rg2"
   
}
variable "vnet_name" {
    default = "myvnet"
}
variable "appgw_vnet_address_space" {
  default = "10.0.0.0/16"
  description = "The virtual network the application gateway resides in. Format x.x.x.x/yy"
}
variable "appgw_fe_subnet_prefix" {
  default = "10.0.1.240/28"
  description = "The subnet the application gateway resides in, nothing else can be deployed into that subnet. Should be in format x.x.x.x/yy"
}

variable "appgw_be_subnet_prefix" {
  default = "10.0.2.0/24"
  description = "The subnet the backend servers reside in."

}

variable "appgw_probe_interval" {
  default     = 90
  description = ""
}

variable "appgw_probe_timeout" {
  default     = 30
  description = ""
}

variable "appgw_probe_unhealthy_threshold" {
  default     = 3
  description = ""
}

variable "appgw_probe_match_statuscode" {
  default     = "200"
  description = ""
}

variable "prefix" {
    default = "myapp"
}
