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
  private String createdAtDis;
  private String title;
  private String description;
  private String avatarUrl;

  public ReportDto(Report report) {
    this.id = report.getId();
    this.title = report.getTitle();
    this.description = report.getDescription();
    this.avatarUrl = report.getCreator().getAvatar();
    // check date different between current date with report date
    int diff =
        (int) DAYS.between(toResetDate(new Date(report.getCreatedAt().getTime())), toResetDate(new Date()));
    if (diff == 0) { // same date, only show hour/minutes
      createdAtDis = "Today";
    } else if (diff == 1) {
      createdAtDis = "Yesterday";
    } else if (diff > 1 && diff < 7) {
      createdAtDis = String.format("%s days ago", diff);
    } else if (diff == 7) {
      createdAtDis = "Last week";
    } else {
      createdAtDis = DateUtil.format(report.getCreatedAt(), "dd-MM-yy");
    }
    this.createdAt = DateUtil.format(report.getCreatedAt(), "dd-MM-yyyy");
  }

  private Instant toResetDate(Date date) {
    date.setHours(0);
    date.setMinutes(0);
    date.setSeconds(0);
    return date.toInstant();
  }
}
