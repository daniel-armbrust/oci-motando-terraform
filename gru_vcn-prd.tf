#
# gru_vcn-prd.tf
#

#---------------------------
# PRODUCTION
#---------------------------

#-------------------
# VCN
#-------------------

module "gru_vcn-prd" {
    source = "./modules/network/vcn"
   
    providers = {
       oci = oci.gru
    }

    compartment_id = module.cmp_motando-network.id
    display_name = "gru_vcn-prd"
    cidr_blocks = ["172.16.0.0/16"]
    dns_label = "gruvcnprd"
    is_ipv6enabled = false
}

#-------------------
# Internet Gateway
#-------------------

module "gru_igw_vcn-prd" {
    source = "./modules/network/internet_gateway"

    providers = {
       oci = oci.gru
    }

    compartment_id = module.cmp_motando-network.id
    display_name = "gru_igw_vcn-prd"
    vcn_id = module.gru_vcn-prd.id
}

#-------------------
# NAT Gateway
#-------------------

module "gru_ngw_vcn-prd" {
    source = "./modules/network/nat_gateway"

    providers = {
       oci = oci.gru
    }

    compartment_id = module.cmp_motando-network.id
    display_name = "gru_ngw_vcn-prd"
    vcn_id = module.gru_vcn-prd.id
}

#-------------------
# Service Gateway
#-------------------

module "gru_sgw_vcn-prd" {
    source = "./modules/network/service_gateway"

    providers = {
       oci = oci.gru
    }

    compartment_id = module.cmp_motando-network.id
    display_name = "gru_sgw_vcn-prd"
    vcn_id = module.gru_vcn-prd.id
    service_id = local.gru_all_oci_services
}

#-------------------
# DHCP Options
#-------------------

module "gru_dhcp_vcn-prd" {
    source = "./modules/network/dhcp_options"

    providers = {
       oci = oci.gru
    }

    compartment_id = module.cmp_motando-network.id
    display_name = "gru_dhcp_vcn-prd"
    vcn_id = module.gru_vcn-prd.id
}

#-------------------
# Route Tables
#-------------------

module "gru_rtb_subpub-frontend_vcn-prd" {
    source = "./modules/network/route_table"

    providers = {
       oci = oci.gru
    }

    compartment_id = module.cmp_motando-network.id
    display_name = "gru_rtb_subpub-frontend_vcn-prd"
    vcn_id = module.gru_vcn-prd.id

    route_rules = [
        {
          destination = local.anywhere
          destination_type = "CIDR_BLOCK"
          network_entity_id = module.gru_igw_vcn-prd.id
          description = "Route through Internet Gateway"
        }
    ]
}

module "gru_rtb_subpub-okectlpln_vcn-prd" {
    source = "./modules/network/route_table"

    providers = {
       oci = oci.gru
    }

    compartment_id = module.cmp_motando-network.id
    display_name = "gru_rtb_subpub-okectlpln_vcn-prd"
    vcn_id = module.gru_vcn-prd.id

    route_rules = [
        {
          destination = local.anywhere
          destination_type = "CIDR_BLOCK"
          network_entity_id = module.gru_igw_vcn-prd.id
          description = "Route through Internet Gateway"
        }
    ]
}

module "gru_rtb_subprv-okelb_vcn-prd" {
    source = "./modules/network/route_table"

    providers = {
       oci = oci.gru
    }

    compartment_id = module.cmp_motando-network.id
    display_name = "gru_rtb_subprv-okelb_vcn-prd"
    vcn_id = module.gru_vcn-prd.id 

    route_rules = []  
}

module "gru_rtb_subprv-backend_vcn-prd" {
    source = "./modules/network/route_table"

    providers = {
       oci = oci.gru
    }

    compartment_id = module.cmp_motando-network.id
    display_name = "gru_rtb_subprv-backend_vcn-prd"
    vcn_id = module.gru_vcn-prd.id

    route_rules = [
        {
          destination = local.anywhere
          destination_type = "CIDR_BLOCK"
          network_entity_id = module.gru_ngw_vcn-prd.id
          description = "Route through NAT Gateway"
        }

        # TODO:
        #{
        #  destination = local.gru_all_oci_services
        #  destination_type = "CIDR_BLOCK"
        #  network_entity_id = module.gru_sgw_vcn-prd.id
        #  description = "Route through Service Gateway"
        #}
    ]
}

