#
# gru_loadbalancer.tf
#

#---------------------------
# PRODUCTION
#---------------------------

#-------------------
# Certificate
#-------------------


module "gru_cert_albpub-motando_prd" { 
   source = "./modules/network/load_balancer/certificate"

   providers = {
       oci = oci.gru
   }
   
   name = "cert_motando-ocibook-com-br"
   load_balancer_id = module.gru_albpub-motando_prd.id

   certificate = file("./tls_certs/motando-ocibook-com-br_cert.pem")
   private_key = file("./tls_certs/motando-ocibook-com-br_privkey.pem")
   intermediate_certificates = file("./tls_certs/motando-ocibook-com-br_fullchain.pem")   
}

#-------------------
# Application Load Balancer (ALB)
#-------------------

module "gru_albpub-motando_prd" {
    source = "./modules/network/load_balancer/alb"

    providers = {
       oci = oci.gru
    }

    display_name = "albpub-motando_prd"

    compartment_id = module.cmp_motando-network.id        
    subnet_ids = [module.gru_subpub-frontend_vcn-prd.id]   
    
    min_bandwidth_mbps = 10
    max_bandwidth_mbps = 10

    force_https = true

    listener = [
        {
            name = "listener-p80_albpub-motando_prd"        
            port = 80
            protocol = "HTTP"
            idle_timeout = 60
        }
    ]

    ssl_listener = [
        {
            name = "listener-p443_albpub-motando_prd"        
            port = 443
            protocol = "HTTP"
            idle_timeout = 120
            certificate_name = module.gru_cert_albpub-motando_prd.name
            verify_peer_certificate = false
        }
    ]          

    backend_set = {        
        name = "bckset-1_albpub-motando_prd"
        policy = "ROUND_ROBIN"
        
        health_checker_protocol = "HTTP"
        health_checker_port = 30080
        health_checker_timeout = 10000
        health_checker_return_code = 200
        health_checker_url = "/"
    }

  /*
    
    backend_set = {        
        name = "bckset-1_albpub-motando_prd"

        policy = "ROUND_ROBIN"

        health_checker_protocol = "HTTP"
        health_checker_port = 80
        health_checker_timeout = 10000
        health_checker_return_code = 200
        health_checker_url = "/"
    }    

    backend = [
       {          
          ip_address = module.gru_nginx-1-motando-prd.private_ip
          port = 80
       },
       {          
          ip_address = module.gru_nginx-2-motando-prd.private_ip
          port = 80
       }
    ]   
  */  
}