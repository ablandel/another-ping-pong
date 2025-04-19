package github.ablandel.anotherping.config

import org.springframework.beans.factory.annotation.Value
import org.springframework.boot.autoconfigure.web.client.RestClientSsl
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.web.client.RestClient

@Configuration
class RestClientConfig(
    private val restClientSsl: RestClientSsl,
    @Value("\${pong-server.base-url}") private val baseUrl: String,
) {
    @Bean
    fun restClient(): RestClient =
        RestClient
            .builder()
            .baseUrl(baseUrl)
            .apply(restClientSsl.fromBundle("mtls-bundle"))
            .build()
}
