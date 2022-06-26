#
# modules/logging/log/main.tf
# https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/logging_log
#

resource "oci_logging_log" "log" {   
    count = var.service_source == null ? 1 : 0

    display_name = var.display_name

    log_group_id = var.loggroup_id
    log_type = var.log_type
    is_enabled = var.is_enable
    retention_duration = var.retention_duration   
}

resource "oci_logging_log" "service_log" {   
    count = var.service_source != null ? 1 : 0

    display_name = var.display_name

    log_group_id = var.loggroup_id
    log_type = var.log_type
    is_enabled = var.is_enable
    retention_duration = var.retention_duration   

    configuration {        
        source {
             category = var.service_source["category"]
             resource = var.service_source["resource"]
             service = var.service_source["service"]
             source_type = var.service_source["source_type"]
        }

        compartment_id = var.service_source["compartment_id"]
    }
}