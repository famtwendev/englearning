package com.englearning.corelearning.repository;

import com.englearning.corelearning.entity.UserProgress;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface UserProgressRepository extends JpaRepository<UserProgress, Long> {
    Optional<UserProgress> findByUserIdAndVocabularyId(Long userId, Long vocabId);
}
