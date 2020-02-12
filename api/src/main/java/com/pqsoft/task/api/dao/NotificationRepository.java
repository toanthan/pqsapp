package com.pqsoft.task.api.dao;

import com.pqsoft.task.api.model.Notification;
import org.springframework.data.jpa.repository.JpaRepository;

public interface NotificationRepository extends JpaRepository<Notification, Integer> {
}
