package org.akouma.stock.kafkaService;

import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.stereotype.Service;
import org.akouma.stock.util.kakaConfig;

@Service
public class CathConsumerService {
//    private final  String TOPIC = kakaConfig.cathTopic;

    @KafkaListener(topics = kakaConfig.cathTopic, groupId = "id")
    public void consume(String message) {
        System.out.println("Received Messasge in group - group-id: " + message);
    }
}
