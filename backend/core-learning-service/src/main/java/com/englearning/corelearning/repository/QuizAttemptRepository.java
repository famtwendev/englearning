package com.englearning.corelearning.repository;

import com.englearning.corelearning.entity.QuizAttempt;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface QuizAttemptRepository extends JpaRepository<QuizAttempt, Long> {
    List<QuizAttempt> findByUserIdAndVocabularyId(Long userId, Long vocabId);
}
