package com.englearning.corelearning.config;

import com.englearning.corelearning.entity.ipa.Phoneme;
import com.englearning.corelearning.entity.ipa.IpaWord;
import com.englearning.corelearning.repository.ipa.PhonemeRepository;
import com.englearning.corelearning.repository.ipa.IpaWordRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

// Seeder disabled in favor of SQL Migration or external JSON Import
/*
 * @Component
 * 
 * @RequiredArgsConstructor
 * 
 * @Slf4j
 * public class IpaDataSeeder implements CommandLineRunner {
 * 
 * private final PhonemeRepository phonemeRepository;
 * private final IpaWordRepository ipaWordRepository;
 * 
 * @Override
 * 
 * @Transactional
 * public void run(String... args) throws Exception {
 * // Disabled
 * }
 * }
 */
