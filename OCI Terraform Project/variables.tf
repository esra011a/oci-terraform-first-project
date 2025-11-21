
variable "tenancy_ocid" { 
   default="ocid1.tenancy.oc1.aaaaaaaaxxxxxxx"//write your tenancy ocid here

}
//compartment variables
variable "compt_Data_Ai_name" {}
variable "compt_Data_Ai_description" {}
variable "compt_DR_description" {}
variable "compt_DR_name" {}
variable "compt_Web_name"{}
variable "compt_Web_description" {
  
}
//variable "subnet_id" {} 
variable "subnet_count" {}
variable "volume_count" {}
//variable "compartment_id" {}
variable "create_internet_gateway" {}
variable "create_nat_gateway" {}
 variable "create_service_gateway" {}
 variable "subnet_cidr_block" {}
 variable "cidr_block" {}
variable "size_in_gbs" {}
variable "public_sn_cidr" {
}
variable "public_sn_display_name" {
  
}
variable "label_prefix" {
  
}
variable "rt_name" {
  
}
variable "service_gateway_display_name" { //service gateway name
   default = "first service gateway"
}
variable "nat_gateway_display_name" {
   default = "first nat gateway"
}
variable "internet_gateway_display_name" {
   default = "first internet gateway"
}
variable "vcn_dns_label" {
  default = "vcnDNS"
}
variable "vcn_cidr" {
  
}
variable "vcn_display_name" {
  
}
variable "volume_attachment_display_name" {
  
}
variable "volume_attachment_type" {
  
}

