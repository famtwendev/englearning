package com.englearning.corelearning.repository;

import com.englearning.corelearning.entity.Vocabulary;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface VocabularyRepository extends JpaRepository<Vocabulary, Long> {
    List<Vocabulary> findByTopicId(Long topicId);

    boolean existsByTopicIdAndWord(Long topicId, String word);
}
