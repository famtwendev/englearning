package com.englearning.assessment.service.scoring;

import com.englearning.assessment.entity.AttemptAnswer;
import com.englearning.assessment.entity.Question;

public interface QuestionScoringStrategy {
    boolean supports(String questionType);

    /**
     * Calculates the score for a specific question based on the user's answer.
     * 
     * @param question The question containing the JSONB content and correct
     *                 instructions.
     * @param answer   The user's provided answer containing the JSONB response
     *                 data.
     * @return scored AttemptAnswer with populated score and isCorrect flags.
     */
    AttemptAnswer calculateScore(Question question, AttemptAnswer answer);
}
