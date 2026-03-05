package com.englearning.corelearning.controller.ipa;

import com.englearning.corelearning.dto.ApiResponse;
import com.englearning.corelearning.dto.ipa.PhonemeDTO;
import com.englearning.corelearning.entity.ipa.IpaWord;
import com.englearning.corelearning.service.ipa.IpaLearningService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/v1/ipa")
@RequiredArgsConstructor
public class IpaLearningController {
    private final IpaLearningService ipaLearningService;

    @GetMapping("/phonemes")
    public ResponseEntity<ApiResponse<List<PhonemeDTO>>> getAllPhonemes() {
        return ResponseEntity.ok(ApiResponse.success(ipaLearningService.getAllPhonemes()));
    }

    @GetMapping("/phonemes/{id}")
    public ResponseEntity<ApiResponse<PhonemeDTO>> getPhoneme(@PathVariable UUID id) {
        return ResponseEntity.ok(ApiResponse.success(ipaLearningService.getPhonemeById(id)));
    }

    @GetMapping("/phonemes/vowels")
    public ResponseEntity<ApiResponse<List<PhonemeDTO>>> getVowels() {
        return ResponseEntity.ok(ApiResponse.success(ipaLearningService.getVowels()));
    }

    @GetMapping("/phonemes/consonants")
    public ResponseEntity<ApiResponse<List<PhonemeDTO>>> getConsonants() {
        return ResponseEntity.ok(ApiResponse.success(ipaLearningService.getConsonants()));
    }

    @GetMapping("/phonemes/vowels/monophthongs")
    public ResponseEntity<ApiResponse<List<PhonemeDTO>>> getMonophthongs() {
        return ResponseEntity.ok(ApiResponse.success(ipaLearningService.getMonophthongs()));
    }

    @GetMapping("/phonemes/vowels/diphthongs")
    public ResponseEntity<ApiResponse<List<PhonemeDTO>>> getDiphthongs() {
        return ResponseEntity.ok(ApiResponse.success(ipaLearningService.getDiphthongs()));
    }

    @GetMapping("/phonemes/{id}/words")
    public ResponseEntity<ApiResponse<List<IpaWord>>> getWordsForPhoneme(@PathVariable UUID id) {
        return ResponseEntity.ok(ApiResponse.success(ipaLearningService.getWordsForPhoneme(id)));
    }

    @GetMapping("/words")
    public ResponseEntity<ApiResponse<List<IpaWord>>> getAllWords() {
        return ResponseEntity.ok(ApiResponse.success(ipaLearningService.getAllWords()));
    }
}
