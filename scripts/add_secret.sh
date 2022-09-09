#!/bin/bash
#
# scripts/add_secret.sh
#
#    Script que adiciona o SECRET para PULL de imagens contidas no OCIR.
#

OCIR_USER="$1"
OCIR_AUTH_TOKEN="$2"
OBJSTR_NAMESPACE="$3"

MOTANDO_SECRET_NAME="motando-secret"
OCIR_SERVER="gru.ocir.io"

kubectl create secret docker-registry "$MOTANDO_SECRET_NAME" \
   --docker-server="$OCIR_SERVER" \
   --docker-username="$OBJSTR_NAMESPACE/$OCIR_USER" \
   --docker-password="$OCIR_AUTH_TOKEN"

exit 0