package com.englearning.corelearning.controller;

import com.englearning.corelearning.entity.Topic;
import com.englearning.corelearning.entity.Vocabulary;
import com.englearning.corelearning.service.TopicService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.englearning.corelearning.dto.TopicDTO;
import com.englearning.corelearning.dto.VocabularyDTO;
import java.util.List;

@RestController
@RequestMapping("/api/v1/topics")
@RequiredArgsConstructor
public class TopicController {

    private final TopicService topicService;

    @GetMapping
    public ResponseEntity<com.englearning.corelearning.dto.ApiResponse<List<TopicDTO>>> getAllTopics() {
        return ResponseEntity.ok(com.englearning.corelearning.dto.ApiResponse.success(topicService.getAllTopics()));
    }

    @GetMapping("/{id}")
    public ResponseEntity<com.englearning.corelearning.dto.ApiResponse<TopicDTO>> getTopicById(
            @PathVariable("id") Long id) {
        return ResponseEntity.ok(com.englearning.corelearning.dto.ApiResponse.success(topicService.getTopicById(id)));
    }

    @GetMapping("/{id}/practice")
    public ResponseEntity<com.englearning.corelearning.dto.ApiResponse<List<VocabularyDTO>>> getTopicPractice(
            @PathVariable("id") Long id) {
        return ResponseEntity
                .ok(com.englearning.corelearning.dto.ApiResponse.success(topicService.getVocabulariesByTopic(id)));
    }

    @org.springframework.security.access.prepost.PreAuthorize("hasAnyRole('USER', 'ADMIN')")
    @PostMapping("/import/json")
    public ResponseEntity<com.englearning.corelearning.dto.ApiResponse<Topic>> importTopicJson(
            @org.springframework.web.bind.annotation.RequestBody com.englearning.corelearning.dto.TopicImportRequest request) {
        Topic topic = topicService.importTopicJson(request);
        return ResponseEntity
                .ok(com.englearning.corelearning.dto.ApiResponse.success(topic, "Topic imported successfully"));
    }
}
