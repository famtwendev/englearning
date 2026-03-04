package com.englearning.corelearning.service;

import com.englearning.corelearning.entity.UserStat;
import com.englearning.corelearning.repository.UserStatRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class GamificationService {

    private final UserStatRepository userStatRepository;

    @Transactional
    public UserStat addXp(Long userId, int xpToAdd) {
        UserStat userStat = userStatRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found"));

        int newTotalXp = (userStat.getTotalXp() != null ? userStat.getTotalXp() : 0) + xpToAdd;
        userStat.setTotalXp(newTotalXp);

        // Level formula: level = sqrt(total_xp / 100)
        int newLevel = (int) Math.max(1, Math.floor(Math.sqrt((double) newTotalXp / 100.0)));
        userStat.setLevel(newLevel);

        return userStatRepository.save(userStat);
    }

    @Transactional
    public UserStat updateStreak(Long userId, boolean isConsecutiveDay) {
        UserStat userStat = userStatRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found"));

        if (isConsecutiveDay) {
            userStat.setStreak((userStat.getStreak() != null ? userStat.getStreak() : 0) + 1);
        } else {
            userStat.setStreak(1);
        }
        return userStatRepository.save(userStat);
    }
}
