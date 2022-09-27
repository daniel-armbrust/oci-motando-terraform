#
# modules/functions/application/main.tf
# https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/functions_application
#

resource "oci_functions_application" "application" {
    compartment_id = var.compartment_id
    display_name = var.display_name
    subnet_ids = var.subnet_ids
    config = var.app_config

    image_policy_config {
        is_policy_enabled = var.img_policy_enable
    }
}