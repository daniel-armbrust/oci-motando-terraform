#
# modules/functions/application/variables.tf
# https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/functions_application
#

variable "compartment_id" {
    description = "(Required) (Updatable) The OCID of the compartment to create the application within."
    type = string    
}

variable "display_name" {
    description = "(Required) The display name of the application. The display name must be unique within the compartment containing the application."
    type = string
} 

variable "app_config" {
    description = "(Optional) (Updatable) Application configuration. These values are passed on to the function as environment variables."
    type = map(string)
    default = null
}

variable "img_policy_enable" {
    description = "(Required) (Updatable) Define if image signature verification policy is enabled for the application."
    type = bool
    default = false
}

variable "subnet_ids" {
    description = "(Required) The OCIDs of the subnets in which to run functions in the application."
    type = list(string)
}