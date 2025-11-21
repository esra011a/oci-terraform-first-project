terraform {  //defining provider
  required_providers { 
    oci = { 
      source = "oracle/oci"  
      version = "7.23.0" 
    }
  }
}