#!/bin/sh

openssl genrsa -des3 -out ca.key 4096
openssl req -x509 -new -nodes -key ca.key -sha256 -days 365 -out ca.pem
