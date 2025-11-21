# OCI Terraform Project
This OCI Terraform project automates cloud infrastructure provisioning, replacing slow manual setups with fast consistent deployments.


##  What I Built
- A VCN with **public and private subnets**
- **Public subnet:** Web instance + Internet Gateway  
- **Private subnets:**  
  - Data-AI instance (connected to Object Storage)  
  - DR instance (connected to DR Storage)  
- NAT and Service Gateways  
- Separate security lists for each subnet

##  Why Terraform?
- Manual OCI setup is slow  
- Terraform makes deployments fast and repeatable

This project is part of my journey learning Terraform and OCI.
