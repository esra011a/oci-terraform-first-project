variable "compartment_id" {
  
}
variable "tenancy_ocid" {
  default   = "ocid1.tenancy.oc1..aaaaaaaaxxxxxx"//write your tenancy ocid here

}
variable "subnet_count" {
 
}
variable "vcn_dns_label" {
  
}

variable "label_prefix" {
  
}
variable "service_gateway_display_name" {
  default = "first service gateway"
}
variable "internet_gateway_display_name" {
  default = "first internet gateway"
}
variable "nat_gateway_display_name" {
  default = "first nat gateway"
}
variable "vcn_display_name" {
  default = "vcn1"
}
variable "subnet_display_name" {
  default = "subnet gis"
}
variable "subnets" {
  
}
variable "security_lists" {
  
}
variable "public_sn_display_name" {
  
}
variable "public_sn_cidr" {
  
}
variable "rt_name" {
  
}

variable "cidr_block" {
  
}
variable "vcn_cidr" {
  
}
variable "subnet_cidr_block" {

}
variable "create_internet_gateway" {
  type=bool
 
}
variable "create_nat_gateway" {
  type=bool
  
}
 variable "create_service_gateway" {
   type=bool
  
 }