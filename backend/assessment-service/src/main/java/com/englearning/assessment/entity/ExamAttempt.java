package com.englearning.assessment.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Table(name = "exam_attempts")
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ExamAttempt {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @Column(nullable = false)
    private UUID userId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "template_id", nullable = false)
    private ExamTemplate template;

    @Column(nullable = false, length = 20)
    private String status; // INIT, IN_PROGRESS, SUBMITTED

    private LocalDateTime startTime;

    private LocalDateTime endTime;

    private Double totalScore;
}
