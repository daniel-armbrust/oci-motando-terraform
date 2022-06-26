#
# modules/network/load_balancer/alb/main.tf
# https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/load_balancer_load_balancer
#

terraform { 
  experiments = [module_variable_optional_attrs]
}

resource "oci_load_balancer_load_balancer" "load_balancer" {  
   compartment_id = var.compartment_id
   display_name = var.display_name
   shape = var.shape
   subnet_ids = var.subnet_ids
   is_private = var.is_private       
}

resource "oci_load_balancer_backend_set" "backend_set" {
   load_balancer_id = oci_load_balancer_load_balancer.load_balancer.id
     
   name = var.backend_set.name     
   policy = var.backend_set.policy

   health_checker {
       protocol = var.backend_set.health_checker_protocol
       interval_ms = var.backend_set.health_checker_interval
       port = var.backend_set.health_checker_port
       return_code = var.backend_set.health_checker_return_code
       timeout_in_millis = var.backend_set.health_checker_timeout
       url_path = var.backend_set.health_checker_url
   }
}

resource "oci_load_balancer_listener" "listener" { 
    count = var.listener != null ? length(var.listener) : 0

    default_backend_set_name = oci_load_balancer_backend_set.backend_set.name
    load_balancer_id = oci_load_balancer_load_balancer.load_balancer.id

    name = try(var.listener[count.index].name, "listener")
    port = var.listener[count.index].port
    protocol = var.listener[count.index].protocol       

    connection_configuration {
        idle_timeout_in_seconds = var.listener[count.index].idle_timeout
    }
        
    rule_set_names = var.force_https == true ? [oci_load_balancer_rule_set.force_ssl_rule_set[0].name] : null
}

resource "oci_load_balancer_listener" "ssl_listener" { 
    count = var.ssl_listener != null ? length(var.ssl_listener) : 0

    default_backend_set_name = oci_load_balancer_backend_set.backend_set.name
    load_balancer_id = oci_load_balancer_load_balancer.load_balancer.id

    name = try(var.ssl_listener[count.index].name, "ssl_listener")
    port = var.ssl_listener[count.index].port
    protocol = var.ssl_listener[count.index].protocol       

    ssl_configuration {
        certificate_name = var.ssl_listener[count.index].certificate_name
        verify_peer_certificate = var.ssl_listener[count.index].verify_peer_certificate
    }

    connection_configuration {
        idle_timeout_in_seconds = var.ssl_listener[count.index].idle_timeout
    }
}

resource "oci_load_balancer_rule_set" "force_ssl_rule_set" {
    count = var.force_https == true ? 1 : 0

    name = "http_redirect_https"
    load_balancer_id = oci_load_balancer_load_balancer.load_balancer.id
    
    items {
        description = "Redirect HTTP to HTTPS."        
        action = "REDIRECT"

        conditions {
            attribute_name = "PATH"
            attribute_value = "/"
            operator = "FORCE_LONGEST_PREFIX_MATCH"
        }

        redirect_uri {
            host = "{host}"
            path = "{path}"
            query = "{query}"
            port = 443
            protocol = "https"            
        }

        response_code = 301
    }    
}

resource "oci_load_balancer_backend" "backend" {   
    count = length(var.backend)     

    backendset_name = oci_load_balancer_backend_set.backend_set.name
    load_balancer_id = oci_load_balancer_load_balancer.load_balancer.id 

    ip_address = var.backend[count.index].ip_address
    port = var.backend[count.index].port
    
    backup = var.backend[count.index].backup
    drain = var.backend[count.index].drain
    offline = var.backend[count.index].offline
    weight = var.backend[count.index].weight
}