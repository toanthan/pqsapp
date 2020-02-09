package com.pqsoft.task.api.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor(staticName = "of")
public class UserTokenInfo {
  private String email;
  private String name;
  private String picture;
}
