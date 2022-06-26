#
# modules/bastion/session/variables.tf
# https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/bastion_session
#

variable "display_name" {
    description = "(Optional) (Updatable) The name of the session."
    type = string
    default = "bastion_session"
}

variable "bastion_id" {
    description = "(Required) The unique identifier (OCID) of the bastion on which to create this session."
    type = string
}

variable "ssh_public_key" {
    description = "(Required) The public key in OpenSSH format."
    type = string
}

variable "target_id" {
    description = "(Optional) The unique identifier (OCID) of the target resource (a Compute instance, for example) that the session connects to."
    type = string
}

variable "target_port" {
    description = "(Optional) The port number to connect to on the target resource."
    type = number
    default = 22
}

variable "target_username" {
    description = "(Required when session_type=MANAGED_SSH) The name of the user on the target resource operating system that the session uses for the connection."
    type = string
    default = "opc"
}

variable "session_ttl" {
     description = "(Optional) The amount of time in seconds that the session can remain active."
     type = number
     default = 1800
}