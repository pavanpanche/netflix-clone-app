package com.example.netflix.backend.controller;

import com.example.netflix.backend.dto.RegisterRequest;
import com.example.netflix.backend.dto.UserDTO;
import com.example.netflix.backend.mapper.UserMapper;
import com.example.netflix.backend.models.User;
import com.example.netflix.backend.service.UserService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/auth")
@RequiredArgsConstructor
public class RegistrationController {

    private final UserService userService;

    @PostMapping("/register")
    public ResponseEntity<UserDTO> register(@Valid @RequestBody RegisterRequest request) {
        User savedUser = userService.registerUser(request);
        UserDTO userDTO = UserMapper.toDTO(savedUser);
        return ResponseEntity.ok(userDTO);
    }

}
