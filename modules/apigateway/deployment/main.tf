#
# modules/apigateway/deployment/main.tf
# https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/apigateway_deployment
#

resource "oci_apigateway_deployment" "stock_response_deployment" {
    count = var.stock_responses != null ? 1 : 0

    display_name = var.display_name
    compartment_id = var.compartment_id
    gateway_id = var.gateway_id
    path_prefix = var.path_prefix        

    specification {
        dynamic "routes" {            
            for_each = var.stock_responses

            content {
                path = routes.value.path
                methods = routes.value.http_methods

                backend {
                    type = "STOCK_RESPONSE_BACKEND"
                    body = routes.value.body
                    status = routes.value.status_code

                    headers {
                        name = routes.value.header_name
                        value = routes.value.header_value
                    }                
                }    

                response_policies {
                    header_transformations {    
                        filter_headers {
                            type = "BLOCK"

                            dynamic "items" {
                                for_each = var.filter_response_headers != null ? var.filter_response_headers : []

                                content {
                                    name = items.value
                                }
                            }
                        }
                    }
                }                
            }
        }        
    }
}

resource "oci_apigateway_deployment" "function_deployment" {
    count = var.functions_backend != null ? 1 : 0

    display_name = var.display_name
    compartment_id = var.compartment_id
    gateway_id = var.gateway_id
    path_prefix = var.path_prefix        

    specification {
        dynamic "routes" {            
            for_each = var.functions_backend

            content {
                path = routes.value.path
                methods = routes.value.http_methods

                backend {
                    type = "ORACLE_FUNCTIONS_BACKEND"
                    function_id = routes.value.function_id                          
                }    

                request_policies {
                     cors {
                         allowed_origins = routes.value.cors_allowed_origins
                         allowed_headers = routes.value.cors_allowed_headers
                         allowed_methods =  routes.value.cors_allowed_methods
                     }
                }

                response_policies {
                    header_transformations {    
                        filter_headers {
                            type = "BLOCK"

                            dynamic "items" {
                                for_each = var.filter_response_headers != null ? var.filter_response_headers : []

                                content {
                                    name = items.value
                                }
                            }
                        }
                    }
                }                
            }
        }        
    }
}