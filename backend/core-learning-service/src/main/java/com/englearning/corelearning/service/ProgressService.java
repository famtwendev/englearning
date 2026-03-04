package com.englearning.corelearning.service;

import com.englearning.corelearning.entity.QuizAttempt;
import com.englearning.corelearning.entity.UserProgress;
import com.englearning.corelearning.entity.Vocabulary;
import com.englearning.corelearning.repository.QuizAttemptRepository;
import com.englearning.corelearning.repository.UserProgressRepository;
import com.englearning.corelearning.repository.VocabularyRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.time.LocalDateTime;

@Service
@RequiredArgsConstructor
public class ProgressService {

    private final UserProgressRepository userProgressRepository;
    private final QuizAttemptRepository quizAttemptRepository;
    private final VocabularyRepository vocabularyRepository;
    private final GamificationService gamificationService;

    @Transactional
    public void recordQuizAttempt(Long userId, Long vocabId, boolean isCorrect, int responseTimeMs) {
        Vocabulary vocab = vocabularyRepository.findById(vocabId).orElseThrow();

        QuizAttempt attempt = QuizAttempt.builder()
                .userId(userId)
                .vocabulary(vocab)
                .isCorrect(isCorrect)
                .responseTime(responseTimeMs)
                .build();
        quizAttemptRepository.save(attempt);

        UserProgress progress = userProgressRepository.findByUserIdAndVocabularyId(userId, vocabId)
                .orElse(UserProgress.builder()
                        .userId(userId)
                        .vocabulary(vocab)
                        .isLearned(false)
                        .accuracy(0.0)
                        .build());

        progress.setLastPracticed(LocalDateTime.now());
        // Simple accuracy update for demo
        double newAccuracy = isCorrect ? 100.0 : 0.0;
        if (progress.getId() != null) {
            newAccuracy = (progress.getAccuracy() + (isCorrect ? 100.0 : 0.0)) / 2;
        }
        progress.setAccuracy(newAccuracy);

        if (newAccuracy > 80.0) {
            progress.setIsLearned(true);
        }
        userProgressRepository.save(progress);

        if (isCorrect) {
            gamificationService.addXp(userId, 10); // Reward 10 XP for correct answer
        }
    }
}
