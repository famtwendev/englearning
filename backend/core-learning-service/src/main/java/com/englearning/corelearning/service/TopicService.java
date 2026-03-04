package com.englearning.corelearning.service;

import com.englearning.corelearning.entity.Topic;
import com.englearning.corelearning.entity.Vocabulary;
import com.englearning.corelearning.repository.TopicRepository;
import com.englearning.corelearning.repository.VocabularyRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import java.util.stream.Collectors;
import com.englearning.corelearning.dto.TopicDTO;
import com.englearning.corelearning.dto.VocabularyDTO;
import java.util.List;

@Service
@RequiredArgsConstructor
public class TopicService {

    private final TopicRepository topicRepository;
    private final VocabularyRepository vocabularyRepository;

    @org.springframework.transaction.annotation.Transactional(readOnly = true)
    public List<TopicDTO> getAllTopics() {
        return topicRepository.findAll().stream()
                .map(this::mapToTopicDTO)
                .collect(Collectors.toList());
    }

    @org.springframework.transaction.annotation.Transactional(readOnly = true)
    public TopicDTO getTopicById(Long id) {
        Topic topic = topicRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Topic not found"));
        return mapToTopicDTO(topic);
    }

    @org.springframework.transaction.annotation.Transactional(readOnly = true)
    public List<VocabularyDTO> getVocabulariesByTopic(Long topicId) {
        return vocabularyRepository.findByTopicId(topicId).stream()
                .map(this::mapToVocabDTO)
                .collect(Collectors.toList());
    }

    @org.springframework.transaction.annotation.Transactional
    public Topic importTopicJson(com.englearning.corelearning.dto.TopicImportRequest request) {
        Topic topic = topicRepository.findByName(request.getTopic()).orElseGet(() -> {
            Topic newTopic = Topic.builder()
                    .name(request.getTopic())
                    .description(request.getDescription())
                    .difficulty(request.getDifficulty())
                    .build();
            return topicRepository.save(newTopic);
        });

        java.util.List<com.englearning.corelearning.dto.VocabItemDTO> allVocabs = new java.util.ArrayList<>();
        if (request.getNouns() != null)
            allVocabs.addAll(request.getNouns());
        if (request.getAdjectives() != null)
            allVocabs.addAll(request.getAdjectives());
        if (request.getVerbs() != null)
            allVocabs.addAll(request.getVerbs());
        if (request.getCompound_nouns() != null)
            allVocabs.addAll(request.getCompound_nouns());
        if (request.getPhrases_with_mind() != null)
            allVocabs.addAll(request.getPhrases_with_mind());

        for (com.englearning.corelearning.dto.VocabItemDTO dto : allVocabs) {
            if (!vocabularyRepository.existsByTopicIdAndWord(topic.getId(), dto.getWord())) {
                Vocabulary vocab = Vocabulary.builder()
                        .topic(topic)
                        .word(dto.getWord())
                        .meaning(dto.getMeaning())
                        .ipa(dto.getIpa())
                        .example(dto.getExample())
                        .partOfSpeech(dto.getType())
                        .difficultyLevel(topic.getDifficulty())
                        .build();
                vocabularyRepository.save(vocab);
            }
        }
        return topic;
    }

    private TopicDTO mapToTopicDTO(Topic topic) {
        return TopicDTO.builder()
                .id(topic.getId())
                .name(topic.getName())
                .description(topic.getDescription())
                .difficulty(topic.getDifficulty())
                .build();
    }

    private VocabularyDTO mapToVocabDTO(Vocabulary vocab) {
        return VocabularyDTO.builder()
                .id(vocab.getId())
                .topicId(vocab.getTopic().getId())
                .word(vocab.getWord())
                .meaning(vocab.getMeaning())
                .ipa(vocab.getIpa())
                .example(vocab.getExample())
                .audioUrl(vocab.getAudioUrl())
                .partOfSpeech(vocab.getPartOfSpeech())
                .difficultyLevel(vocab.getDifficultyLevel())
                .build();
    }
}
