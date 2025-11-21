
data "oci_identity_availability_domains" "ads" { //fetching availability domains
  compartment_id = var.compartment_id
}
data "oci_core_images" "ubuntu" { //fetching ubuntu images
  compartment_id   = var.compartment_id
  operating_system = var.operating_system
  sort_by          = var.sort_by
  sort_order       =  var.sort_order
}
resource "oci_core_instance" "instance" { //creating compute instance
  compartment_id    = var.compartment_id
 display_name=var.instance_display_name
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  shape             = var.shape

shape_config {
  ocpus = var.ocpus
  memory_in_gbs = var.memory_in_gbs
}
  create_vnic_details {
    subnet_id        = var.subnet_id
    assign_public_ip = var.assign_public_ip
  }
  source_details {
    source_type = var.source_type
    source_id   = data.oci_core_images.ubuntu.images[0].id
  }

}
output "public_ips" { //output public IP of the instance
  value = oci_core_instance.instance.public_ip
}
output "id" { //output instance ID
  value = oci_core_instance.instance.id
}