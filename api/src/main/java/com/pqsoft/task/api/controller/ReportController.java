package com.pqsoft.task.api.controller;

import com.pqsoft.task.api.dao.ReportRepository;
import com.pqsoft.task.api.dao.UserRepository;
import com.pqsoft.task.api.dto.ReportDto;
import com.pqsoft.task.api.model.Report;
import com.pqsoft.task.api.model.User;
import org.apache.http.client.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Date;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

@RestController
@ResponseBody
@RequestMapping(value = "/reports")
public class ReportController {
  private final ReportRepository reportRepository;
  private final UserRepository userRepository;

  @Autowired
  public ReportController(ReportRepository reportRepository, UserRepository userRepository) {
    this.reportRepository = reportRepository;
    this.userRepository = userRepository;
  }

  @GetMapping(value = "/{userId}")
  public List<ReportDto> listByUser(@PathVariable(value = "userId") int userId) {
    User user = userRepository.getOne(userId);
    if (user.isAdmin()) {
      return reportRepository.findLatest().stream().map(this::convert).collect(Collectors.toList());
    }
    return reportRepository.findByCreatorIdOrderByCreatedAtDesc(userId).stream().map(this::convert).collect(Collectors.toList());
  }

  /**
   * Request format: http://server/reports/{userId}
   *
   * @param userId from request
   * @param dto    from http post body
   * @return reportModel received
   */
  @PostMapping(value = "/{userId}")
  public ReportDto save(@PathVariable(value = "userId") int userId, @RequestBody ReportDto dto) {
    User user = userRepository.getOne(userId);
    Report report;
    if (Objects.isNull(dto.getId())) {
      // create new Report object
      report = new Report();
      report.setTitle(dto.getTitle());
      report.setDescription(dto.getDescription());
      report.setCreatedAt(parseDate(dto.getCreatedAt()));
      report.setCreator(user);
    } else {
      report = reportRepository.getOne(dto.getId());
      report.setTitle(dto.getTitle());
      report.setCreatedAt(parseDate(dto.getCreatedAt()));
      report.setDescription(dto.getDescription());
    }

    // save to db
    reportRepository.save(report);
    return dto;
  }

  private Date parseDate(String date) {
    return DateUtils.parseDate(date, new String[]{"dd-MM-yyyy"});
  }

  private ReportDto convert(Report item) {
    return new ReportDto(item);
  }
}
