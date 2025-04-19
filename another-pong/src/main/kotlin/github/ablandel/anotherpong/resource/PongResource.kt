package github.ablandel.anotherpong.resource

import io.github.oshai.kotlinlogging.KotlinLogging
import jakarta.servlet.http.HttpServletRequest
import org.springframework.http.HttpStatus
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.ResponseStatus
import org.springframework.web.bind.annotation.RestController
import java.time.LocalDateTime
import java.time.format.DateTimeFormatter

private val logger = KotlinLogging.logger {}

@RestController
class PongResource {
    @GetMapping("/v1/pong")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    fun pong(request: HttpServletRequest) {
        val formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.SSS")
        val current = LocalDateTime.now().format(formatter)
        logger.info { "New request received at `$current` from `${request.remoteHost}:${request.remotePort}`! 🏓" }
    }
}
