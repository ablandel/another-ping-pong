# Another Ping Pong ( - _- )🏓~🏓( -_ - )

Simple project to test Maven + Kotlin + GraalVM native images + Spring Boot with mTLS.

## Certificates generation

To easier the tests, the certificates can be generated via the scripts defined in the [certificates](certificates)
directory for the local and/or the compose setups. The certificates and keystore/truststore are then copied to the
`/tmp` directory after generation.

## Start the server

The server can be run using `maven`:

```shell
./mvnw -pl another-pong spring-boot:run
```

## Start the client

The server used as client can be run using `maven`:

```shell
./mvnw -pl another-ping spring-boot:run
```

### Docker image build

For the moment, the Docker image are not pushed and need to be locally built.

### Build the images

Build the server image:

```shell
docker build -t another-pong:local -f ./another-pong/Dockerfile .
```

Build the client image:

```shell
docker build -t another-ping:local -f ./another-ping/Dockerfile .
```

### Build the native images

Build the server image:

```shell
./mvnw  -pl another-pong -Pnative -Dspring-boot.build-image.imageName=another-pong:local spring-boot:build-image
```

Build the client image:

```shell
./mvnw -pl another-ping -Pnative -Dspring-boot.build-image.imageName=another-ping:local spring-boot:build-image
```
