package com.englearning.corelearning.dto.ipa;

import com.englearning.corelearning.entity.ipa.Phoneme;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.UUID;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class PhonemeDTO {
    private UUID id;
    private String symbol;
    private boolean isVowel;
    private boolean isConsonant;
    private boolean isMonophthongs;
    private boolean isDiphthongs;
    private String audioUrl;

    public static PhonemeDTO fromEntity(Phoneme phoneme) {
        if (phoneme == null) {
            return null;
        }
        return PhonemeDTO.builder()
                .id(phoneme.getId())
                .symbol(phoneme.getSymbol())
                .isVowel(phoneme.isVowel())
                .isConsonant(phoneme.isConsonant())
                .isMonophthongs(phoneme.isMonophthongs())
                .isDiphthongs(phoneme.isDiphthongs())
                .audioUrl(phoneme.getAudioUrl())
                .build();
    }
}
