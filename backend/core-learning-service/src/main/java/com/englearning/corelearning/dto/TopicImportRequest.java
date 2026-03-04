package com.englearning.corelearning.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class TopicImportRequest {
    private String topic;
    private String description;
    private String difficulty;
    private List<VocabItemDTO> nouns;
    private List<VocabItemDTO> adjectives;
    private List<VocabItemDTO> verbs;
    private List<VocabItemDTO> compound_nouns;
    private List<VocabItemDTO> phrases_with_mind;
}
