package com.englearning.assessment.controller;

import com.englearning.assessment.entity.ExamTemplate;
import com.englearning.assessment.service.ExamService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/v1/exams")
@RequiredArgsConstructor
public class ExamController {
    private final ExamService examService;

    @GetMapping("/templates")
    public ResponseEntity<List<ExamTemplate>> getTemplates() {
        return ResponseEntity.ok(examService.getAllTemplates());
    }

    @GetMapping("/templates/{id}")
    public ResponseEntity<ExamTemplate> getTemplate(@PathVariable UUID id) {
        return ResponseEntity.ok(examService.getTemplateById(id));
    }
}
