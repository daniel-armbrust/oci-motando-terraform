#
# modules/nosql/table/outputs.tf
# https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/nosql_table
#

output "id" {
    value = join("", oci_nosql_table.nosql_table.*.id, oci_nosql_table.nosql_table_on_demand.*.id)
}