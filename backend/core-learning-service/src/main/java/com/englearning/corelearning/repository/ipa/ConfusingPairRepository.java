package com.englearning.corelearning.repository.ipa;

import com.englearning.corelearning.entity.ipa.ConfusingPair;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.UUID;
import java.util.List;

@Repository
public interface ConfusingPairRepository extends JpaRepository<ConfusingPair, UUID> {
    List<ConfusingPair> findByPhoneme1IdOrPhoneme2Id(UUID phoneme1Id, UUID phoneme2Id);
}
