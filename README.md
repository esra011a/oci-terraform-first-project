# OCI Terraform  modules Project

This project demonstrates an **advanced Terraform setup** for automating OCI infrastructure.  
It uses **modules**, **locals**, and clean Infrastructure-as-Code practices to create multiple resources efficiently and consistently. This approach is more scalable and maintainable than basic Terraform examples.

##  What I Built
- A VCN with **public and private subnets**
- **Public Subnet**
  - Web instance + Internet Gateway
- **Private Subnets**
  - Data-AI instance (connected to Object Storage)
  - DR instance (connected to DR Storage)
- **NAT Gateway** and **Service Gateway**
- **security lists** for each subnet

##  Advanced Terraform Features
- **Modules** for reusable and structured infrastructure components  
- **Locals** to reduce repetition and simplify configuration  
- **Multiple resources created at once** using locals, variables, and modular logic  
- **IaC best practices** for clean and scalable deployment

##  Why Terraform?
- Manual OCI setup is slow and repetitive  
- Terraform provides fast, consistent, and repeatable deployments  
- Ideal for scaling beyond one or two servers

##  Project Purpose
This project is part of my journey in mastering **Terraform**, **OCI**, and **advanced Infrastructure-as-Code patterns**.
