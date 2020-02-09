package com.pqsoft.task.api.model;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;

@Getter
@Setter
@Entity(name = "users")
public class User {
  public static final int ACTIVE = 1;
  public static final int INACTIVE = 0;

  @Id
  @Column(name = "user_id")
  private int id;

  private String firstName;
  private String lastName;
  private String email;

  private int status;
  private boolean admin;
}