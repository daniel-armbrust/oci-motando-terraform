#
# modules/logging/log/outputs.tf
# https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/logging_log
#

output "id" {    
    value = join("", oci_logging_log.log.*.id, oci_logging_log.service_log.*.id)
}