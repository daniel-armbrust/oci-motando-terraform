#
# modules/nosql/table/main.tf
# https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/nosql_table
#

terraform { 
  experiments = [module_variable_optional_attrs]
}

resource "oci_nosql_table" "nosql_table" {
    count = var.nosql_table["read_units"] != null && var.nosql_table["write_units"] != null ? 1 : 0

    compartment_id = var.compartment_id
    name = var.nosql_table["name"]
    ddl_statement = var.nosql_table["ddl_statement"]

    table_limits {     
        max_read_units = var.nosql_table["read_units"]        
        max_write_units = var.nosql_table["write_units"]
        max_storage_in_gbs = var.nosql_table["storage_gbs"]
    }
}

resource "oci_nosql_table" "nosql_table_on_demand" {
    count = var.nosql_table["on_demand_capacity"] != null ? 1 : 0

    compartment_id = var.compartment_id
    name = var.nosql_table["name"]
    ddl_statement = var.nosql_table["ddl_statement"]

    table_limits {           
        max_read_units = 0
        max_write_units = 0
        capacity_mode = "ON_DEMAND"
        max_storage_in_gbs = var.nosql_table["storage_gbs"]      
    }
}