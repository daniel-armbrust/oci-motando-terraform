#
# modules/objectstorage/outputs.tf
# https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/objectstorage_bucket
#

output "id" {
    value = oci_objectstorage_bucket.objectstorage_bucket.bucket_id
}

output "name" {
    value = oci_objectstorage_bucket.objectstorage_bucket.name
}