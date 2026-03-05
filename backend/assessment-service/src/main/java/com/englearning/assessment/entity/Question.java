package com.englearning.assessment.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.type.SqlTypes;
import java.util.UUID;

@Entity
@Table(name = "questions")
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Question {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "template_id", nullable = false)
    private ExamTemplate template;

    @Column(nullable = false, length = 50)
    private String questionType; // e.g. MULTIPLE_CHOICE_SINGLE, FILL_BLANK, SPEAKING

    @JdbcTypeCode(SqlTypes.JSON)
    @Column(columnDefinition = "jsonb", nullable = false)
    private String content; // JSON payload for the dynamic question data

    @Column(nullable = false)
    private Double maxScore = 1.0;

    private Integer orderIndex;
}
