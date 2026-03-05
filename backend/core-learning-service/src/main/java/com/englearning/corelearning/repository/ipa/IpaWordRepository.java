package com.englearning.corelearning.repository.ipa;

import com.englearning.corelearning.entity.ipa.IpaWord;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.UUID;
import java.util.List;

@Repository
public interface IpaWordRepository extends JpaRepository<IpaWord, UUID> {
    List<IpaWord> findByPrimaryPhonemeId(UUID phonemeId);
}
