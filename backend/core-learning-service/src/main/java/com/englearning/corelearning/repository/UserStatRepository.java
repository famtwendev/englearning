package com.englearning.corelearning.repository;

import com.englearning.corelearning.entity.UserStat;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserStatRepository extends JpaRepository<UserStat, Long> {
}
