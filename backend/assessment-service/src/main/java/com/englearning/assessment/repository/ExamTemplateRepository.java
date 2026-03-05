package com.englearning.assessment.repository;

import com.englearning.assessment.entity.ExamTemplate;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.UUID;

@Repository
public interface ExamTemplateRepository extends JpaRepository<ExamTemplate, UUID> {
}
