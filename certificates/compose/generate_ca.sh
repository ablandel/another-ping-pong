#!/bin/bash

mkdir ca && cd ca || exit 1;

echo "CA certificate generation..."

openssl genrsa -aes256 -passout pass:changeme -out ca.pass.key 4096
openssl rsa -passin pass:changeme -in ca.pass.key -out ca.key
openssl req -new -x509 -days 365 -subj "/C=FR/ST=MyCAState/L=MyCALocality/O=MyCAOrganization/OU=MyCAOrganizationUnit/CN=MyCACommonName" -key ca.key -out ca.crt

cp ca.crt /tmp/compose-ca.crt

echo "-> Certificate generation succeed!"