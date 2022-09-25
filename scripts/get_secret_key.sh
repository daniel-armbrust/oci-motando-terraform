#!/bin/bash
#
# scripts/get_secret_key.sh
#
#    Script para gerar SECRET_KEY utilizado pela aplicação Motando.
#

secret_key="$(python3 -c 'import secrets ; import base64 ; \
    from datetime import datetime ; \
    token = secrets.token_hex(32) + datetime.now().strftime("%s") ; \
    print(base64.b64encode(token.encode()).decode())')"

echo "{\"secret_key\": \"$secret_key\"}"

exit 0