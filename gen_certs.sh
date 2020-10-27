#!/bin/sh

if [ "$#" -ne 2 ]
then
  echo "Usage: Must supply a domain and output file"
  exit 1
fi

DOMAIN=$1
OUT=$2

openssl genrsa -out $OUT.key 2048
openssl req -new -key $OUT.key -out $OUT.csr

cat > $OUT.ext << EOF
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names
[alt_names]
DNS.1 = $DOMAIN
EOF

openssl x509 -req -in $OUT.csr -CA ca.pem -CAkey ca.key -CAcreateserial \
-out $OUT.crt -days 365 -sha256 -extfile $OUT.ext
