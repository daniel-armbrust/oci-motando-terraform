#!/bin/bash
#
# scripts/del_configmap.sh
#
#    Script que deleta o ConfigMap utilizado pela aplicação Motando.
#

CFGMAP_NAME="motando-config"

kubectl delete configmap "$CFGMAP_NAME"

exit 0