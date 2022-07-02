#!/bin/bash
#
# scripts/del_kubectl_config.sh
#
#    Script que remove o diretório de configuração do kubectl.
#

KUBECTL_CONFIG_HOME="$HOME/.kube"
KUBECTL_CONFIG_FILE="$KUBECTL_CONFIG_HOME/config"

test -d "$KUBECTL_CONFIG_HOME" && rm -rf "$KUBECTL_CONFIG_HOME"

exit 0