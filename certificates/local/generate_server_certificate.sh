#!/bin/bash

mkdir server && cd server || exit 1;

echo "Server certificate generation..."

openssl genrsa -aes256 -passout pass:changeme -out server.pass.key 4096
openssl rsa -passin pass:changeme -in server.pass.key -out server.key
openssl req -new -key server.key -out server.csr -subj "/C=FR/ST=MyServerState/L=MyServerLocality/O=MyServerOrganization/OU=MyServerOrganizationUnit/CN=localhost"

openssl x509 -req -in server.csr -CA ../ca/ca.crt -CAkey ../ca/ca.key -CAcreateserial -out server.crt -days 365 -sha256 -passin pass:changeme
openssl verify -CAfile ../ca/ca.crt server.crt

echo "-> Certificate generation succeed!"

echo "Server keystore and truststore generation..."

openssl pkcs12 -export -in server.crt -inkey server.key -certfile ../ca/ca.crt -name server-alias -out local-server-keystore.p12 -passout pass:changeme && chmod 664 local-server-keystore.p12 && cp local-server-keystore.p12 /tmp
keytool -importcert -alias ca-alias -file ../ca/ca.crt -keystore local-server-truststore.p12 -storetype PKCS12 -storepass changeme -noprompt && cp local-server-truststore.p12 /tmp

echo "-> Server keystore and truststore generation succeed!"
