package com.englearning.corelearning.service.ipa;

import com.englearning.corelearning.dto.ipa.PhonemeDTO;
import com.englearning.corelearning.entity.ipa.IpaWord;
import com.englearning.corelearning.exception.ResourceNotFoundException;
import com.englearning.corelearning.repository.ipa.ConfusingPairRepository;
import com.englearning.corelearning.repository.ipa.IpaWordRepository;
import com.englearning.corelearning.repository.ipa.PhonemeRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class IpaLearningService {
    private final PhonemeRepository phonemeRepository;
    private final ConfusingPairRepository confusingPairRepository;
    private final IpaWordRepository ipaWordRepository;

    @Transactional(readOnly = true)
    public List<PhonemeDTO> getAllPhonemes() {
        return phonemeRepository.findAll().stream()
                .map(PhonemeDTO::fromEntity)
                .collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public PhonemeDTO getPhonemeById(UUID id) {
        return phonemeRepository.findById(id)
                .map(PhonemeDTO::fromEntity)
                .orElseThrow(() -> new ResourceNotFoundException("Phoneme not found with id: " + id));
    }

    @Transactional(readOnly = true)
    public List<PhonemeDTO> getVowels() {
        return phonemeRepository.findByIsVowelTrue().stream()
                .map(PhonemeDTO::fromEntity)
                .collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public List<PhonemeDTO> getConsonants() {
        return phonemeRepository.findByIsConsonantTrue().stream()
                .map(PhonemeDTO::fromEntity)
                .collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public List<PhonemeDTO> getMonophthongs() {
        return phonemeRepository.findByIsMonophthongsTrue().stream()
                .map(PhonemeDTO::fromEntity)
                .collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public List<PhonemeDTO> getDiphthongs() {
        return phonemeRepository.findByIsDiphthongsTrue().stream()
                .map(PhonemeDTO::fromEntity)
                .collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public List<IpaWord> getWordsForPhoneme(UUID phonemeId) {
        // Option to validate phoneme exists
        if (!phonemeRepository.existsById(phonemeId)) {
            throw new ResourceNotFoundException("Phoneme not found with id: " + phonemeId);
        }
        return ipaWordRepository.findByPrimaryPhonemeId(phonemeId);
    }

    @Transactional(readOnly = true)
    public List<IpaWord> getAllWords() {
        return ipaWordRepository.findAll();
    }
}
