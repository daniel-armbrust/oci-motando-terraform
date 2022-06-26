#
# modules/iam/policy/outputs.tf
# https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/identity_policy
#

output "id" {
    value = oci_identity_policy.policy.id
}

output "name" {
    value = oci_identity_policy.policy.name
}

output "state" {
    description = "The policy's current state."
    value = oci_identity_policy.policy.state
}

output "statements" {
    description = "An array of one or more policy statements written in the policy language."
    value = oci_identity_policy.policy.statements
}

output "version_date" {
    description = "The version of the policy."
    value = oci_identity_policy.policy.version_date
}