#-------------------
# Security Lists
#-------------------

module "gru_secl_subpub-frontend_vcn-prd" {
    source = "./modules/network/security_list"

    providers = {
       oci = oci.gru
    }

    compartment_id = module.cmp_motando-network.id
    display_name = "gru_secl_subpub-frontend_vcn-prd"
    vcn_id = module.gru_vcn-prd.id

    // TODO: change dst_min_port to include an array of values

    egress_security_rules = [
       {
           description      = "Allow access from OCI to ALL."
           destination      = local.anywhere
           destination_type = "CIDR_BLOCK"         
           protocol         = local.all_protocols
           stateless        = false           
       }
    ]

    ingress_security_rules = [      
        {
           description  = "Allow access from INTERNET to 80/TCP."
           source       = local.anywhere
           source_type  = "CIDR_BLOCK"
           protocol     = local.tcp_protocol
           stateless    = false
           dst_min_port = 80
           dst_max_port = 80
           src_min_port = 1024
           src_max_port = 65535           
        },          
        {
           description  = "Allow access from INTERNET to 443/TCP."
           source       = local.anywhere
           source_type  = "CIDR_BLOCK"
           protocol     = local.tcp_protocol
           stateless    = false
           dst_min_port = 443
           dst_max_port = 443
           src_min_port = 1024
           src_max_port = 65535           
        },
        {
           // To enable MTU negotiation for ingress internet traffic via IPv4, 
           // make sure to allow type 3 (Destination Unreachable) and
           // code 4 (Fragmentation Needed and Don't Fragment was Set).            
           description  = "Allow ICMP 3 (Destination Unreachable) and code 4 (Fragmentation Needed and Don't Fragment was Set)."
           source       = local.anywhere
           source_type  = "CIDR_BLOCK"           
           protocol     = local.icmp_protocol
           stateless    = false
           icmp_type    = 3
           icmp_code    = 4           
        }
    ]
}

module "gru_secl_subpub-okectlpln_vcn-prd" {
    source = "./modules/network/security_list"

    providers = {
       oci = oci.gru
    }

    compartment_id = module.cmp_motando-network.id
    display_name = "gru_secl_subpub-okectlpln_vcn-prd"
    vcn_id = module.gru_vcn-prd.id

    // TODO: change dst_min_port to include an array of values

    egress_security_rules = [
       {
           description      = "Allow access from OCI to ALL."
           destination      = local.anywhere
           destination_type = "CIDR_BLOCK"         
           protocol         = local.all_protocols
           stateless        = false           
       }
    ]

    ingress_security_rules = [              
        {
           description  = "Allow access from MY IP to 6443/TCP (OKE Control Plane)."
           source       = local.my_public_ip
           source_type  = "CIDR_BLOCK"
           protocol     = local.all_protocols
           stateless    = false
           dst_min_port = 6443
           dst_max_port = 6443 
           src_min_port = 1024
           src_max_port = 65535           
        },
        {
           description  = "Allow access from OKE Node Pools Subnet (backend)"
           source       = "172.16.4.0/24"
           source_type  = "CIDR_BLOCK"
           protocol     = local.all_protocols
           stateless    = false           
        },       
        {
           // To enable MTU negotiation for ingress internet traffic via IPv4, 
           // make sure to allow type 3 (Destination Unreachable) and
           // code 4 (Fragmentation Needed and Don't Fragment was Set).            
           description  = "Allow ICMP 3 (Destination Unreachable) and code 4 (Fragmentation Needed and Don't Fragment was Set)."
           source       = local.anywhere
           source_type  = "CIDR_BLOCK"           
           protocol     = local.icmp_protocol
           stateless    = false
           icmp_type    = 3
           icmp_code    = 4           
        }
    ]
}

module "gru_secl_subprv-okelb_vcn-prd" {
    source = "./modules/network/security_list"

    providers = {
       oci = oci.gru
    }

    compartment_id = module.cmp_motando-network.id
    display_name = "gru_secl_subprv-okelb_vcn-prd"
    vcn_id = module.gru_vcn-prd.id

