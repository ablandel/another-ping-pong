package github.ablandel.anotherping.config

import org.springframework.beans.factory.annotation.Value
import org.springframework.boot.autoconfigure.web.client.RestClientSsl
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.web.client.RestClient

@Configuration
class RestClientConfig(
    private val restClientBuilder: RestClient.Builder,
    private val restClientSsl: RestClientSsl,
    @param:Value("\${pong-server.base-url}") private val baseUrl: String,
) {
    @Bean
    fun restClient(): RestClient =
        restClientBuilder
            .baseUrl(baseUrl)
            .apply(restClientSsl.fromBundle("mtls-bundle"))
            .build()
}
