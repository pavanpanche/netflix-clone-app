package com.example.netflix.backend.service;
import com.example.netflix.backend.dto.RegisterRequest;
import com.example.netflix.backend.models.User;

import java.util.List;

public interface UserService {

    User registerUser(RegisterRequest request);
    User getUserByEmail(String email);
    List<User> getAllUsers();
}
