#
# compartments.tf
#

#---------------------------
# ALL COMPARTMENTS 
#---------------------------

#-------------------
# motando 
#-------------------

module "cmp_motando" {
    source = "./modules/iam/compartment"

    providers = {
       oci = oci.home_region
    }

    name = "cmp-motando"         
    description = "Compartimento para hospedar os recursos da aplicação Motando."
    parent_compartment_id = var.root_compartment    
}

#-------------------
# motando/network
#-------------------

module "cmp_motando-network" {
    source = "./modules/iam/compartment"

    providers = {
       oci = oci.home_region
    }

    name = "cmp-network"         
    description = "Compartimento para hospedar os recursos de redes da aplicação Motando."
    parent_compartment_id = module.cmp_motando.id
}

#-------------------
# motando/compute
#-------------------

module "cmp_motando-compute" {
    source = "./modules/iam/compartment"

    providers = {
       oci = oci.home_region
    }

    name = "cmp-compute"         
    description = "Compartimento para hospedar máquinas virtuais da aplicação Motando."
    parent_compartment_id = module.cmp_motando.id
}

#-------------------
# motando/nosql
#-------------------

module "cmp_motando-nosql" {
    source = "./modules/iam/compartment"

    providers = {
       oci = oci.home_region
    }

    name = "cmp-nosql"         
    description = "Compartimento para hospedar os recursos NoSQL da aplicação Motando."
    parent_compartment_id = module.cmp_motando.id
}

#-------------------
# motando/oke
#-------------------

module "cmp_motando-oke" {
    source = "./modules/iam/compartment"

    providers = {
       oci = oci.home_region
    }

    name = "cmp-oke"         
    description = "Compartimento para hospedar Kubernetes clusters da aplicação Motando."
    parent_compartment_id = module.cmp_motando.id
}