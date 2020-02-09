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

import java.util.Objects;

@RestController
public class AuthController {

  private final UserRepository userRepository;

  @Autowired
  public AuthController(UserRepository userRepository) {
    this.userRepository = userRepository;
  }

  @ResponseBody
  @PostMapping("/auth/token")
  public int verify(@RequestBody String authToken) throws Exception {
    final UserTokenInfo tokenInfo = new FirebaseTokenVerifier().verify(authToken);
    User user = userRepository.findByEmail(tokenInfo.getEmail());
    if(Objects.nonNull(user)) {
      return  user.getId();
    }
    return -1;
  }
}
