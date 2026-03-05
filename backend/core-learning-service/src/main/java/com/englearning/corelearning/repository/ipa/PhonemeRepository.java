package com.englearning.corelearning.repository.ipa;

import com.englearning.corelearning.entity.ipa.Phoneme;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface PhonemeRepository extends JpaRepository<Phoneme, UUID> {
    Optional<Phoneme> findBySymbol(String symbol);

    List<Phoneme> findByIsVowelTrue();

    List<Phoneme> findByIsConsonantTrue();

    List<Phoneme> findByIsMonophthongsTrue();

    List<Phoneme> findByIsDiphthongsTrue();
}
