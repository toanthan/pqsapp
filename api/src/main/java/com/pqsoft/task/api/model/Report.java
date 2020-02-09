package com.pqsoft.task.api.model;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.util.Date;

@Getter
@Setter
@Entity(name = "reports")
public class Report {
  @Id
  @Column(name = "report_id")
  private int id;

  private String title;
  private String description;
  private Date createdAt;

  @OneToOne
  @JoinColumn(name = "creator_id")
  private User creator;
}
