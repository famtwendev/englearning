package com.englearning.corelearning.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class VocabItemDTO {
    private String word;
    private String type;
    private String ipa;
    private String example;
    private String meaning;
}
