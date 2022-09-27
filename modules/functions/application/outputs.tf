#
# modules/functions/application/outputs.tf
# https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/functions_application
#

output "id" {
    value = oci_functions_application.application.id
}

output "state" {
    value = oci_functions_application.application.state
}

output "display_name" {
    value = oci_functions_application.application.display_name
}