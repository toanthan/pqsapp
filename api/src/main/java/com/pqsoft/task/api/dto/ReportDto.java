package com.pqsoft.task.api.dto;

import com.pqsoft.task.api.model.Report;
import com.pqsoft.task.api.utils.DateUtil;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.Instant;
import java.util.Date;

import static java.time.temporal.ChronoUnit.DAYS;

@Getter
@Setter
@NoArgsConstructor
public class ReportDto {
  private Integer id;
  private String createdAt;
  private String title;
  private String shortDesc;
  private String description;

  public ReportDto(Report report) {
    this.id = report.getId();
    this.title = report.getTitle();
    this.description = report.getDescription();
    if(this.description.length() > 100) {
      this.shortDesc = this.description.substring(0, 100);
    } else {
      this.shortDesc = this.description;
    }
    // check date different between current date with report date
    int diff =
        (int) DAYS.between(toResetDate(new Date(report.getCreatedAt().getTime())), toResetDate(new Date()));
    if(diff == 0) { // same date, only show hour/minutes
      createdAt = DateUtil.format(report.getCreatedAt(), "HH:mm");
    } else if(diff == 1) {
      createdAt = "Yesterday";
    } else if(diff > 1 && diff < 7) {
      createdAt = String.format("%s days ago", diff);
    } else if(diff == 7) {
      createdAt = "Last week";
    } else {
      createdAt = DateUtil.format(report.getCreatedAt(), "dd-MM-yy");
    }
  }

  private Instant toResetDate(Date date) {
    date.setHours(0);
    date.setMinutes(0);
    date.setSeconds(0);
    return date.toInstant();
  }
}
