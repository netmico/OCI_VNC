variable "region" {
  description = "The OCI region to use."
  type        = string
}
variable "compartment_id" {
    description = "this comparment"
    type        = string
  
}

variable "vnc_id" {
    type        = string


}

variable "availability_domain" {
    type        = string
  
}
variable "image_id" {
    type        = string
  
}

variable "tenancy_ocid" {
  description = "The OCID of your tenancy in OCI."
  type        = string
}

variable "user_ocid" {
  description = "The OCID of the user in OCI."
  type        = string
}

variable "fingerprint" {
  description = "The fingerprint for the SSH key associated with the OCI user."
  type        = string
}

variable "private_key_path" {
  description = "The path to the private key for OCI API authentication."
  type        = string
}
