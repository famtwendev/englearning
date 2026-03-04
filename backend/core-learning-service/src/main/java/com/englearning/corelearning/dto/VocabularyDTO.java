package com.englearning.corelearning.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class VocabularyDTO {
    private Long id;
    private Long topicId;
    private String word;
    private String meaning;
    private String ipa;
    private String example;
    private String audioUrl;
    private String partOfSpeech;
    private String difficultyLevel;
}
