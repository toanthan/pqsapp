package com.pqsoft.task.api.controller;

import com.pqsoft.task.api.KeySpace;
import com.pqsoft.task.api.dao.ReportRepository;
import com.pqsoft.task.api.dao.UserRepository;
import com.pqsoft.task.api.dto.ReportDto;
import com.pqsoft.task.api.model.Report;
import com.pqsoft.task.api.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Date;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

@RestController
@ResponseBody
@RequestMapping(value = "/tasks")
public class TaskController {
  private final ReportRepository reportRepository;
  private final UserRepository userRepository;

  @Autowired
  public TaskController(ReportRepository reportRepository, UserRepository userRepository) {
    this.reportRepository = reportRepository;
    this.userRepository = userRepository;
  }

  @GetMapping(value = "/{userId}/{key}")
  public List<ReportDto> listByUser(@PathVariable(value = "userId") int userId, @PathVariable(value = "key") String key) {
    if (!KeySpace.SPACES.containsKey(key)
        || KeySpace.SPACES.get(key) != userId) {
      throw new RuntimeException("Invalid key");
    }

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
  @PostMapping(value = "/{userId}/{key}")
  public ReportDto save(@PathVariable(value = "userId") int userId, @PathVariable(value = "key") String key, @RequestBody ReportDto dto) {
    if (!KeySpace.SPACES.containsKey(key)
        || KeySpace.SPACES.get(key) != userId) {
      throw new RuntimeException("Invalid key");
    }

    User user = userRepository.getOne(userId);
    Report report;
    if (Objects.isNull(dto.getId())) {
      // create new Report object
      report = new Report();
      report.setTitle(dto.getTitle());
      report.setDescription(dto.getDescription());
      report.setCreatedAt(new Date());
      report.setCreator(user);
    } else {
      report = reportRepository.getOne(dto.getId());
      report.setTitle(dto.getTitle());
      report.setDescription(dto.getDescription());
    }

    // save to db
    reportRepository.save(report);
    return dto;
  }

  private ReportDto convert(Report item) {
    return new ReportDto(item);
  }
}
