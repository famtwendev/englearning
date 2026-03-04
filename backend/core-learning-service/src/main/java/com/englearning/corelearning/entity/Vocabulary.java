package com.englearning.corelearning.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "vocabularies")
@com.fasterxml.jackson.annotation.JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
public class Vocabulary {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @com.fasterxml.jackson.annotation.JsonIgnore
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "topic_id", nullable = false)
    private Topic topic;

    @Column(nullable = false)
    private String word;

    @Column(nullable = false)
    private String meaning;

    private String ipa;

    @Column(columnDefinition = "TEXT")
    private String example;

    @Column(name = "audio_url")
    private String audioUrl;

    @Column(name = "part_of_speech")
    private String partOfSpeech;

    @Column(name = "difficulty_level")
    private String difficultyLevel; // e.g., easy, medium, hard
}
