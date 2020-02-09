package com.pqsoft.task.api.dao;

import com.pqsoft.task.api.model.Report;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface ReportRepository extends JpaRepository<Report, Integer> {
  List<Report> findByCreatorIdOrderByCreatedAtDesc(int userId);

  @Query("FROM reports ORDER BY createdAt DESC")
  List<Report> findLatest();
}
