#
# modules/functions/function/main.tf
# https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/functions_function
#

resource "oci_functions_function" "function" {        
    application_id = var.application_id
    display_name = var.display_name
    image = var.image

    memory_in_mbs = var.memory_mbs
    timeout_in_seconds = var.timeout_secs    
    config = var.config        

    trace_config {    
        is_enabled = var.enable_trace
    }
}