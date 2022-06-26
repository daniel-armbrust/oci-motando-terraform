#
# locals.tf
#

locals {    
   # My Public IP Address
   my_public_ip = data.external.get_my_public_ip.result.my_public_ip

   anywhere = "0.0.0.0/0" 
   all_protocols = "all"

   # IANA protocol numbers
   icmp_protocol = 1
   tcp_protocol = 6
   udp_protocol = 17
   
   # Service Gateway
   gru_all_oci_services = lookup(data.oci_core_services.gru_all_oci_services.services[0], "id")
   gru_oci_services_cidr_block = lookup(data.oci_core_services.gru_all_oci_services.services[0], "cidr_block")   
   vcp_all_oci_services = lookup(data.oci_core_services.vcp_all_oci_services.services[0], "id")
   vcp_oci_services_cidr_block = lookup(data.oci_core_services.vcp_all_oci_services.services[0], "cidr_block")

   # Region Names
   # See: https://docs.oracle.com/en-us/iaas/Content/General/Concepts/regions.htm
   region_names = {
      "gru" = "sa-saopaulo-1",
      "vcp" = "sa-vinhedo-1"
   }

   # GRU Object Storage Namespace
   gru_objectstorage_ns = data.oci_objectstorage_namespace.gru_objectstorage_ns.namespace

   # VCP Object Storage Namespace
   vcp_objectstorage_ns = data.oci_objectstorage_namespace.vcp_objectstorage_ns.namespace

   # Container Registry
   gru_ocir_hostname = "gru.ocir.io"
   vcp_ocir_hostname = "vcp.ocir.io"

   # Availability Domains
   ads = {
      gru_ad1_id = data.oci_identity_availability_domains.gru_ads.availability_domains[0].id
      gru_ad1_name = data.oci_identity_availability_domains.gru_ads.availability_domains[0].name

      vcp_ad1_id = data.oci_identity_availability_domains.vcp_ads.availability_domains[0].id
      vcp_ad1_name = data.oci_identity_availability_domains.vcp_ads.availability_domains[0].name
   }
 
   # Fault Domains
   fds = {
      gru_fd1_id = data.oci_identity_fault_domains.gru_fds.fault_domains[0].id,
      gru_fd1_name = data.oci_identity_fault_domains.gru_fds.fault_domains[0].name,

      gru_fd2_id = data.oci_identity_fault_domains.gru_fds.fault_domains[1].id,
      gru_fd2_name = data.oci_identity_fault_domains.gru_fds.fault_domains[1].name,

      gru_fd3_id = data.oci_identity_fault_domains.gru_fds.fault_domains[2].id,
      gru_fd3_name = data.oci_identity_fault_domains.gru_fds.fault_domains[2].name     

      vcp_fd1_id = data.oci_identity_fault_domains.vcp_fds.fault_domains[0].id,
      vcp_fd1_name = data.oci_identity_fault_domains.vcp_fds.fault_domains[0].name,

      vcp_fd2_id = data.oci_identity_fault_domains.vcp_fds.fault_domains[1].id,
      vcp_fd2_name = data.oci_identity_fault_domains.vcp_fds.fault_domains[1].name,

      vcp_fd3_id = data.oci_identity_fault_domains.vcp_fds.fault_domains[2].id,
      vcp_fd3_name = data.oci_identity_fault_domains.vcp_fds.fault_domains[2].name
   }

   #
   # See: https://docs.oracle.com/en-us/iaas/images/
   #
   compute_image_id = {
      "gru" = {
         "centos7" = "ocid1.image.oc1.sa-saopaulo-1.aaaaaaaarihpw2lfked2jfoigpma3e7dkt36gw6yg26ceh6zup4jvthj7jkq",
         "centos8" = "ocid1.image.oc1.sa-saopaulo-1.aaaaaaaaji7374dd3t5rjllcvskopfydco24lf2c62jitixxdxwncdlanfvq",
         "ol7" = "ocid1.image.oc1.sa-saopaulo-1.aaaaaaaa4vkhemdkmfe3icxzzdkgfnfijybzzhrz63icerlq7oyzdoe3mv6a",
         "ol8" = "ocid1.image.oc1.sa-saopaulo-1.aaaaaaaacsn7itsqbert6n7g4ywxrhmyrocfigqi5jmrhfwfxl4rlvjz2fyq",
         "ol8-arm" = "ocid1.image.oc1.sa-saopaulo-1.aaaaaaaaozkkrr2ef4z4xdtgbwqnhbk5p5fkozuyxqt7cy37h3ifzywdmoiq",
         "ol85-oke" = "ocid1.image.oc1.sa-saopaulo-1.aaaaaaaads2eehsw7wr6z3cde6q4vxpkvkmmutwr7n7akhwyavalpqwg7cpa"
      },
      "vcp" = {
         "centos7" = "ocid1.image.oc1.sa-vinhedo-1.aaaaaaaaxca5pyh3nazuskmjmqg5nlnu3hagppjtsemz6wuyc7nctwoqgjuq",
         "centos8" = "ocid1.image.oc1.sa-vinhedo-1.aaaaaaaaxtv7lbhvcdqyshi4d25uvoffvplbo7jsp26o3yihui437qfbmkqa",
         "ol7" = "ocid1.image.oc1.sa-vinhedo-1.aaaaaaaaiopntk3s5krgnklflrnlyqvvgmsm345lsknn5lltqosspcwzzgmq",
         "ol8" = "ocid1.image.oc1.sa-vinhedo-1.aaaaaaaaiiazbx5gkhganyik7egjee7zdvsl5ufxjpgc2jwmwtpcpra5dmra",
         "ol8-arm" = "ocid1.image.oc1.sa-vinhedo-1.aaaaaaaayapg3rwoikvamdhp57kxnckhrfu6ve2stg2gvvgdigdtrbz3ufoq",
         "ol85-oke" = "ocid1.image.oc1.sa-vinhedo-1.aaaaaaaaiivjybdg4zuqcamx2nzabypk44w6ujhdtwx6pqglo4lz7dmoduoa"
      }
   }
}