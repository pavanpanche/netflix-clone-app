package com.example.netflix.backend.repository;

import com.example.netflix.backend.models.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface UserRepository  extends JpaRepository<User, Integer> {

    Optional<User> findByEmail (String email);

    boolean existsByEmail(String email);

}
