package com.englearning.corelearning.controller;

import com.englearning.corelearning.service.ProgressService;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/progress")
@RequiredArgsConstructor
public class ProgressController {

    private final ProgressService progressService;

    @PostMapping("/update")
    public ResponseEntity<com.englearning.corelearning.dto.ApiResponse<String>> updateProgress(
            @RequestHeader("X-User-Id") Long userId,
            @RequestBody ProgressUpdateRequest request) {
        progressService.recordQuizAttempt(
                userId,
                request.getVocabId(),
                request.isCorrect(),
                request.getResponseTime());
        return ResponseEntity
                .ok(com.englearning.corelearning.dto.ApiResponse.success(null, "Progress recorded successfully"));
    }

    @Data
    public static class ProgressUpdateRequest {
        private Long vocabId;
        private boolean isCorrect;
        private int responseTime;
    }
}
