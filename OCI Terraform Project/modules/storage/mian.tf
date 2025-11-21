data "oci_identity_availability_domain" "ads" { //fetching availability domain
    compartment_id = var.compartment_id
}

resource "oci_core_volume" "volume" { //creating block storage volume
 
  availability_domain = data.oci_identity_availability_domain.ads.name
  compartment_id = var.compartment_id
  size_in_gbs = var.size_in_gbs
  display_name=var.display_name
}

resource "oci_core_volume_attachment" "test_volume_attachment" { //attaching block storage to compute instance
   
    attachment_type = var.volume_attachment_attachment_type
    instance_id =var.instance_id
    volume_id = oci_core_volume.volume.id
display_name = var.volume_attachment_display_name
   
}