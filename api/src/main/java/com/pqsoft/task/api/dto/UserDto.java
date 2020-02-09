package com.pqsoft.task.api.dto;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Builder(builderMethodName = "of")
public class UserDto {
  private int id;
}
