#
# modules/network/load_balancer/certificate/main.tf
# https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/load_balancer_certificate
#

resource "oci_load_balancer_certificate" "lb_certificate" {    
    certificate_name = var.name
    load_balancer_id = var.load_balancer_id
    
    ca_certificate = var.intermediate_certificates       
    public_certificate = var.certificate    
    private_key = var.private_key    

    lifecycle {
        create_before_destroy = true
    }
}