#
# modules/bastion/session/outputs.tf
# https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/bastion_session
#

output "id" {
    value = oci_bastion_session.bastion_session.id
}

output "ssh_command" {
    value = oci_bastion_session.bastion_session.ssh_metadata.command    
}