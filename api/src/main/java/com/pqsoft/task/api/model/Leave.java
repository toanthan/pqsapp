package com.pqsoft.task.api.model;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.util.Date;

@Getter
@Setter
@Entity(name = "leaves")
public class Leave {
  @Id
  @Column(name = "leave_id")
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private int id;

  private String reason;
  private Date fromDate;
  private Date toDate;

  @OneToOne
  @JoinColumn(name = "creator_id")
  private User creator;

  @OneToOne
  @JoinColumn(name = "approval_id")
  private User approval;
}
