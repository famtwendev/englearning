package com.englearning.assessment.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.type.SqlTypes;
import java.io.Serializable;
import java.util.UUID;

@Entity
@Table(name = "attempt_answers")
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@IdClass(AttemptAnswerId.class)
public class AttemptAnswer {
    @Id
    @Column(name = "attempt_id")
    private UUID attemptId;

    @Id
    @Column(name = "question_id")
    private UUID questionId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "attempt_id", insertable = false, updatable = false)
    private ExamAttempt attempt;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "question_id", insertable = false, updatable = false)
    private Question question;

    @JdbcTypeCode(SqlTypes.JSON)
    @Column(columnDefinition = "jsonb", nullable = false)
    private String answerData;

    private Boolean isCorrect;

    private Double score;

    @JdbcTypeCode(SqlTypes.JSON)
    @Column(columnDefinition = "jsonb")
    private String feedback; // For AI feedback later
}

class AttemptAnswerId implements Serializable {
    private UUID attemptId;
    private UUID questionId;
}
