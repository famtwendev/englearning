package com.englearning.corelearning.entity.ipa;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.util.UUID;

@Entity
@Table(name = "ipa_confusing_pairs")
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ConfusingPair {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "phoneme_id_1", nullable = false)
    private Phoneme phoneme1;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "phoneme_id_2", nullable = false)
    private Phoneme phoneme2;

    private String note;
}
