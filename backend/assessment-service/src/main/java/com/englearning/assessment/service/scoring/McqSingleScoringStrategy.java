package com.englearning.assessment.service.scoring;

import com.englearning.assessment.entity.AttemptAnswer;
import com.englearning.assessment.entity.Question;
import org.springframework.stereotype.Component;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Component
public class McqSingleScoringStrategy implements QuestionScoringStrategy {

    @Override
    public boolean supports(String questionType) {
        return "MULTIPLE_CHOICE_SINGLE".equals(questionType);
    }

    @Override
    public AttemptAnswer calculateScore(Question question, AttemptAnswer answer) {
        String content = question.getContent(); // e.g., {"correctOptionId": "A", ...}
        String answerData = answer.getAnswerData(); // e.g., {"selectedOptionId": "A"}

        // In a real application, use Jackson ObjectMapper to parse JSON.
        // For demonstration to avoid Jackson boilerplate here without proper DTOs, a
        // simple check:
        String correctOption = extractJsonValue(content, "correctOptionId");
        String selectedOption = extractJsonValue(answerData, "selectedOptionId");

        boolean correct = correctOption != null && correctOption.equals(selectedOption);

        answer.setIsCorrect(correct);
        answer.setScore(correct ? question.getMaxScore() : 0.0);

        return answer;
    }

    private String extractJsonValue(String json, String key) {
        if (json == null)
            return null;
        Pattern pattern = Pattern.compile("\"" + key + "\"\\s*:\\s*\"([^\"]+)\"");
        Matcher matcher = pattern.matcher(json);
        if (matcher.find()) {
            return matcher.group(1);
        }
        return null;
    }
}
