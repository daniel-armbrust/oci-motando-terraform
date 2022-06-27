#!/bin/bash
#
# scripts/del_bucket_data.sh
#
#    Script que deleta todo o conteúdo de um Bucket especificado.
#

BUCKET_NAME="$1"

if [ \( -z "$BUCKET_NAME" \) ]; then
   exit 1
fi

oci os object bulk-delete \
    --bucket-name "$BUCKET_NAME" \
    --force
    
exit $?