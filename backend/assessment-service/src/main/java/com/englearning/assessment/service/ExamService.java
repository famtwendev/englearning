package com.englearning.assessment.service;

import com.englearning.assessment.entity.ExamTemplate;
import com.englearning.assessment.repository.ExamTemplateRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class ExamService {
    private final ExamTemplateRepository templateRepository;

    @Transactional(readOnly = true)
    public List<ExamTemplate> getAllTemplates() {
        return templateRepository.findAll();
    }

    @Transactional(readOnly = true)
    public ExamTemplate getTemplateById(UUID id) {
        return templateRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Template not found"));
    }
}
