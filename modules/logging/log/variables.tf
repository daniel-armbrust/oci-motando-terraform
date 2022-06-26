#
# modules/logging/log/variables.tf
# https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/logging_log
#

variable "display_name" {
    description = "(Required) (Updatable) The user-friendly display name."
    type = string
}

variable "loggroup_id" {
    description = "(Required) (Updatable) OCID of a log group to work with."
    type = string
}

variable "is_enable" {
    description = "(Optional) (Updatable) Whether or not this resource is currently enabled."
    type = bool
    default = true
}

variable "log_type" {
    description = "(Required) The logType that the log object is for, whether custom or service."
    type = string
    default = "CUSTOM"

    validation {
       condition = can(regex("^(CUSTOM|SERVICE)$", var.log_type))
       error_message = "The logType that the log object is for, whether CUSTOM or SERVICE."
    }   
}

variable "retention_duration" {
    description = "(Optional) (Updatable) Log retention duration in 30-day increments (30, 60, 90 and so on)."
    type = number
    default = 30

    validation {
       condition = !(var.retention_duration < 30 || var.retention_duration > 90)
       error_message = "The retention duration value must stay between 30 and 90 days."
    }   
}

variable "service_source" {
    type = object({
        category = string
        resource = string
        service = string
        source_type = string
        compartment_id = string
    })

    default = null
}