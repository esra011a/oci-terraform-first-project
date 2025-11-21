resource "oci_core_security_list" "sec_list" { //creating security list
  compartment_id = var.compartment_id
  vcn_id=var.vcn_id
  display_name = "first-sec-list"

  ingress_security_rules {
    protocol = "6"
    source = "0.0.0.0/0"
    tcp_options {
      min=22
      max=22
    }
  }
  egress_security_rules {
    protocol = "all"
    destination = "0.0.0.0/0"
  }
  
  lifecycle{ //to prevent security list from being destroyed
    ignore_changes = [ egress_security_rules ]
    prevent_destroy = true
  }
}
output "PrintSecList" { //output security list name
  value=oci_core_security_list.sec_list.display_name
}