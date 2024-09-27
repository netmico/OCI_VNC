resource "oci_core_vcn" "OCI_NET" {
  cidr_block     = "10.92.0.0/16"
  compartment_id = var.compartment_id
  display_name   = "OCI_VCN"
  dns_label      = "myvcn"

}




resource "oci_core_subnet" "public" {
  cidr_block          = "10.92.1.0/24"
  vcn_id              = oci_core_vcn.OCI_NET.id
  compartment_id      = var.compartment_id
  availability_domain = var.availability_domain
  security_list_ids   = [oci_core_security_list.security_list.id]

}


resource "oci_core_subnet" "private" {
  cidr_block          = "10.92.2.0/24"
  vcn_id              = oci_core_vcn.OCI_NET.id
  compartment_id      = var.compartment_id
  availability_domain = var.availability_domain
  security_list_ids   = [oci_core_security_list.security_list.id]

}

resource "oci_core_security_list" "security_list" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.OCI_NET.id

  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"
    tcp_options {
      min = 5901
      max = 5901
    }
  }

  egress_security_rules {
    protocol    = "all"
    destination = "0.0.0.0/0"
  }

  display_name = "vnc_security_list"
}


resource "oci_core_instance" "vnc_instance" {
  compartment_id      = var.compartment_id
  availability_domain = var.availability_domain
  shape               = "VM.Standard.E2.1.Micro"

  display_name = "vnc_instance"

  source_details {
    source_type = "image"
    source_id   = var.image_id
  }



  create_vnic_details {
    assign_public_ip = true
    display_name     = "vnc_vnic"
    subnet_id        = oci_core_subnet.public.id
    hostname_label   = "vnc-host"
  }
}