    egress_security_rules = [
       {
           description      = "Allow access from OCI to ALL."
           destination      = local.anywhere
           destination_type = "CIDR_BLOCK"         
           protocol         = local.all_protocols,      
           stateless        = false           
       }
    ]

    ingress_security_rules = [
        {
           description  = "Allow access from Anywhere."
           source       = local.anywhere
           source_type  = "CIDR_BLOCK"           
           protocol     = local.all_protocols,
           stateless    = false                      
        }
    ]
}

module "gru_secl_subprv-backend_vcn-prd" {
    source = "./modules/network/security_list"

    providers = {
       oci = oci.gru
    }

    compartment_id = module.cmp_motando-network.id
    display_name = "gru_secl_subprv-backend_vcn-prd"
    vcn_id = module.gru_vcn-prd.id

    egress_security_rules = [
       {
           description      = "Allow access from OCI to ALL."
           destination      = local.anywhere
           destination_type = "CIDR_BLOCK"         
           protocol         = local.all_protocols,      
           stateless        = false           
       }
    ]

    ingress_security_rules = [
        {
           description  = "Allow access from Anywhere."
           source       = local.anywhere
           source_type  = "CIDR_BLOCK"           
           protocol     = local.all_protocols,
           stateless    = false                      
        }
    ]
}

#-------------------
# Subnets
#-------------------

module "gru_subpub-frontend_vcn-prd" {
    source = "./modules/network/subnet"

    providers = {
       oci = oci.gru
    }

    compartment_id = module.cmp_motando-network.id
    vcn_id = module.gru_vcn-prd.id
    dhcp_options_id = module.gru_dhcp_vcn-prd.id
    route_table_id = module.gru_rtb_subpub-frontend_vcn-prd.id
    security_list_ids = [module.gru_secl_subpub-frontend_vcn-prd.id]

    display_name = "gru_subpub-frontend_vcn-prd"    
    dns_label = "subpubfrtend"
    cidr_block = "172.16.1.0/24"    
    prohibit_public_ip_on_vnic = false
}

module "gru_subpub-okectlpln_vcn-prd" {
    source = "./modules/network/subnet"

    providers = {
       oci = oci.gru
    }

    compartment_id = module.cmp_motando-network.id
    vcn_id = module.gru_vcn-prd.id
    dhcp_options_id = module.gru_dhcp_vcn-prd.id
    route_table_id = module.gru_rtb_subpub-okectlpln_vcn-prd.id
    security_list_ids = [module.gru_secl_subpub-okectlpln_vcn-prd.id]

    display_name = "gru_subpub-okectlpln_vcn-prd"    
    dns_label = "subpubokectlpln"
    cidr_block = "172.16.3.0/28"    
    prohibit_public_ip_on_vnic = false
}

module "gru_subprv-okelb_vcn-prd" {
    source = "./modules/network/subnet"

    providers = {
       oci = oci.gru
    }

    compartment_id = module.cmp_motando-network.id
    vcn_id = module.gru_vcn-prd.id
    dhcp_options_id = module.gru_dhcp_vcn-prd.id
    route_table_id = module.gru_rtb_subprv-okelb_vcn-prd.id
    security_list_ids = [module.gru_secl_subprv-okelb_vcn-prd.id]

    display_name = "gru_subprv-okelb_vcn-prd"    
    dns_label = "subprvokelb"
    cidr_block = "172.16.2.0/24"
    prohibit_public_ip_on_vnic = true
}

module "gru_subprv-backend_vcn-prd" {
    source = "./modules/network/subnet"

    providers = {
       oci = oci.gru
    }

    compartment_id = module.cmp_motando-network.id
    vcn_id = module.gru_vcn-prd.id
    dhcp_options_id = module.gru_dhcp_vcn-prd.id
    route_table_id = module.gru_rtb_subprv-backend_vcn-prd.id
    security_list_ids = [module.gru_secl_subprv-backend_vcn-prd.id]

    display_name = "gru_subprv-backend_vcn-prd"    
    dns_label = "subprvbckend"
    cidr_block = "172.16.4.0/24"
    prohibit_public_ip_on_vnic = true
}