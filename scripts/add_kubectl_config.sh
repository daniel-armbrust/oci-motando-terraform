#!/bin/bash
#
# scripts/add_kubectl_config.sh
#
#    Script que faz o setup das configurações do kubectl para acesso ao
# cluster (API SERVER).
#

OKE_OCID="$1"

KUBECTL_CONFIG_HOME="$HOME/.kube"
KUBECTL_CONFIG_FILE="$KUBECTL_CONFIG_HOME/config"

if [ \( -z "$OKE_OCID" \) -o \( -d "$KUBECTL_CONFIG_HOME" \) ]; then
   exit 1
fi

mkdir -p "$KUBECTL_CONFIG_HOME"

oci ce cluster create-kubeconfig \
    --cluster-id "$OKE_OCID" \
    --file "$KUBECTL_CONFIG_FILE" \
    --region sa-saopaulo-1 \
    --token-version 2.0.0  \
    --kube-endpoint PUBLIC_ENDPOINT

export KUBECONFIG="$KUBECTL_CONFIG_FILE"

exit 0