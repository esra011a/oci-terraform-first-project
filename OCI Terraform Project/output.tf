
output "vcn_id" {
  value=module.vcn.vcn_id
}

output "compartment_id" {
  value = oci_identity_compartment.compt_Data_Ai.compartment_id
}
output "DR_instance_id" {
  value = module.instance["DR_compute"].id
}
output "Data_Ai_instance_id" {
  value=module.instance["Data_Ai_compute"].id
}

output "Web_instance_id" {
  value = module.instance["WEB_compute"].id
}

output "compartment_Data_Ai_id" { //output compartment IDs
  value = oci_identity_compartment.compt_Data_Ai.id
}
output "compartment_DR_id" {
  value = oci_identity_compartment.compt_DR.id
}
output "compartment_Web_id" {
  value = oci_identity_compartment.compt_Web.id
}

output "subnetData_Ai_id" {
  value = module.vcn.subnetData_Ai_id
}
output "subnetDR_id" {
  value = module.vcn.subnetDR_id
}
output "publicSubnet_id" {
  value = module.vcn.publicSubnet_id
}
output "instance_ids" {
  value = { for k, v in module.instance : k => v.id }
}
