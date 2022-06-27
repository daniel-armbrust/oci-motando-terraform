#!/bin/bash
#
# scripts/add_bucket_data.sh
#
#    Script que copia arquivos JSON do diretório especificado para o Bucket
# especificado.
#

BUCKET_NAME="$1"
SRC_DIR="$2"

if [ \( -z "$BUCKET_NAME" \) -o \( -z "$SRC_DIR" \) ]; then
   exit 1
elif [ ! -d "$SRC_DIR" ]; then
   exit 1
fi

oci os object bulk-upload \
    --bucket-name "$BUCKET_NAME" \
    --src-dir "$SRC_DIR"  \
    --content-type "application/json" \
    --overwrite \
    --verify-checksum 
    
exit $?