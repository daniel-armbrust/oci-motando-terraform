#!/bin/bash
#
# scripts/get_secret_key.sh
#
#    Script para gerar SECRET_KEY utilizado pela aplicação Motando.
#

secret_key="$(python3 -c 'import secrets ; \
    from datetime import datetime ; \
    print(secrets.token_hex(32) + datetime.now().strftime("%s"))')"

echo "{\"secret_key\": \"$secret_key\"}"

exit 0