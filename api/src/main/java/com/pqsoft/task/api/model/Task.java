package com.pqsoft.task.api.model;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.util.Date;

@Getter
@Setter
@Entity(name = "tasks")
public class Task {
  @Id
  @Column(name = "task_id")
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private int id;

  private String title;
  private String description;
  private Date createdAt;

  @OneToOne
  @JoinColumn(name = "creator_id")
  private User creator;

  @OneToOne
  @JoinColumn(name = "assignee_id")
  private User assignee;
}
