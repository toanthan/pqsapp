package com.pqsoft.task.api.utils;

import com.google.common.base.Preconditions;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseToken;
import com.pqsoft.task.api.dto.UserTokenInfo;
import lombok.extern.slf4j.Slf4j;

import java.util.Objects;

@Slf4j
public class FirebaseTokenVerifier {

  public UserTokenInfo verify(String tokenStr) throws Exception {
    Preconditions.checkNotNull(tokenStr, "Miss token");

    final FirebaseToken decodedToken = FirebaseAuth.getInstance().verifyIdToken(tokenStr);
    String uid = decodedToken.getUid();
    log.debug("Try to verify token {}", tokenStr);
    if (Objects.nonNull(uid)) {
      final String email = decodedToken.getEmail();
      final boolean emailVerified = decodedToken.isEmailVerified();
      if (!emailVerified) {
        throw new TokenInvalidException(String.format("Email is not verified %s", email));
      }
      return UserTokenInfo.of(email, decodedToken.getName(), decodedToken.getPicture());
    }

    throw new TokenInvalidException(
        String.format(
            "Tried to verify token: %s but not success", tokenStr));
  }
}
