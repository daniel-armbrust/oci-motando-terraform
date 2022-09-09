#!/bin/bash
#
# scripts/add_configmap.sh
#
#    Script que cria o ConfigMap utilizado pela aplicação Motando.
#

CFGMAP_NAME="motando-config"
REGION="sa-saopaulo-1"
REGION_KEY="GRU"
API_HOSTNAME="api.ocibook.local"

# OBJECT STORAGE NAMESPACE
OBJSTG_NAMESPACE="$1"

# NOSQL TABLE COMPARTMENT
NOSQL_CMP="$2"

# KEY MANAGEMENT SYSTEM - CRYPTO ENDPOINT
CRYPTO_ENDPOINT="$3"

# MASTER ENCRYPTION KEY 
MKE_ID="$4"

# CSRF SECRET_KEY ID
CSRF_SECRETKEY_ID="$5"

kubectl create configmap "$CFGMAP_NAME" \
   --from-literal=OBJSTG_NAMESPACE=$OBJSTG_NAMESPACE \
   --from-literal=NOSQL_CMP=$NOSQL_CMP \
   --from-literal=REGION=$REGION \
   --from-literal=REGION_KEY=$REGION_KEY \
   --from-literal=API_HOSTNAME=$API_HOSTNAME \
   --from-literal=CRYPTO_ENDPOINT=$CRYPTO_ENDPOINT \
   --from-literal=MKE_ID=$MKE_ID \
   --from-literal=CSRF_SECRETKEY_ID=$CSRF_SECRETKEY_ID
   
exit 0