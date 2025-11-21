
resource "oci_identity_compartment" "compt_Data_Ai" { //creating compartments
  compartment_id = var.tenancy_ocid
  name=var.compt_Data_Ai_name
  description =var.compt_Data_Ai_description
  
}
resource "oci_identity_compartment" "compt_DR" {
  compartment_id = var.tenancy_ocid
  name=var.compt_DR_name
  description =var.compt_DR_description
  
}
resource "oci_identity_compartment" "compt_Web" { 
  compartment_id = var.tenancy_ocid
  name=var.compt_Web_name
  description =var.compt_Web_description
  
}
locals { //defining subnets and security lists
  subnets={
           
Data_Ai = {
  cidr                = "10.0.20.0/24"
  sn_display_name     = "DataAI_SN"
  security-list-name  = "DataAI_SB_SL"
  dns_label           = "DataAiSN"
}
DR = {
  cidr                = "10.0.21.0/24"
  sn_display_name     = "DR_SN"
  security-list-name  = "DR_SB_SL"
  dns_label           = "DRSN"
}
  }
  
 security_lists={
   DataAI_SB_SL={ //defining security list for Data-Ai subnet
    display_name="DataAI_SB_SL"
  
    ingress = [
      {
        stateless    = false
        source       = "10.0.21.0/24"
        source_type  = "CIDR_BLOCK"
        protocol     = "6"
        from         = 22
        to           = 22
      }
    ]

   
   egress_security_rules= {
    protocol = "all"
    stateless        = false
    destination_type = "CIDR_BLOCK"
    destination = "0.0.0.0/0"
   }
    }
  
  DR_SB_SL={ //defining security list for DR subnet
    display_name="DR_SB_SL"
  
    ingress = [
      {
        stateless    = false
        source       = "10.0.30.0/24"
        source_type  = "CIDR_BLOCK"
        protocol     = "6"
        from         = 22
        to           = 22
      }
    ]
  egress_security_rules= {
    protocol = "all"
    stateless        = false
    destination_type = "CIDR_BLOCK"
    destination = "0.0.0.0/0"
  }
 }
   }
  }
module "vcn" { //creating VCN and subnets
  source = "./modules/network"
    label_prefix=var.label_prefix
  cidr_block = var.cidr_block
  vcn_cidr = var.vcn_cidr
  vcn_display_name = var.vcn_display_name
  vcn_dns_label = var.vcn_dns_label
  subnet_cidr_block = var.cidr_block
  compartment_id = oci_identity_compartment.compt_Data_Ai.id
  rt_name = var.rt_name
  create_service_gateway = var.create_service_gateway
  create_nat_gateway= var.create_nat_gateway
  create_internet_gateway = var.create_internet_gateway
  internet_gateway_display_name=var.internet_gateway_display_name
 nat_gateway_display_name = var.nat_gateway_display_name
 service_gateway_display_name = var.service_gateway_display_name
 subnet_count=var.subnet_count
 security_lists=local.security_lists
  subnets = local.subnets
public_sn_cidr  = var.public_sn_cidr
  public_sn_display_name  = var.public_sn_display_name
}

module "instance" { //creating compute instances
  source = "./modules/compute"
//creating servers for Data-Ai team , DR team and Web team
 for_each = local.instances
subnet_id = each.value.subnet_id////
compartment_id = each.value.compartment_id
instance_display_name = each.value.display_name
 ocpus = each.value.ocpus
  memory_in_gbs = each.value.memory_in_gbs
  assign_public_ip=each.value.assign_public_ip
}

locals { //defining compute instances and block storage
  instances={
    
  Data_Ai_compute ={
     count ="1"
    subnet_id=module.vcn.subnetData_Ai_id
    display_name="Data_AI_instance"
    compartment_id = oci_identity_compartment.compt_Data_Ai.id
    ocpus = "4"
    memory_in_gbs = "32"
    assign_public_ip=false
  }
  
   DR_compute ={
     count ="1"
    subnet_id=module.vcn.subnetDR_id
    display_name="DR_instance"
    compartment_id = oci_identity_compartment.compt_DR.id
    ocpus = "8"
     memory_in_gbs = "64"
     assign_public_ip=false
  }

    WEB_compute ={
      count ="1"
    subnet_id=module.vcn.publicSubnet_id
    display_name="WEB_instance"
    compartment_id = oci_identity_compartment.compt_Web.id
    ocpus = "8"
     memory_in_gbs = "32"
     assign_public_ip=true
     image_id="ocid1.image.oc1.me-jeddah-1.aaaaaaaajpnyyjwcqt4zovyq7bl4b6nzerweci32oict7ykn47pktk636m4a"
     boot_size= "250"
  }
  }

  storages ={ //defining block storage for Data-Ai and DR compute instances
    Data_Ai_storage ={
      compartment_id = oci_identity_compartment.compt_Data_Ai.id
      size_in_gbs = "50"
        instance_id =module.instance["Data_Ai_compute"].id
          volume_attachment_attachment_type=var.volume_attachment_type
          volume_attachment_display_name="Data_Ai_vol_attach"
          display_name="Data_Ai_volume"
    }

    DR_storage={
      compartment_id = oci_identity_compartment.compt_DR.id
      size_in_gbs = "100"
        instance_id =module.instance["DR_compute"].id
        volume_attachment_attachment_type=var.volume_attachment_type
         volume_attachment_display_name="DR_vol_attach"
         display_name="DR_volume"
    }
  }
}


module "storage"{ //creating block storage
  source = "./modules/storage"
  for_each = local.storages
  compartment_id = each.value.compartment_id

  size_in_gbs = each.value.size_in_gbs
  instance_id=each.value.instance_id
  display_name = each.value.display_name
  volume_attachment_attachment_type = each.value.volume_attachment_attachment_type
  volume_attachment_display_name = each.value.volume_attachment_display_name
}





