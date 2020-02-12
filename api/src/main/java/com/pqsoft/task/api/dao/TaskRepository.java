package com.pqsoft.task.api.dao;

import com.pqsoft.task.api.model.Task;
import org.springframework.data.jpa.repository.JpaRepository;

public interface TaskRepository extends JpaRepository<Task, Integer> {
}
