
resource "oci_core_vcn" "vcn" { //creating VCN
  cidr_block     = var.cidr_block
  display_name   = var.vcn_display_name
  compartment_id = var.compartment_id

  //vcn_cidr=var.vcn_cider
  dns_label = var.vcn_dns_label

}

resource "oci_core_subnet" "vcn_subnets" { //creating subnets
  compartment_id             = var.compartment_id
  vcn_id                     = oci_core_vcn.vcn.id
  for_each=var.subnets
  cidr_block = each.value.cidr
  display_name = each.value.sn_display_name
  dns_label = each.value.dns_label

  prohibit_public_ip_on_vnic = true//true
  route_table_id = oci_core_route_table.test_route_table.id

 security_list_ids = [for key in keys(var.security_lists) : oci_core_security_list.sec_list[key].id]
 lifecycle { 
  ignore_changes = [ security_list_ids ]
 }

}

resource "oci_core_subnet" "vcn_public_subnet" { //creating public subnet
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.vcn.id
  cidr_block     = var.public_sn_cidr
  prohibit_public_ip_on_vnic=false//public
  display_name   = var.public_sn_display_name
  
  route_table_id = oci_core_route_table.ig.id


  lifecycle {
    ignore_changes = all
  }
}

  resource "oci_core_internet_gateway" "first_internet_gateway" { //creating internet gateway
      display_name = var.internet_gateway_display_name
      compartment_id = var.compartment_id
      vcn_id=oci_core_vcn.vcn.id
     
    }
resource "oci_core_route_table" "ig" { //creating route table for internet gateway
    #Required
    compartment_id = var.compartment_id
    vcn_id = oci_core_vcn.vcn.id
    display_name = var.rt_name
   
    route_rules {
        #Required
        network_entity_id = oci_core_internet_gateway.first_internet_gateway.id
    }
    }
resource "oci_core_security_list" "sec_list" { //creating security lists
  compartment_id = var.compartment_id
  vcn_id=oci_core_vcn.vcn.id
  for_each = var.security_lists
//display_name = each.value.display_name
  display_name = each.value.display_name

 dynamic "ingress_security_rules" { 
  for_each = each.value.ingress
    
content {
      stateless    = ingress_security_rules.value.stateless
      source       = ingress_security_rules.value.source
      source_type  = ingress_security_rules.value.source_type
      protocol     = ingress_security_rules.value.protocol

      tcp_options {
        min = ingress_security_rules.value.from
        max = ingress_security_rules.value.to
      }
    }
 }
  egress_security_rules {
    stateless = false
    destination_type = "CIDR_BLOCK"
    protocol = "all"
    destination = "0.0.0.0/0"
  }
  
  lifecycle{
    ignore_changes = all
   
  }
}
output "PrintSecList" {
  value=oci_core_security_list.sec_list["DataAI_SB_SL"].display_name
}


data "oci_core_services" "first_services" {
  count=var.create_service_gateway ==true ? 1:0
}


resource "oci_core_service_gateway" "first_service_gateway" { //creating service gateway
  compartment_id = var.compartment_id
  display_name = var.service_gateway_display_name
  services {
    service_id = data.oci_core_services.first_services[0].services[0].id
  }
  vcn_id = oci_core_vcn.vcn.id
  count=var.create_service_gateway ==true ? 1:0
}

resource "oci_core_nat_gateway" "first_nat_gateway"{ //creating nat gateway
    compartment_id = var.compartment_id
    vcn_id = oci_core_vcn.vcn.id
    display_name = var.nat_gateway_display_name
count=var.create_nat_gateway ==true ? 1:0
}
resource "oci_core_route_table" "test_route_table" { //creating route table for nat gateway
    #Required
    compartment_id = var.compartment_id
    vcn_id = oci_core_vcn.vcn.id

   
    route_rules {
        #Required
        network_entity_id = oci_core_nat_gateway.first_nat_gateway[0].id
    }
    }
  

output "publicSubnet_id" {
  value = oci_core_subnet.vcn_public_subnet.id
}
output "subnetData_Ai_id" {
  value = oci_core_subnet.vcn_subnets["Data_Ai"].id
}
output "subnetDR_id" {
  value = oci_core_subnet.vcn_subnets["DR"].id
}
output "vcn_id" {
  value = oci_core_vcn.vcn.id
}


