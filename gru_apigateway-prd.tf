#
# gru_apigateway-prd.tf
#

#--------------------------------
# PRODUCTION
#--------------------------------

#-----------------
# Certificate
#-----------------

module "gru_cert_apigw-prd" {
    source = "./modules/apigateway/certificate"
   
    providers = {
       oci = oci.gru
    }

    compartment_id = module.cmp_motando-api.id
    
    display_name = "cert_api-ocibook-com-br"

    certificate = file("./tls_certs/api-ocibook-com-br_cert.pem")
    private_key = file("./tls_certs/api-ocibook-com-br_privkey.pem")
    intermediate_certificates = file("./tls_certs/api-ocibook-com-br_fullchain.pem")
}

#-----------------
# API Gateway
#-----------------

module "gru_apigw-prd" {
    source = "./modules/apigateway/gateway"
   
    providers = {
       oci = oci.gru
    }

    compartment_id = module.cmp_motando-api.id
    display_name = "gru_apigw-prd"
    endpoint_type = "PUBLIC"
    subnet_id = module.gru_subpub-frontend_vcn-prd.id
    certificate_id = module.gru_cert_apigw-prd.id
}