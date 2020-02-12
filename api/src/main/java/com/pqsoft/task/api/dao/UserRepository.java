package com.pqsoft.task.api.dao;

import com.pqsoft.task.api.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User, Integer> {
  User findByEmail(String email);
}
