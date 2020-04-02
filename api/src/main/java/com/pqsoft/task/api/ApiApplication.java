package com.pqsoft.task.api;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import com.pqsoft.task.api.dao.UserRepository;
import com.pqsoft.task.api.model.User;
import com.pqsoft.task.api.utils.FirebaseTokenVerifier;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import javax.annotation.PostConstruct;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

@Slf4j
@SpringBootApplication
public class ApiApplication {

  @Autowired
  private UserRepository userRepository;

  @PostConstruct
  void started() throws IOException {
    log.info("INIT FIREBASE");
    final InputStream serviceAccount =
        FirebaseTokenVerifier.class.getResourceAsStream("/phapquangmedia.json");

    final FirebaseOptions options =
        new FirebaseOptions.Builder()
            .setCredentials(GoogleCredentials.fromStream(serviceAccount))
            .setDatabaseUrl("https://phapquangmedia.firebaseio.com")
            .build();
    FirebaseApp.initializeApp(options);

    List<User> users = userRepository.findAll();
    for (User user : users) {
      KeySpace.SPACES.put(user.getApiKey(), user.getId());
    }
  }

  public static void main(String[] args) {
    SpringApplication.run(ApiApplication.class, args);
  }

}
