package github.ablandel.anotherping.scheduler

import io.github.oshai.kotlinlogging.KotlinLogging
import io.micrometer.tracing.Tracer
import org.springframework.scheduling.annotation.Scheduled
import org.springframework.stereotype.Component
import org.springframework.web.client.RestClient

private val logger = KotlinLogging.logger {}

@Component
class RequestScheduler(
    private val restClient: RestClient,
    private val tracer: Tracer,
) {
    @Scheduled(fixedRate = 5_000)
    fun sendRequest() {
        val newSpan = tracer.nextSpan().name("scheduled task")
        logger.info { "Sending new request to the server with mTLS... 🏓" }
        tracer.withSpan(newSpan.start()).use { ws ->
            try {
                restClient
                    .get()
                    .uri("/api/v1/pong")
                    .retrieve()
                    .body(String::class.java)
                logger.info { "...the request to the server succeed! 🏓" }
            } catch (e: Exception) {
                logger.error {
                    "...the request to the server failed. Exception: `$e` }"
                }
                newSpan.error(e)
            }
        }
        newSpan.end()
    }
}
