#
# modules/functions/function/variables.tf
# https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/functions_function
#

variable "application_id" {
    description = "(Required) The OCID of the application this function belongs to."
    type = string    
}

variable "config" {
    description = "(Optional) (Updatable) Function configuration. These values are passed on to the function as environment variables, this overrides application configuration values. "
    type = map(string)
    default = null
} 

variable "display_name" {
    description = "(Required) The display name of the function. The display name must be unique within the application containing the function."
    type = string
}

variable "image" {
    description = "(Required) (Updatable) The qualified name of the Docker image to use in the function, including the image tag. The image should be in the Oracle Cloud Infrastructure Registry that is in the same region as the function itself."
    type = string    
}

variable "memory_mbs" {
    description = "(Required) (Updatable) Maximum usable memory for the function (MiB)."
    type = number
    default = 128

    validation {
       condition = can(regex("^(128|256|512|1024|2048)$", var.memory_mbs))
       error_message = "The Maximum memory for Function execution is 128, 256, 512, 1024 or 2048."
    }   
}

variable "timeout_secs" {
    description = "(Optional) (Updatable) Timeout for executions of the function. Value in seconds."
    type = number
    default = 30

    validation {
       condition = !(var.timeout_secs < 30 || var.timeout_secs > 300)
       error_message = "The timeout value must stay between 30 and 300 seconds."
    }   
}

variable "enable_trace" {
    description = " (Optional) (Updatable) Define if tracing is enabled for the resource."
    type = bool
    default = false
}