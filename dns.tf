#
# dns.tf
#

#---------------------------
# PUBLIC DNS (Global)
#---------------------------

#-------------------
# ocibook.com.br
#-------------------

module "dns-zone_ocibook-com-br" {
    source = "./modules/network/dns/zone"

    providers = {
       oci = oci.gru
    }

    compartment_id = module.cmp_motando-network-dns.id

    name = "ocibook.com.br"
}

#-------------------
# motando.ocibook.com.br
#-------------------

module "dns-record_gru_albprdsp-ocibook-com-br" {
    source = "./modules/network/dns/record"

    providers = {
       oci = oci.gru
    }

    compartment_id = module.cmp_motando-network-dns.id
    zone_id = module.dns-zone_ocibook-com-br.id

    domain = "albprdsp.ocibook.com.br"
    rtype = "A"    
    rdata = module.gru_albpub-motando_prd.ip_address
    ttl = 60
}

module "dns-record_motando-ocibook-com-br" {
    source = "./modules/network/dns/record"

    providers = {
       oci = oci.gru
    }

    compartment_id = module.cmp_motando-network-dns.id
    zone_id = module.dns-zone_ocibook-com-br.id

    domain = "motando.ocibook.com.br"
    rtype = "CNAME"
    rdata = "albprdsp.ocibook.com.br"
    ttl = 60
}

#-------------------
# api.ocibook.com.br
#-------------------

module "dns-record_apigwsp-ocibook-com-br" {
    source = "./modules/network/dns/record"

    providers = {
       oci = oci.gru
    }

    depends_on = [
       module.gru_apigw-prd
    ]

    compartment_id = module.cmp_motando-network-dns.id
    zone_id = module.dns-zone_ocibook-com-br.id

    domain = "apigwsp.ocibook.com.br"
    rtype = "A"
    rdata = module.gru_apigw-prd.ip_address
    ttl = 60
}

module "dns-record_api-ocibook-com-br" {
    source = "./modules/network/dns/record"

    providers = {
       oci = oci.gru
    }

    compartment_id = module.cmp_motando-network-dns.id
    zone_id = module.dns-zone_ocibook-com-br.id

    domain = "api.ocibook.com.br"
    rtype = "CNAME"
    rdata = "apigwsp.ocibook.com.br"
    ttl = 60
}


#---------------------------
# PRIVATE DNS (Internal)
#---------------------------

#-------------------
# ocibook.local
#-------------------

module "dns_private-view_ocibook-local" {
   source = "./modules/network/dns/view"

    providers = {
       oci = oci.gru       
    }

    compartment_id = module.cmp_motando-network-dns.id
    display_name = "dns_private-view_ocibook-local"
}

module "dns-zone_ocibook-local" {
    source = "./modules/network/dns/zone"

    providers = {
       oci = oci.gru       
    }

    compartment_id = module.cmp_motando-network-dns.id

    name = "ocibook.local"    
    scope = "PRIVATE"
    view_id = module.dns_private-view_ocibook-local.id
}

#-------------------
# Private View (VCN-PRD - ocibook.local)
#-------------------

module "gru_dns-prv-resolver_vcn-prd" {
    source = "./modules/network/dns/resolver"
   
    providers = {
       oci = oci.gru
    }

    compartment_id = module.cmp_motando-network.id
    display_name = "gru_dnsprv-resolver_vcn-prd"

    view_id = module.dns_private-view_ocibook-local.id

    # We won't have the DNS resolver id as soon as vcn is created, 
    # we will create it asynchronously. It would be null until it 
    # is actually created. That's why I depends on cluster creation.
    depends_on = [       
        module.gru_oke-cluster_prd
    ]  

    resolver_id = module.gru_vcn-prd.dns_resolver_id    
}