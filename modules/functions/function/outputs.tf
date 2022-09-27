#
# modules/functions/function/outputs.tf
# https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/functions_function
#

output "id" {
    value = oci_functions_function.function.id
}

output "image" {
    description = "The qualified name of the Docker image to use in the function, including the image tag."
    value =  oci_functions_function.function.image
}

output "image_digest" {
    description = "The image digest for the version of the image that will be pulled when invoking this function."
    value =  oci_functions_function.function.image_digest
}

output "invoke_endpoint" {
    description = "The base https invoke URL to set on a client in order to invoke a function. This URL will never change over the lifetime of the function and can be cached."
    value =  oci_functions_function.function.invoke_endpoint
}