package org.akouma.stock.kafkaService;

import org.apache.kafka.clients.consumer.ConsumerRecords;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.stereotype.Service;

@Service
public class kafkaconsumerService {

    @KafkaListener(topics = "kafkaTopic", groupId = "id")
    public void consume(ConsumerRecords message) {
        System.out.println("Received Messasge in group - group-id: " + message);
    }

}
