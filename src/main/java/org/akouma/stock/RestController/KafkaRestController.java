package org.akouma.stock.RestController;

import org.akouma.stock.kafkaService.kafkaproducerService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class KafkaRestController {

    private kafkaproducerService kafkaproducerService;
    public KafkaRestController(org.akouma.stock.kafkaService.kafkaproducerService kafkaproducerService) {
        this.kafkaproducerService = kafkaproducerService;
    }

    @GetMapping("/kafka")
    public void  getMessage(){

        kafkaproducerService.sendMessage("Hello JESUS @@@@ ");
    }
}
