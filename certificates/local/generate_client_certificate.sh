#!/bin/bash

mkdir client && cd client || exit 1;

echo "Client certificate generation..."

openssl genrsa -aes256 -passout pass:changeme -out client.pass.key 4096
openssl rsa -passin pass:changeme -in client.pass.key -out client.key
openssl req -new -key client.key -out client.csr -subj "/C=FR/ST=MyClientState/L=MyClientLocality/O=MyClientOrganization/OU=MyClientOrganizationUnit/CN=localhost"

openssl x509 -req -in client.csr -CA ../ca/ca.crt -CAkey ../ca/ca.key -CAcreateserial -out client.crt -days 365 -sha256 -passin pass:changeme

openssl verify -CAfile ../ca/ca.crt client.crt

echo "-> Certificate generation succeed!"

echo "Client keystore and truststore generation..."

openssl pkcs12 -export -in client.crt -inkey client.key -certfile ../ca/ca.crt -name client-alias -out local-client-keystore.p12 -passout pass:changeme && chmod 664 local-client-keystore.p12 && cp local-client-keystore.p12 /tmp
keytool -importcert -alias ca-alias -file ../ca/ca.crt -keystore local-client-truststore.p12 -storetype PKCS12 -storepass changeme -noprompt && cp local-client-truststore.p12 /tmp

echo "-> Client keystore and truststore generation succeed!"