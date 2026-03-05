package com.englearning.assessment.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.Map;
import java.util.UUID;

@RestController
@RequestMapping("/api/v1/analytics")
@RequiredArgsConstructor
public class AnalyticsController {

    @GetMapping("/radar/{userId}")
    public ResponseEntity<Map<String, Double>> getUserRadarChart(@PathVariable UUID userId) {
        // Mocking radar chart endpoint fetching flattened metrics per tag
        // In a real scenario, this queries a materialized view or aggregation table
        Map<String, Double> radarData = Map.of(
                "GRAMMAR", 85.0,
                "VOCABULARY", 70.0,
                "PRONUNCIATION", 65.0,
                "INFERENCE", 90.0);
        return ResponseEntity.ok(radarData);
    }
}
