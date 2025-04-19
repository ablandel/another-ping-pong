package github.ablandel.anotherping

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication
import org.springframework.scheduling.annotation.EnableScheduling

@EnableScheduling
@SpringBootApplication
class AnotherPingApplication

fun main(args: Array<String>) {
    runApplication<AnotherPingApplication>(*args)
}
