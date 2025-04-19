#!/bin/bash

mkdir client && cd client || exit 1;

echo "Client certificate generation..."

openssl genrsa -aes256 -passout pass:changeme -out client.pass.key 4096
openssl rsa -passin pass:changeme -in client.pass.key -out client.key
openssl req -new -key client.key -out client.csr -subj "/C=FR/ST=MyClientState/L=MyClientLocality/O=MyClientOrganization/OU=MyClientOrganizationUnit/CN=another-pong"

openssl x509 -req -in client.csr -CA ../ca/ca.crt -CAkey ../ca/ca.key -CAcreateserial -out client.crt -days 365 -sha256 -passin pass:changeme

openssl verify -CAfile ../ca/ca.crt client.crt

cp client.crt /tmp/compose-client.crt
chmod 664 client.key && cp client.key /tmp/compose-client.key

echo "-> Certificate generation succeed!"

echo "Client keystore and truststore generation..."

openssl pkcs12 -export -in client.crt -inkey client.key -certfile ../ca/ca.crt -name client-alias -out compose-client-keystore.p12 -passout pass:changeme && chmod 664 compose-client-keystore.p12 && cp compose-client-keystore.p12 /tmp
keytool -importcert -alias ca-alias -file ../ca/ca.crt -keystore compose-client-truststore.p12 -storetype PKCS12 -storepass changeme -noprompt && cp compose-client-truststore.p12 /tmp

echo "-> Client keystore and truststore generation succeed!"