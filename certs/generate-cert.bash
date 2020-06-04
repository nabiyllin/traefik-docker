#!/bin/bash
domain=$1

if [[ -n "$domain" ]]; then
  echo "Domain zone: $domain"
  openssl req -x509 -out cert.crt -keyout cert.key \
    -newkey rsa:2048 -nodes -sha256 \
    -subj "/CN=$domain" -extensions EXT -config <( \
    printf "[dn]\nCN=$domain\n[req]\ndistinguished_name = dn\n[EXT]\nsubjectAltName=DNS:$domain\nkeyUsage=digitalSignature\nextendedKeyUsage=serverAuth")
else
    echo "Domain zone is not set as argument."
fi