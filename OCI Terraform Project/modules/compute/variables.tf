variable "compartment_id" {
  
}
variable "source_type" {
  default = "image"
}
variable "subnet_id" {
  
}
variable "memory_in_gbs" {
  default = 8
}
variable "ocpus" {
  default = 1
}
variable "instance_display_name" {
  default = "instance GIS"
}
variable "shape" { //instance shape
  default = "VM.Standard.E2.1.Micro"
}
variable "assign_public_ip" {
  type=bool
  default = false
}
variable "sort_order" {
  default = "DESC"
}
variable "sort_by" {
  default = "TIMECREATED"
}
variable "operating_system" {
  default = "Canonical Ubuntu"
}
