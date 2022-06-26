#
# modules/nosql/table/variables.tf
# https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/nosql_table
#

variable "compartment_id" {
    description = "(Required) (Updatable) The OCID of the compartment to contain the NoSQL Table."
    type = string    
}

variable "nosql_table" {
    description = "(Optional) NoSQL Database Table properties."

    type = object({
        name = string
        ddl_statement = string
        read_units = optional(string)
        write_units = optional(string)
        on_demand_capacity = optional(bool)
        storage_gbs = string
    })

    default = null
}