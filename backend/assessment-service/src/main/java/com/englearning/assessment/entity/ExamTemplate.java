package com.englearning.assessment.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.util.UUID;

@Entity
@Table(name = "exam_templates")
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ExamTemplate {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @Column(nullable = false)
    private String title;

    @Column(nullable = false)
    private String level; // LOW, MEDIUM, HIGH

    private Integer durationSec;

    private Long tenantId; // For multi-tenant support
}
