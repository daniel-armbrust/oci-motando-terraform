#!/bin/bash
#
# scripts/del_secret.sh
#
#    Script que deleta o SECRET para PULL de imagens contidas no OCIR.
#

MOTANDO_SECRET_NAME="motando-secret"

kubectl delete secret "$MOTANDO_SECRET_NAME"

exit 0