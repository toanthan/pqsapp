package com.pqsoft.task.api.controller;

import com.pqsoft.task.api.dao.UserRepository;
import com.pqsoft.task.api.dto.UserTokenInfo;
import com.pqsoft.task.api.model.User;
import com.pqsoft.task.api.utils.FirebaseTokenVerifier;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import javax.transaction.Transactional;
import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

@RestController
public class AuthController {

  private final UserRepository userRepository;

  @Autowired
  public AuthController(UserRepository userRepository) {
    this.userRepository = userRepository;
  }

  @ResponseBody
  @Transactional
  @PostMapping("/auth/token")
  public Map<String, Object> verify(@RequestBody String authToken) throws Exception {
    Map<String, Object> result = new HashMap<>();
    final UserTokenInfo tokenInfo = new FirebaseTokenVerifier().verify(authToken);
    User user = userRepository.findByEmail(tokenInfo.getEmail());
    if (Objects.nonNull(user)) {
      user.setAvatar(tokenInfo.getPicture());
      userRepository.save(user);
      result.put("id", user.getId());
      result.put("admin", user.isAdmin());
      return result;
    }

    result.put("id", -1);
    result.put("admin", false);
    return result;
  }
}
