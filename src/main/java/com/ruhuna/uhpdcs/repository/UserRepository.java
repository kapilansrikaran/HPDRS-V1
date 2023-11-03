package com.ruhuna.uhpdcs.repository;
// Spring Data JPA repositories for database access.

import com.ruhuna.uhpdcs.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    User findByUsername(String username);
}