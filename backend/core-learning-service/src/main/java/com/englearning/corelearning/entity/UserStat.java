package com.englearning.corelearning.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.time.LocalDateTime;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "users")
public class UserStat {
    // Sharing the 'users' table from identity-service to only read/update
    // gamification stats.

    @Id
    private Long id;

    @Column(name = "total_xp")
    private Integer totalXp;

    private Integer level;

    private Integer streak;

    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;
}
